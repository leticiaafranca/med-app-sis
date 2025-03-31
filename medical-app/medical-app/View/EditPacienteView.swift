//
//  EditPacienteView.swift
//  medical-app
//
//  Created by Letícia França on 30/03/25.
//

import SwiftUI

struct EditPacienteView: View {
    @State var paciente: Paciente
    @StateObject var viewModel = PacienteViewModel()
    @StateObject var consultaViewModel = ConsultaViewModel()
    @State private var showAddConsultaView = false
    @Environment(\.dismiss) var dismiss
    @State private var showAddConsultaSheet = false

    init(paciente: Paciente) {
        self._paciente = State(initialValue: paciente)
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text(String(paciente.nome.prefix(1)))
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                        )
                    VStack(alignment: .leading) {
                        Text(paciente.nome)
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Informações gerais")
                        .fontWeight(.bold)

                    HStack {
                        CampoTituloView(titulo: "Idade", valor: $paciente.idade)
                        CampoTituloViewString(titulo: "Telefone", valor: $paciente.telefone)
                    }

                    CampoTituloViewString(titulo: "Endereço", valor: $paciente.endereco)
                    
                    ConsultasPacienteView(consultaViewModel: consultaViewModel, pacienteId: paciente.id ?? "")
                    
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            consultaViewModel.fetchConsultas()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("+ Adicionar Consulta") {
                    showAddConsultaView.toggle()
                }
                .sheet(isPresented: $showAddConsultaView) {
                    AddConsultaView(pacienteId: paciente.id ?? "", showAddConsultaSheet: $showAddConsultaSheet)
                }
            }
        }
    }
}

#Preview {
    let pacienteExemplo = Paciente(
        id: UUID().uuidString,
        nome: "João da Silva Filgueiras Paiva",
        idade: 30,
        endereco: "Rua Exemplo, 123",
        telefone: "(11) 98765-4321"
    )
    
    return EditPacienteView(paciente: pacienteExemplo)
        .previewLayout(.sizeThatFits)
        .padding()
}
