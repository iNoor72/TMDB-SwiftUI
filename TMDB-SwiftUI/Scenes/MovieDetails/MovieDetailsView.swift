//
//  MovieDetailsView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI
import Alamofire

struct MovieDetailsView: View {
    private let reachability = NetworkReachabilityManager()
    @StateObject var viewModel: MovieDetailsViewModel
    @State private var showNetworkError = false
    
    var body: some View {
        if viewModel.showAlert {
            ErrorView(error: viewModel.thrownError) {
                viewModel.resetError()
                viewModel.fetchMovieDetails()
            }
        } else {
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
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 000))
}
