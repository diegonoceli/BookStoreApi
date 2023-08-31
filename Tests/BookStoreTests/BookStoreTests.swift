//
//  ContentView.swift
//  BookStoreApplication
//
//  Created by Diego Noceli on 28/08/23.
//
import XCTest
@testable import BookStore

class BookStoreTests: XCTestCase {
    var bookStore: BookStore!

    override func setUp() {
        bookStore = BookStore.shared
    }

    override func tearDown() {
        bookStore = nil
    }

    func testFetchBooks() {
        let expectation = self.expectation(description: "Fetch books expectation")
        
        bookStore.fetchBooks(query: "Swift", maxResults: 10, startIndex: 0) { result in
            switch result {
            case .success(let books):
                XCTAssertFalse(books.isEmpty)
                XCTAssertNotNil(books[0].id)
                XCTAssertNotNil(books[0].title)
                XCTAssertNotNil(books[0].authors)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Error fetching books: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
