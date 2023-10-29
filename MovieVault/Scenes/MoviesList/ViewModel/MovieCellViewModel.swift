import Foundation

class MovieCellViewModel {
    
    init(movie: MovieHeader, config: Configuration?) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        
        let imageBaseUrl = config?.images.secureBaseURL ?? ServiceConstants.defaultImageUrl
        self.image = URL(string: "\(imageBaseUrl)w500\(movie.posterPath)")
    }
    
    var id: Int
    var title: String
    var overview: String
    var releaseDate: Date
    var voteAverage: Double
    var image: URL?
}
