//
//  ConsultaViewModel.swift
//  medical-app
//
//  Created by Letícia França on 24/03/25.
//

import SwiftUI

class ConsultaViewModel: ObservableObject {
    @Published var consultas: [Consulta] = []
    @Published var pacientes: [Paciente] = []
    
    func fetchConsultas() {
        guard let url = URL(string: "http://localhost:3000/consultas") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Consulta].self, from: data)
                    DispatchQueue.main.async {
                        self.consultas = decodedData
                        self.pacientes = Array(Set(decodedData.map { $0.paciente }))
                    }
                } catch {
                    print("Erro ao decodificar JSON:", error)
                }
            } else if let error = error {
                print("Erro na requisição:", error)
            }
        }.resume()
    }

    func consultasPorPaciente(pacienteId: String) -> [Consulta] {
        return consultas.filter { $0.paciente.id == pacienteId }
    }
    
    func consultasOrdenadasPorData() -> [Consulta] {
        return consultas.sorted { $0.data > $1.data }
    }
    
    func getUltimaConsultaData(pacienteId: String) -> String? {
        let consultasPaciente = consultas.filter { $0.paciente.id == pacienteId }
        let ultimaConsulta = consultasPaciente.sorted { $0.data > $1.data }.first
        return ultimaConsulta?.data

    }
    
    func deleteConsulta(id: String) {
        guard let url = URL(string: "http://localhost:3000/consultas/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro na requisição de deleção:", error)
                return
            }

            DispatchQueue.main.async {
                self.consultas.removeAll { $0.id == id }
            }
        }.resume()
    }

    func addConsulta(consulta: Consulta) {
        guard let url = URL(string: "http://localhost:3000/consultas") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var consultaSemId = consulta
        consultaSemId.id = nil

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(consultaSemId)
            request.httpBody = data
        } catch {
            print("Erro ao codificar consulta:", error)
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
                    let addedConsulta = try JSONDecoder().decode(Consulta.self, from: data)
                    DispatchQueue.main.async {
                        self.consultas.append(addedConsulta)
                        self.fetchConsultas()
                    }
                } catch {
                    print("Erro ao decodificar resposta:", error)
                }
            }
        }.resume()
    }
}
