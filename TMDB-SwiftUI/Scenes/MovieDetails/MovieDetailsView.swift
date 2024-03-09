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
        ScrollView {
            VStack {
                CacheAsyncImage(url: URL(string: APIConstants.imagesBaseURL.appending(viewModel.movieDetails?.backdropPath ?? "")), content: { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                        
                    //Including error state
                    default:
                        Image(AppConstants.imagePlaceholderName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                    }
                })
                .frame(height: 200)
                
                Text(viewModel.movieDetails?.title ?? "")
                    .font(.headline)
                    .bold()
                
                Text("\(viewModel.movieDetails?.tagline ?? "")")
                
                Spacer()
                
                Text("Released at: " + (viewModel.movieDetails?.releaseDate ?? ""))
                Text(viewModel.movieDetails?.overview ?? "")
                    .padding()
                
                Divider()
                
                Text("Production companies:")
                    .frame(alignment: .leading)
                    .bold()
                
                ForEach(viewModel.productionCompanies, id: \.self) { company in
                    ProductComapnyView(company: company)
                }
                
                Spacer()
            }
        }.navigationTitle(viewModel.movieDetails?.title ?? "")
            .onAppear {
                viewModel.fetchMovieDetails()
            }
            .alert(isPresented: $viewModel.showAlert, error: viewModel.thrownError) {
                Button("Retry") {
                    viewModel.resetError()
                    viewModel.fetchMovieDetails()
                }
                
                Button("Cancel") { }
            }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 000))
}
