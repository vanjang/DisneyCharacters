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
    
    // MARK: - States
    @State private var bottomReached = false
    
    var body: some View {
        VStack {
            // Horizontal view for favorite characters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewItem.favorites) { item in
                        NavigationLink {
                            LazyView(dependencies.detailPageView(id: item.id))
                        } label: {
                            Text(item.title)
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.vertical, 16)
            .frame(height: viewItem.isFavoritesHidden ? 0 : 100)
            
            // Vertical view for all characters
            List(viewItem.characters, id: \.id) { item in
                NavigationLink {
                    LazyView(dependencies.detailPageView(id: item.id))
                } label: {
                    Text(item.title)
                        .frame(height: 100)
                }
                .onAppear {
                    if item.id == viewItem.characters.last?.id {
                        bottomReached = true
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .onChange(of: bottomReached) { bottom in
            if bottom {
                bottomReached = false
                bottomReach()
            }
        }
    }
}

struct OrthogonalListView_Previews: PreviewProvider {
    static var previews: some View {
        OrthogonalListView(viewItem: MainPageListViewItem(favorites: [], isFavoritesHidden: false, characters: []), bottomReach: {})
    }
}
