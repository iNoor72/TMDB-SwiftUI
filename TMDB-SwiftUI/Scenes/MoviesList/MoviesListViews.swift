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
    @State private var showNetworkError = false

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
                showNetworkError = reachability?.isReachable == false
                viewModel.resetError()
                viewModel.fetchMoviesFromAPI()
            }
            .alert(isPresented: $showNetworkError) {
                Alert(title: Text("Error"), message: Text(AppStrings.noNetworkAlertMessage), dismissButton: .default(Text("OK"), action: {
                    showNetworkError = false
                    viewModel.fetchMoviesFromAPI()
                }))
            }
        }
    }
}

#Preview {
    MoviesListViews()
}
