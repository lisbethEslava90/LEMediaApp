//
//  ListMovies.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 22/06/24.
//

import SwiftUI

struct ListMovies: View {
    @Environment(\.colorScheme) var colorScheme
    var title: String
    let movies: [MovieCodable]
    let emptyMessage: String
    let showMovie: (MovieCodable) -> Void
    let widthMovie = 140.0
    let heightMovie = 180.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            ScrollView(.horizontal, showsIndicators: false) {
                if movies.count > 0 {
                    LazyHStack(spacing: 15) {
                        ForEach(movies, id: \.self) { item in
                            VStack {
                                Button {
                                    showMovie(item)
                                } label: {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: widthMovie, height: heightMovie)
                                        .overlay {
                                            if let posterUrl = item.posterUrl {
                                                AsyncImage(url: URL(string: posterUrl)) { phase in
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
                                Text(item.title)
                                    .frame(width: widthMovie, height: 40)
                                    .font(.caption)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: UIScreen.main.bounds.width, height: heightMovie + 40)
                        .overlay {
                            HStack {
                                Spacer()
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.gray)
                                Text(emptyMessage)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                    }
                }
            }
        }
    }
}
