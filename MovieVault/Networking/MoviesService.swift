import Moya

protocol Networkable {
    var provider: MoyaProvider<MoviesAPI> { get }
    
    func getConfiguration(completion: @escaping (Result<Configuration, Error>) -> ())
    func getMovies(page: Int, completion: @escaping (Result<MoviesResponse, Error>) -> ())
    func getMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> ())
}

class MoviesService: Networkable {
    var provider = MoyaProvider<MoviesAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getConfiguration(completion: @escaping (Result<Configuration, Error>) -> ()) {
        request(target: .getConfiguration, completion: completion)
    }
    
    func getMovies(page: Int, completion: @escaping (Result<MoviesResponse, Error>) -> ()) {
        request(target: .getMovies(page: page), completion: completion)
    }
    
    func getMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> ()) {
        request(target: .getMovie(id: id), completion: completion)
    }
}

private extension MoviesService {
    private func request<T: Decodable>(target: MoviesAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let results = try decoder.decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
