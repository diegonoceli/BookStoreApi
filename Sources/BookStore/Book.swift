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

struct Book : Hashable{
    let title: String
    let authors: [String]
    let description: String
    let thumbnailURL: URL?
    let buyLinkURL: URL?
    var isFavorite: Bool
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
            buyLink: buyLink
        )
    }
}





