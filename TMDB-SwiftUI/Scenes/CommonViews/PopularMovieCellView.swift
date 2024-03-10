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
        HStack {
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
            
            VStack {
                HStack(spacing: 1) {
                    let maxRange = Int((movie?.rating ?? 0) / 2) + 1
                    ForEach(0..<maxRange, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 12, height: 12)
                    }
                }
                
                
                Text("Rating:\n\((movie?.rating ?? 0).removeZerosFromEnd())/10")
                    .frame(alignment: .leading)
            }
        }
    }
}

#Preview {
    PopularMovieCellView(movie: nil)
}
