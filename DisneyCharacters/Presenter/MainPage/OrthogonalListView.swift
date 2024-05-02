//
//  OrthogonalListView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import SwiftUI

struct OrthogonalListView: View {
    // MARK: - Initialisers
    let viewItem: MainPageListViewItem
    let bottomReach: () -> ()

    // MARK: - Enviroment
    @EnvironmentObject private var dependencies: DependencyContainer
    @Environment(\.horizontalViewHeight) var horizontalViewHeight

    // MARK: - States
    @State private var bottomReached = false

    var body: some View {
        List {
            Section("Your favorites") {
                horizontalView
            }

            Section("All characters") {
                verticalView
            }
        }
        .listStyle(GroupedListStyle())
        .onChange(of: bottomReached) { bottom in
            if bottom {
                bottomReached = false
                bottomReach()
            }
        }
    }

    @ViewBuilder
    var horizontalView: some View {
        if viewItem.favorites.isEmpty {
            Text("It's empty.")
                .foregroundColor(.gray)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)

        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewItem.favorites) { item in
                        NavigationLink {
                            LazyView(dependencies.detailPageView(id: item.id))
                        } label: {
                            MainPageFavoriteCell(item: item)
                                .frame(width: horizontalViewHeight * 0.8, height: horizontalViewHeight * 0.8)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .frame(height: viewItem.isFavoritesHidden ? 40 : horizontalViewHeight)
        }
    }

    @ViewBuilder
    var verticalView: some View {
        ForEach(viewItem.characters, id: \.id) { item in
            NavigationLink {
                LazyView(dependencies.detailPageView(id: item.id))
            } label: {
                MainPageListCell(item: item)
                    .frame(height: 70)
            }
            .onAppear {
                if item.id == viewItem.characters.last?.id {
                    bottomReached = true
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct OrthogonalListView_Previews: PreviewProvider {
    static var previews: some View {
        OrthogonalListView(viewItem: MainPageListViewItem(favorites: [], isFavoritesHidden: false, characters: []), bottomReach: {})
    }
}
