//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct MoviesListViews: View {
    @State private var isConnectedToNetwork = true
    @StateObject private var viewModel = MoviesListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.movieViewItems, id: \.self) { movie in
                        let movieDetailsViewModel = MovieDetailsViewModel(movieID: movie.id)
                        NavigationLink(destination: MovieDetailsView(viewModel: movieDetailsViewModel)) {
                            PopularMovieCellView(movie: movie) {
                                self.viewModel.fetchMoviesFromAPI()
                            }
                        }
                    }
                    
                    if viewModel.hasMoreRows {
                        if viewModel.isConnected {
                            Text("Fetching more movies...")
                                .onAppear {
                                    self.viewModel.loadMore()
                                }
                        } else {
                            Text("Trying to connect to network...")
                                .onAppear {
                                    self.viewModel.loadMore()
                                }
                        }
                    }
                }
            }
            .navigationTitle("The Movie Database")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.thrownError?.localizedDescription ?? ""), primaryButton: .default(Text("Retry"), action: {
                    viewModel.resetError()
                    viewModel.fetchMoviesFromAPI()
                }), secondaryButton: .cancel())
            }
        }
    }
}

#Preview {
    MoviesListViews()
}
