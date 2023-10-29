import Foundation

class MoviesListViewModel{
    
    init(moviesService : MoviesService) {
        self.moviesService = moviesService
    }
    
    func initMoviesList(){
        initConfiguration()
    }
    
    func loadMore(){
        if(self.hasMoreMovies){
            self.currentPage += 1
            getMovies(page: self.currentPage)
        }
    }
    
    func loadMovie(id: Int){
        moviesService.getMovie(id: id) { [weak self] result in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let movie):
                weakSelf.movieDetailLoaded?(movie)
            case .failure(let error):
                weakSelf.handleErrorMessage?(error.localizedDescription)
            }
        }
    }
    
    private func initConfiguration(){
        moviesService.getConfiguration { [weak self] result in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let configuration):
                weakSelf.configuration = configuration
            case .failure(let error):
                weakSelf.handleErrorMessage?(error.localizedDescription)
            }
            
            // although configuration may have not loaded we have a fallback for the image url so continue with loading
            weakSelf.getMovies(page: weakSelf.currentPage)
        }
    }

    private func getMovies(page: Int){
        moviesService.getMovies(page: page) { [weak self] result in
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let moviesResponse):
                weakSelf.processMovies(moviesResponse: moviesResponse)
            case .failure(let error):
                weakSelf.handleErrorMessage?(error.localizedDescription)
            }
        }
    }
    
    private func processMovies(moviesResponse: MoviesResponse){
        // if we are loading page one then either its an initial load or user has refreshed so reset the current movies
        if(moviesResponse.page == 1){
            self.movieViewModels = [MovieCellViewModel]()
        }
        
        self.hasMoreMovies = moviesResponse.page < moviesResponse.totalPages
        self.currentPage = moviesResponse.page
        
        let newCells =  moviesResponse.results.compactMap({MovieCellViewModel(movie: $0, config: self.configuration)})
        movieViewModels.append(contentsOf: newCells)
    }
    
    private let moviesService : MoviesService
    private var currentPage = 1
    private var hasMoreMovies = true
    
    var configuration : Configuration?
    var movieViewModels = [MovieCellViewModel](){
        didSet {
            self.viewModelChanged?()
        }
    }
    
    var viewModelChanged: (()->())?
    var movieDetailLoaded: ((_ movie: Movie)->())?
    var handleErrorMessage: ((_ message: String)->())?
}
