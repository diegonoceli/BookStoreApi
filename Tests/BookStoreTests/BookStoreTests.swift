import XCTest
@testable import BookStore

final class BookStoreTests: XCTestCase {
    
    func testFetchBooks() {
            let expectation = self.expectation(description: "Fetch books")
            
            let api = BookStore.shared
            api.fetchBooks(query: "ios", maxResults: 10, startIndex: 0) { result in
                switch result {
                case .success(let books):
                    XCTAssertFalse(books.isEmpty, "Fetched books should not be empty")
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    
    func testBookInfoParsing() {
        let bookInfo = BookInfo(volumeInfo: BookDetails(title: "Test Book", authors: ["Author"], description: "Description", imageLinks: nil, buyLink: nil))
        let book = bookInfo.toBook()
        
        XCTAssertEqual(book.title, "Test Book")
        XCTAssertEqual(book.authors, ["Author"])
        XCTAssertEqual(book.description, "Description")
        XCTAssertNil(book.thumbnailURL)
        XCTAssertNil(book.buyLink)
    }
}
