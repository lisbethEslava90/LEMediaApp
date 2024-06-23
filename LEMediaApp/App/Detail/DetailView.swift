//
//  DetailView.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import SwiftUI


struct DetailView: View {
    @StateObject var viewModel = DetailViewModel()
    @Environment(\.colorScheme) var colorScheme
    var selectedMovie: MovieResponse

    var body: some View {
        ScrollView {
            VStack {
                VideoView(videoUrl: viewModel.trailer.videoUrl)
                    .frame(height: 300)
                HStack(spacing: 15) {
                    Text(viewModel.popularityMovie)
                        .font(.headline.bold())
                        .foregroundStyle(.green)
                    Text(viewModel.yearMovie)
                        .font(.headline.bold())
                        .foregroundStyle(.gray)
                    Text(viewModel.languageMovie)
                        .font(.headline.bold())
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text(viewModel.overviewTitle)
                        .font(.title3)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .padding(.vertical)
                    Text(viewModel.movie.overview)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
            }
            
            LazyVStack(alignment: .leading) {
                if !viewModel.videos.isEmpty {
                    Text(viewModel.otherVideosTitle)
                        .font(.title3)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .padding([.vertical, .leading])
                }
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 160))
                ], spacing: 10) {
                    ForEach(viewModel.videos, id: \.self) { item in
                        VideoView(videoUrl: item.videoUrl)
                            .frame(height: 160)
                    }
                }
            }
        }
        .onAppear {
            viewModel.configureView(movie: selectedMovie)
        }
    }
}
