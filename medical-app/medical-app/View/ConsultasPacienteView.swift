//
//  ConsultasPacienteView.swift
//  medical-app
//
//  Created by Letícia França on 30/03/25.
//

import SwiftUI

struct ConsultasPacienteView: View {
    @ObservedObject var consultaViewModel: ConsultaViewModel
    var pacienteId: String
    
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
        VStack(alignment: .leading) {
            Text("Consultas")
                .fontWeight(.bold)
                .padding(.top)
            
            if consultaViewModel.consultas.isEmpty {
                Text("Sem consultas registradas.")
                    .foregroundColor(.gray)
            } else {
                ForEach(consultaViewModel.consultas.filter { $0.paciente.id == pacienteId }) { consulta in
                    VStack(alignment: .leading) {
                        Text("Consulta em: \(formatarData(consulta.data))")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text("Descrição: \(consulta.descricao)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

#Preview {
    ConsultasPacienteView(consultaViewModel: ConsultaViewModel(), pacienteId: "1234")
        .previewLayout(.sizeThatFits)
        .padding()
}
