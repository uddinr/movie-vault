import XCTest
@testable import MovieVault

final class MovieVaultTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGetMovies() throws {
        // check list of movies returned
    }

    func testGetMovie(){
        // get movie by id and check properties
    }
    
    private let moviesService: MoviesService = MoviesService()
    
    lazy var viewModel: MoviesListViewModel = {
        return MoviesListViewModel(moviesService: moviesService)
    }()
}
