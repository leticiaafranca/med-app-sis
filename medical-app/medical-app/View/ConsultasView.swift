//
//  ConsultasView.swift
//  medical-app
//
//  Created by Letícia França on 30/03/25.
//

import SwiftUI

struct ConsultasView: View {
    @StateObject private var consultaViewModel = ConsultaViewModel()
    @State private var pacienteSelecionado: Paciente? = nil
    @State private var ordenarPorData: Bool = true
    @State private var searchText: String = ""

    func formatarData(_ dataString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: dataString) {
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            return formatter.string(from: date)
        }
        return "Data inválida"
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding()

                Toggle("Ordenar por Data (Mais Recentes)", isOn: $ordenarPorData)
                    .padding(.horizontal)

                List {
                    ForEach(filteredConsultas) { consulta in
                        VStack(alignment: .leading) {
                            Text("Paciente: \(consulta.paciente.nome)")
                                .font(.headline)
                            Text("Data: \(formatarData(consulta.data))")
                                .font(.subheadline)
                            Text("Descrição: \(consulta.descricao)")
                                .font(.subheadline)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let consulta = filteredConsultas[index]
                            consultaViewModel.deleteConsulta(id: consulta.id ?? "")
                        }
                    }
                }
                .navigationTitle("Consultas")
                .onAppear {
                    consultaViewModel.fetchConsultas()
                }
            }
        }
    }
    
    private var filteredConsultas: [Consulta] {
        var consultasFiltradas = consultaViewModel.consultas
        
        if !searchText.isEmpty {
            consultasFiltradas = consultasFiltradas.filter {
                $0.paciente.nome.lowercased().contains(searchText.lowercased())
            }
        }
        
        if ordenarPorData {
            consultasFiltradas.sort { consulta1, consulta2 in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                
                guard let data1 = formatter.date(from: consulta1.data),
                      let data2 = formatter.date(from: consulta2.data) else {
                    return false
                }
                
                return data1 > data2
            }
        }

        return consultasFiltradas
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Buscar paciente...", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    Spacer()
                }
            )
            .padding(.horizontal, 10)
    }
}

#Preview {
    ConsultasView()
}
