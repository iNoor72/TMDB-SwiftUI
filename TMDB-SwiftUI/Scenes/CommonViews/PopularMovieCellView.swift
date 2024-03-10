//
//  PopularMovieCellView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import SwiftUI

struct PopularMovieCellView: View {
    var movie: MovieViewItem?
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
                    
                //Including error state
                default:
                    Image(AppConstants.imagePlaceholderName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8.0)
                }
            })
            .frame(width: 200, height: 250)
            
            Text(movie?.title ?? "")
                .bold()
        }
    }
}

#Preview {
    PopularMovieCellView(movie: nil)
}
