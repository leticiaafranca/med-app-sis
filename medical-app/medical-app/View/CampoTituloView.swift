//
//  CampoTituloView.swift
//  medical-app
//
//  Created by Letícia França on 28/03/25.
//

import SwiftUI

struct CampoTituloView: View {
    var titulo: String
    @Binding var valor: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.headline)
                .fontWeight(.bold)
            
                TextField(titulo, value: $valor, format: .number)
                    .keyboardType(.numberPad)
                    .foregroundColor(.primary)

        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
        )
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CampoTituloView(titulo: "Idade", valor: .constant(25))
}
