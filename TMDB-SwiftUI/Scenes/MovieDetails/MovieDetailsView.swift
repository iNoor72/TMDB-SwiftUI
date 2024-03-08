//
//  MovieDetailsView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.up")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding()
            
            HStack {
                Text("\(viewModel.movieDetails?.tagline ?? "")")
                Text(viewModel.movieDetails?.releaseDate ?? "")
            }.padding()
            
            Text(viewModel.movieDetails?.overview ?? "")
            
            Spacer()
            
        }.navigationTitle(viewModel.movieDetails?.title ?? "")
            .onAppear {
                viewModel.fetchMovieDetails()
            }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 000))
}
