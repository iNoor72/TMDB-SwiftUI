//
//  PopularMovieCellView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct PopularMovieCellView: View {
    var movie: Movie?
    var errorClosure: (() -> ())?
    
    var body: some View {
        VStack {
            CacheAsyncImage(url: URL(string: APIConstants.imagesBaseURL.appending(movie?.posterPath ?? "")), content: { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8.0)
                    
                case .failure(let error):
                    ErrorView(error: error) {
                        errorClosure?()
                    }
                    
                //Including error state
                default:
                    Image(AppConstants.imagePlaceholderName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8.0)
                }
            })
            .frame(height: 250)
            
            Text(movie?.title ?? "")
                .bold()
        }
    }
}

#Preview {
    PopularMovieCellView(movie: nil)
}
