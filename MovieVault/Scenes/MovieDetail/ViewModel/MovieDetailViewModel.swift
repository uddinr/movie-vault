import Foundation

class MovieDetailViewModel{
    
    init(movie: Movie, config: Configuration?) {
        self.id = movie.id
        self.title = movie.title
        self.genres = movie.genres.map {$0.name}
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.revenue = movie.revenue
        self.runtime = movie.runtime
        
        let imageBaseUrl = config?.images.secureBaseURL ?? ServiceConstants.defaultImageUrl
        self.image = URL(string: "\(imageBaseUrl)w500\(movie.posterPath)")
    }
    
    var id: Int
    var title: String
    var genres = [String]()
    var overview: String
    var releaseDate: Date
    var voteAverage: Double
    var revenue: Int
    var runtime: Int
    var image: URL?
}
