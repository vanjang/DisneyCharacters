//
//  MainPageFavoriteCell.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import SwiftUI

struct MainPageFavoriteCell: View {
    let item: MainPageListItem
    
    var body: some View {
        GeometryReader { geo in
            let size: CGFloat = geo.size.height * 0.8
            let spacing: CGFloat = 4
            
            VStack(spacing: spacing) {
                RemoteImageView(url: item.imageUrl, isCircle: true)
                    .frame(width: size, height: size)
                
                Text(item.title)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
        }
    }
}

struct MainPageFavoriteCell_Previews: PreviewProvider {
    static var previews: some View {
        MainPageFavoriteCell(item: MainPageListItem(id: 0, isFavorite: false, title: "title", imageUrl: nil))
    }
}
