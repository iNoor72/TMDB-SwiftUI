//
//  ErrorView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct ErrorView: View {
    var error: Error?
    var closure: (() -> ())?
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding()
            
            Text(error?.localizedDescription ?? "Oops! Something wrong happened")
                .padding()
            
            Button("Retry connection") {
                closure?()
            }
            .padding()
            .background {
                Color.blue
            }
            .foregroundColor(.white)
            .cornerRadius(4.0)
        }
    }
}

#Preview {
    ErrorView()
}
