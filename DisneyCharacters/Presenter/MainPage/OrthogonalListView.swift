//
//  OrthogonalListView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import SwiftUI

struct OrthogonalListView: View {
    @EnvironmentObject private var dependencies: DependencyContainer
    
    let viewItem: MainPageListViewItem
//    let cellTap: () -> ()
    
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewItem.favorites) { item in
                        NavigationLink {
//                            dependencies.detailPageView(id: item.id)
                        } label: {
                            Text(item.title)
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                    }
                }
//                .padding(.horizontal, 20)
            }
            // constant 100 어떻게 처리할지
            .frame(height: viewItem.isFavoritesHidden ? 0 : 100)
            
            
            
            List(viewItem.characters, id: \.id) { item in
                ForEach(viewItem.favorites) { item in
                    NavigationLink {
//                        dependencies.detailPageView(id: item.id)
                    } label: {
                        Text(item.title)
                    }

                }
//                Text(item.title)
            }
        }
        .padding()
    }
}


struct OrthogonalListView_Previews: PreviewProvider {
    static var previews: some View {
        OrthogonalListView(viewItem: MainPageListViewItem(favorites: [], isFavoritesHidden: false, characters: []))//, cellTap: {})
    }
}
