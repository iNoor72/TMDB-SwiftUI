//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI
import Alamofire

struct MoviesListViews: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject private var viewModel = MoviesListViewModel()
    @State var showError = false

    var body: some View {
        if !networkMonitor.isConnected {
            ErrorView(error: viewModel.thrownError) {
                viewModel.resetError()
                viewModel.fetchMoviesFromAPI()
            }
        } else {
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
                        
                        if let reachability = NetworkReachabilityManager(), reachability.isReachable {
                            
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
                .onChange(of: networkMonitor.isConnected) {
                    viewModel.resetError()
                    viewModel.fetchMoviesFromAPI()
                    
                }
                .alert(isPresented: $viewModel.showAlert, error: viewModel.thrownError) {
                    Button("Retry") {
                        viewModel.resetError()
                        viewModel.fetchMoviesFromAPI()
                    }
                    
                    Button("Cancel") { }
                }
            }
        }
    }
}

#Preview {
    MoviesListViews()
}
