import Foundation

public struct BookStore {
    public static let shared = BookStore()
    
    private let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    
    public typealias BookListCompletion = (Result<[Book], Error>) -> Void
    public typealias BookInfoCompletion = (Result<Book, Error>) -> Void
    
    public func fetchBooks(query: String, maxResults: Int, startIndex: Int, completion: @escaping BookListCompletion) {
        let urlString = "\(baseUrl)?q=\(query)&maxResults=\(maxResults)&startIndex=\(startIndex)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BookListResponse.self, from: data)
                let books = response.items.map { $0.toBook() }
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    public func fetchBook(bookId: String, completion: @escaping BookInfoCompletion){
        let urlString = "\(baseUrl)/\(bookId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BookInfo.self, from: data)
                let book = response.toBook()
                completion(.success(book))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
}
