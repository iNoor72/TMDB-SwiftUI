//
//  PopularMovieCellView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct PopularMovieCellView: View {
    var movie: Movie?
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(4.0)
            
            VStack {
                Text(movie?.title ?? "")
            }
        }
    }
}

#Preview {
    PopularMovieCellView(movie: nil)
}
