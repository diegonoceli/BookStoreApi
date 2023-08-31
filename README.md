# BookStore Library

The BookStore library is a Swift package that provides a convenient way to interact with an external book data source, fetch book information, and manage a list of books. It includes functionality for fetching books from the Google Books API, managing book details, and marking books as favorites.

## Features

- Fetch books from the Google Books API.
- Store and retrieve books, including their details and favorite status.
- Simplify book data management with Swift structs.

## Installation

You can add this library to your Swift project using the Swift Package Manager. To do so, follow these steps:

1. Open your Xcode project.

2. Go to "File" -> "Swift Packages" -> "Add Package Dependency."

3. Enter the URL of this repository: [repository URL].

4. Choose the version or branch you want to use.

5. Click "Next" and complete the installation process.

## Usage

Here's a basic example of how to use the BookStore library:

```swift
import BookStore

// Create a BookStore instance
let bookStore = BookStore.shared

// Fetch books
bookStore.fetchBooks(query: "Swift Programming", maxResults: 10, startIndex: 0) { result in
    switch result {
    case .success(let books):
        // Handle the fetched books
        for book in books {
            print("Title: \(book.title)")
            print("Authors: \(book.authors)")
            // ... Handle other book properties
        }
        
    case .failure(let error):
        // Handle the error
        print("Error fetching books: \(error)")
    }
}
