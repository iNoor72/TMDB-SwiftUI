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
            CacheAsyncImage(url: URL(string: APIConstants.imagesBaseURL.appending(viewModel.movieDetails?.backdropPath ?? "")), content: { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    
                case .failure(let error):
                    Image(AppConstants.imagePlaceholderName)
                        .resizable()
                        .scaledToFit()
                    
                @unknown default:
                    Image(AppConstants.imagePlaceholderName)
                        .resizable()
                        .scaledToFit()
                }
            })
            .frame(height: 150)
            
            Text(viewModel.movieDetails?.title ?? "")
                .font(.headline)
                .bold()
            
            Text("\(viewModel.movieDetails?.tagline ?? "")")
            Text("Released at: " + (viewModel.movieDetails?.releaseDate ?? ""))
            Text(viewModel.movieDetails?.overview ?? "")
                .padding()
            
            Divider()
            
            
            
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
