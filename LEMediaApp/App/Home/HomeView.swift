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
            VStack {
                ListMovies(title: viewModel.popularTitle, movies: viewModel.popularMovies)
                ListMovies(title: viewModel.topRatedTitle, movies: viewModel.topRatedMovies)
                ListMovies(title: viewModel.upcomingTitle, movies: viewModel.upcomingMovies)
            }
            .padding(.vertical)
        }
        .background(Color.gray)
        .onAppear {
            viewModel.configureView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView()
    }
}
