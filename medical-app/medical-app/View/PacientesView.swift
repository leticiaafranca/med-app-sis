//
//  PacientesView.swift
//  medical-app
//
//  Created by Letícia França on 30/03/25.
//

import SwiftUI

struct PacientesView: View {
    @StateObject private var viewModel = PacienteViewModel()
    @StateObject private var consultaViewModel = ConsultaViewModel()
    @State private var nome = ""
    @State private var idade = ""
    @State private var endereco = ""
    @State private var telefone = ""
    
    @State private var showAddPacienteSheet = false
    
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
                List {
                    ForEach(viewModel.pacientes) { paciente in
                        NavigationLink(destination: EditPacienteView(paciente: paciente)) {
                            HStack {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text(String(paciente.nome.prefix(1)))
                                            .foregroundColor(.white)
                                            .bold()
                                    )
                                    .padding(.trailing, 10)
                                
                                VStack(alignment: .leading) {
                                    Text(paciente.nome)
                                        .font(.headline)
                                    
                                    if let ultimaData = consultaViewModel.getUltimaConsultaData(pacienteId: paciente.id ?? "") {
                                        Text("Última consulta: \(formatarData(ultimaData))")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    } else {
                                        Text("Nenhuma consulta encontrada")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let paciente = viewModel.pacientes[index]
                            viewModel.deletePaciente(id: paciente.id!)
                        }
                    }
                }
                .navigationTitle("Pacientes")
                .onAppear {
                    viewModel.fetchPacientes()
                    consultaViewModel.fetchConsultas()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddPacienteSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.body)
                    }
                }
            }
            
            
            .sheet(isPresented: $showAddPacienteSheet) {
                AddPacienteView(showAddPacienteSheet: $showAddPacienteSheet, viewModel: viewModel)
            }
            
        }
    }
}

#Preview {
    PacientesView()
}
