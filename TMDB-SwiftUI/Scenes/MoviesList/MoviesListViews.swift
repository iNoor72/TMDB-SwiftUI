//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI
import Alamofire

struct MoviesListViews: View {
    private let reachability = NetworkReachabilityManager()
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
                    
                    if viewModel.hasMoreRows, let reachability = NetworkReachabilityManager(), reachability.isReachable {
                        Text("Fetching more movies...")
                            .onAppear(perform: {
                                self.viewModel.loadMore()
                            })
                    }
                }
            }
            .navigationTitle("The Movie Database")
            .onChange(of: reachability?.isReachable) {
                viewModel.showAlert = reachability?.isReachable == false
                viewModel.fetchMoviesFromAPI()
            }
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
