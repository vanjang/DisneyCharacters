//
//  ImageCacheTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 02/05/2024.
//

import XCTest
@testable import DisneyCharacters

//final class ImageCacheTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

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
