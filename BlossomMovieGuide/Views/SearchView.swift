//
//  SearchView.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import SwiftUI

struct SearchView: View {
    var titles: [Title] = Title.previewTitles
    @State private var searchByMovies = true
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(titles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                    }
                }
            }
            .navigationTitle(searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                    } label: {
                        Image(systemName: searchByMovies ?
                              Constants.movieIconString :
                                Constants.tvIconString)
                    }
                }
            }
            .searchable(text:  $searchText, prompt: searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
        }
    }
}

#Preview {
    SearchView()
}
