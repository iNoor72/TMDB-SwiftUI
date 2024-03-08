//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct MoviesListViews: View {
    @StateObject private var viewModel = MoviesListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.moviesList) { movie in
                    let movieDetailsViewModel = MovieDetailsViewModel(movieID: movie.id)
                    NavigationLink(destination: MovieDetailsView(viewModel: movieDetailsViewModel)) {
                        PopularMovieCellView(movie: movie)
                    }
                }
            }
            .navigationTitle("The Movie Database")
        }.onAppear {
            viewModel.fetchMoviesFromAPI()
        }
    }
}

#Preview {
    MoviesListViews()
}
