import Moya

enum MoviesAPI {
    case getConfiguration
    case getMovies(page : Int)
    case getMovie(id : Int)
}

extension MoviesAPI: TargetType {
    
    var baseURL : URL{
        return URL(string: ServiceConstants.serviceUrl)!
    }
    
    var path: String {
        switch self {
        case .getConfiguration : return "/3/configuration"
        case .getMovies : return "/3/discover/movie"
        case .getMovie(let id) : return "/3/movie/\(id)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getConfiguration : return ["api_key" : ServiceConstants.apiKey]
        case .getMovies(let page) : return ["api_key" : ServiceConstants.apiKey, "page" : page]
        case .getMovie : return ["api_key" : ServiceConstants.apiKey]
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var method: Method {
        .get
    }
    
}
