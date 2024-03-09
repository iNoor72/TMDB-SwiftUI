//
//  ProductComapnyView.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//

import SwiftUI

struct ProductComapnyView: View {
    var company: ProductionCompany
    
    var body: some View {
        CacheAsyncImage(url: URL(string: APIConstants.imagesBaseURL.appending(company.logoPath ?? ""))) { phase in
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
        }
        .frame(width: 200, height: 200)
        .border(.gray, width: 1.0)
        .cornerRadius(8.0)
        .padding()
        
        
        Text(company.name)
    }
}

#Preview {
    ProductComapnyView(company: ProductionCompany(id: 1, logoPath: nil, name: ""))
}
