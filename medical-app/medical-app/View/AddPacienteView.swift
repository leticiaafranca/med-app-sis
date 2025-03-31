//
//  AddPacienteView.swift
//  medical-app
//
//  Created by Letícia França on 26/03/25.
//

import SwiftUI

struct AddPacienteView: View {
    @Binding var showAddPacienteSheet: Bool
    @State private var nome = ""
    @State private var idade = ""
    @State private var endereco = ""
    @State private var telefone = ""
    @ObservedObject var viewModel: PacienteViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Nome do paciente")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)

                TextField("Digite o nome do paciente", text: $nome)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                Text("Idade")
                    .font(.headline)
                    .foregroundColor(.primary)

                TextField("Digite a idade", text: $idade)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))

                Text("Endereço")
                    .font(.headline)
                    .foregroundColor(.primary)

                TextField("Digite o endereço", text: $endereco)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                Text("Telefone")
                    .font(.headline)
                    .foregroundColor(.primary)

                TextField("Digite o telefone", text: $telefone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0))
                    .padding(.bottom)

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Novo Paciente")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        showAddPacienteSheet = false
                    }
                    .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        let paciente = Paciente(id: UUID().uuidString, nome: nome, idade: Int(idade) ?? 0, endereco: endereco, telefone: telefone)
                        viewModel.addPaciente(paciente: paciente)
                        showAddPacienteSheet = false
                        nome = ""
                        idade = ""
                        endereco = ""
                        telefone = ""
                    }
                    .disabled(nome.isEmpty || idade.isEmpty || endereco.isEmpty || telefone.isEmpty)
                    .foregroundColor(nome.isEmpty || idade.isEmpty || endereco.isEmpty || telefone.isEmpty ? .gray : .blue)
                }
            }
        }
    }
}
