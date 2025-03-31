//
//  PacienteViewModel.swift
//  medical-app
//
//  Created by Letícia França on 24/03/25.
//

import SwiftUI

class PacienteViewModel: ObservableObject {
    @Published var pacientes: [Paciente] = []
    
    func fetchPacientes() {
        guard let url = URL(string: "http://localhost:3000/pacientes") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Paciente].self, from: data)
                    DispatchQueue.main.async {
                        self.pacientes = decodedData
                    }
                } catch {
                    print("Erro ao decodificar JSON:", error)
                }
            } else if let error = error {
                print("Erro na requisição:", error)
            }
        }.resume()
    }
    
    func deletePaciente(id: String) {
        guard let url = URL(string: "http://localhost:3000/pacientes/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro na requisição de deleção:", error)
                return
            }
            
            DispatchQueue.main.async {
                self.pacientes.removeAll { $0.id == id }
            }
        }.resume()
    }
    
    func addPaciente(paciente: Paciente) {
        guard let url = URL(string: "http://localhost:3000/pacientes") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var pacienteSemId = paciente
        pacienteSemId.id = nil

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pacienteSemId)
            request.httpBody = data
        } catch {
            print("Erro ao codificar paciente:", error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro na requisição de adição:", error)
                return
            }

            if let data = data {
                if let body = String(data: data, encoding: .utf8) {
                    print("Corpo da resposta:", body)
                }

                do {
                    let addedPaciente = try JSONDecoder().decode(Paciente.self, from: data)
                    DispatchQueue.main.async {
                        self.pacientes.append(addedPaciente)
                        self.fetchPacientes()
                    }
                } catch {
                    print("Erro ao decodificar resposta:", error)
                }
            }
        }.resume()
    }

    func updatePaciente(paciente: Paciente) {
        guard let url = URL(string: "http://localhost:3000/pacientes/\(paciente.id ?? "")") else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var pacienteAtualizado = paciente
        pacienteAtualizado.id = nil

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pacienteAtualizado)
            request.httpBody = data
        } catch {
            print("Erro ao codificar paciente:", error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro na requisição de atualização:", error)
                return
            }

            if let data = data {
                if let body = String(data: data, encoding: .utf8) {
                    print(body)
                }
            }
        }.resume()
    }

}
