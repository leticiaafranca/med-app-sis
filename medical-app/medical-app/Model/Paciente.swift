//
//  Paciente.swift
//  medical-app
//
//  Created by Letícia França on 23/03/25.
//

struct Paciente: Identifiable, Codable, Hashable{
    var id: String?
    var nome: String
    var idade: Int
    var endereco: String
    var telefone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nome
        case idade
        case endereco
        case telefone
    }
}
