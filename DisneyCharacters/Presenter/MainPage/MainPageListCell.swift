//
//  MainPageListCell.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import SwiftUI

struct MainPageListCell: View {
    let item: MainPageListItem
    
    var body: some View {
        GeometryReader { geo in
            let size: CGFloat = geo.size.height * 0.8
            let spacing: CGFloat = 12
            
            HStack(spacing: spacing) {
                RemoteImageView(url: item.imageUrl, isCircle: true)
                    .frame(width: size, height: size)
                
                Text(item.title)
            }
            .padding(.vertical, spacing)
        }
    }
}

struct MainPageListCell_Previews: PreviewProvider {
    static var previews: some View {
        MainPageListCell(item: MainPageListItem(id: 0, isFavorite: false, title: "title", imageUrl: nil))
    }
}
