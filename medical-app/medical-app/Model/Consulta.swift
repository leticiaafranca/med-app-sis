//
//  Untitled.swift
//  medical-app
//
//  Created by Letícia França on 23/03/25.
//

import Foundation

struct Consulta: Identifiable, Codable {
    var id: String?
    var paciente: Paciente
    var data: String
    var descricao: String
    var medico: String
    var especialidade: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case paciente
        case data
        case descricao
        case medico
        case especialidade
    }
}
