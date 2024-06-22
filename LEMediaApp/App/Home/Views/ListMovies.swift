//
//  ListMovies.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 22/06/24.
//

import SwiftUI

struct ListMovies: View {
    var title: String
    let movies: [MovieResponse]
    let widthMovie = 140.0
    let heightMovie = 180.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .foregroundStyle(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    if !movies.isEmpty {
                        ForEach(movies, id: \.self) { item in
                            VStack {
                                Button {
                                    //
                                } label: {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: widthMovie, height: heightMovie)
                                        .overlay {
                                            if let posterUrl = item.posterUrl {
                                                AsyncImage(url: posterUrl) { phase in
                                                    switch phase {
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: widthMovie, height: heightMovie)
                                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    case .failure:
                                                        DefaultMovie(widthM: widthMovie, heightM: heightMovie)
                                                    case .empty:
                                                        ProgressView()
                                                    @unknown default:
                                                        DefaultMovie(widthM: widthMovie, heightM: heightMovie)
                                                    }
                                                    
                                                }
                                                .padding()
                                            } else {
                                                DefaultMovie(widthM: widthMovie, heightM: heightMovie)
                                            }
                                        }
                                }
                                .accentColor(.clear)
                                Text(item.original_title)
                                    .frame(width: widthMovie, height: 40)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            }
                        }
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: widthMovie, height: heightMovie + 40)
                    }
                }
            }
        }
    }
}
