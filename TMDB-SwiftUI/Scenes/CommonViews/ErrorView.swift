//
//  ErrorView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct ErrorView: View {
    var error: Error?
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.red)
                .padding()
            
            Text(error?.localizedDescription ?? "Oops! Something wrong happened")
        }
    }
}

#Preview {
    ErrorView()
}
