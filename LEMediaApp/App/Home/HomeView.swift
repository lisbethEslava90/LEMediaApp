//
//  HomeView.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    TextField(viewModel.searchPlaceholder, text: $viewModel.searchText)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .border(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Spacer()
                                if !viewModel.searchText.isEmpty {
                                    Button(action: {
                                        self.viewModel.searchText = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                } else {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        )
                }
                .padding()
                VStack {
                    ListMovies(title: viewModel.popularTitle, movies: viewModel.filteredPopularMovies, emptyMessage: viewModel.emptyMsg)
                    ListMovies(title: viewModel.topRatedTitle, movies: viewModel.filteredTopRatedMovies, emptyMessage: viewModel.emptyMsg)
                    ListMovies(title: viewModel.upcomingTitle, movies: viewModel.filteredUpcomingdMovies, emptyMessage: viewModel.emptyMsg)
                }
                .padding(.vertical)
            }
        }
        .background(Color(.systemGray6))
        .onAppear {
            viewModel.configureView()
        }
        .onTapGesture {
            UIApplication.shared
                .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView()
    }
}
