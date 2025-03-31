//
//  AddConsultaView.swift
//  medical-app
//
//  Created by Letícia França on 26/03/25.
//

import SwiftUI

struct AddConsultaView: View {
    @Binding var showAddConsultaSheet: Bool
    @State private var data = Date()
    @State private var descricao = ""
    @State private var medico = ""
    @State private var especialidade = ""
    @State private var pacienteId: String
    @Environment(\.dismiss) var dismiss
    @StateObject var consultaViewModel = ConsultaViewModel()

    init(pacienteId: String, showAddConsultaSheet: Binding<Bool>) {
        _pacienteId = State(initialValue: pacienteId)
        _showAddConsultaSheet = showAddConsultaSheet
    }
    private var isFormValid: Bool {
        !descricao.isEmpty && !medico.isEmpty && !especialidade.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Data da consulta")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)
                
                DatePicker("Data da Consulta", selection: $data, displayedComponents: .date)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                
                
                Text("Descrição da consulta")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)

                TextEditor(text: $descricao)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                    .frame(minHeight: 60)

                
                Text("Nome do médico")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)
                
                TextField("Digite o nome do médico", text: $medico)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                
                Text("Especialidade")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)
                
                TextField("Digite a especialidade", text: $especialidade)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Nova Consulta")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        showAddConsultaSheet = false
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        let novaConsulta = Consulta(
                            id: UUID().uuidString,
                            paciente: Paciente(id: pacienteId, nome: "", idade: 0, endereco: "", telefone: ""),
                            data: "\(data)",
                            descricao: descricao,
                            medico: medico,
                            especialidade: especialidade
                        )
                        consultaViewModel.addConsulta(consulta: novaConsulta)
                        print(novaConsulta)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                    .foregroundColor(isFormValid ? .blue : .gray)
                }
            }
        }
    }
}
