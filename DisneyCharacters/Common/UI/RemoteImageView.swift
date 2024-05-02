//
//  RemoteImageView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import SwiftUI

struct RemoteImageView: View {
    let url: URL?
    let isCircle: Bool
    let contentMode: ContentMode
    
    @State private var image: UIImage?

    init(url: URL?, isCircle: Bool, contentMode: ContentMode = .fill) {
        self.url = url
        self.isCircle = isCircle
        self.contentMode = contentMode
        
        loadImage()
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .frame(width: geo.size.width)
                        .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8)))
                } else {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(width: geo.size.width)
                            .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8)))
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
    
    private func loadImage() {
        guard let url = self.url else { return }
        if let i = ImageCache.shared.getImage(for: url) {
            self.image = i
        } else {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let d = data, let image = UIImage(data: d) {
                    ImageCache.shared.setImage(image, for: url)
                }
            }.resume()
        }
    }
}
