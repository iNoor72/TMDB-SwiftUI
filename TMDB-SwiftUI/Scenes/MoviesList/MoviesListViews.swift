//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI
import Alamofire

struct MoviesListViews: View {
    @StateObject private var viewModel = MoviesListViewModel()
    @State var showError = false

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
                    
                    
                    if viewModel.hasMoreRows, let reachability = NetworkReachabilityManager(), reachability.isReachable {
                        Text("Fetching more movies...")
                            .onAppear(perform: {
                                self.viewModel.loadMore()
                            })
                    }
                }
            }
            .navigationTitle("The Movie Database")
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Error!"), message: Text("There was an error getting your data. Error: \(viewModel.thrownError?.localizedDescription ?? "")"), primaryButton: .default(Text("Retry"), action: {
                viewModel.resetError()
                viewModel.fetchMoviesFromAPI()
            }), secondaryButton: .cancel())
        })
    }
}

#Preview {
    MoviesListViews()
}
