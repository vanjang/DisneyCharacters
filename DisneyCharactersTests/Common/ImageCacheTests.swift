//
//  ImageCacheTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 02/05/2024.
//

import XCTest
@testable import DisneyCharacters

final class ImageCacheTests: XCTestCase {
    
    func testSetAndGetImage() {
        // GIVEN
        let cache = ImageCache.shared
        let image = UIImage(named: "test_image")!
        let testImage = UIImage(systemName: "xmark")!
        let imageURL = URL(string: "none_existing_url")!
        
        // WHEN
        cache.setImage(image, for: imageURL)
        let cachedImage = cache.getImage(for: imageURL)
        
        // THEN
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage, image)
        XCTAssertNotEqual(cachedImage, testImage)
    }
    
    func testGetImageForUnsetURL() {
        // GIVEN
        let cache = ImageCache.shared
        let imageURL = URL(string: "https://picsum.photos/200/300")!
        
        // WHEN
        let cachedImage = cache.getImage(for: imageURL)
        
        // THEN
        XCTAssertNil(cachedImage)
    }
}
