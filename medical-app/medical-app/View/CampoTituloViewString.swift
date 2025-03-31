//
//  CampoTituloViewString.swift
//  medical-app
//
//  Created by Letícia França on 28/03/25.
//

import SwiftUI

struct CampoTituloViewString: View {
    var titulo: String
    @Binding var valor: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.headline)
                .fontWeight(.bold)
            
            TextField(titulo, text: $valor)
                .keyboardType(.default)
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
