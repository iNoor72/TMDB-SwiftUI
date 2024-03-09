//
//  PopularMovieCellView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct PopularMovieCellView: View {
    var movie: Movie?
    
    var body: some View {
        HStack {
            CacheAsyncImage(url: URL(string: APIConstants.imagesBaseURL.appending(movie?.backdropPath ?? "")), content: { phase in
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
            .frame(width: 200, height: 200)
                        
            VStack(alignment: .center, spacing: 2) {
                Text(movie?.title ?? "")
            }
        }
    }
}

#Preview {
    PopularMovieCellView(movie: nil)
}
