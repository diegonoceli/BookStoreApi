import Foundation

struct BookListResponse: Codable {
    let items: [BookInfo]
}

struct BookInfo: Codable {
    let volumeInfo: BookDetails
}

struct BookDetails: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    let buyLink: URL?
}

struct ImageLinks: Codable {
    let thumbnail: URL?
}

public struct Book : Hashable{
    public let title: String
    public let authors: [String]
    public let description: String
    public let thumbnailURL: URL?
    public let buyLinkURL: URL?
    public var isFavorite: Bool
}

extension BookInfo {
    func toBook() -> Book {
        let details = self.volumeInfo
        let thumbnailURL = details.imageLinks?.thumbnail
        let buyLink = details.buyLink
        
        return Book(
            title: details.title,
            authors: details.authors ?? [],
            description: details.description ?? "",
            thumbnailURL: thumbnailURL,
            buyLinkURL: buyLink,
            isFavorite: false
        )
    }
}





