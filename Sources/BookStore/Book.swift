import Foundation

struct BookListResponse: Codable {
    let items: [BookInfo]
}

struct BookInfo: Codable {
    let volumeInfo: BookDetails
    let saleInfo: SaleInfo
}

struct SaleInfo: Codable {
    let buyLink: URL?
}

struct BookDetails: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let thumbnail: URL?
}

public struct Book : Codable,Hashable{
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
        let buyLink = self.saleInfo.buyLink
        
        return Book(
            title: details.title,
            authors: details.authors ?? [],
            description: details.description ?? "",
            thumbnailURL: thumbnailURL,
            buyLinkURL: buyLink,
            isFavorite: UserDefaults.standard.bool(forKey: details.title)
        )
    }
}





