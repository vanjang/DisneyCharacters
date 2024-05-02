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
    
    @State private var image: UIImage?
    @State private var errors: String?

    init(url: URL?, isCircle: Bool) {
        self.url = url
        self.isCircle = isCircle
        
        loadImage()
    }

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8)))
            } else {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8)))
                } placeholder: {
                    ProgressView()
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
