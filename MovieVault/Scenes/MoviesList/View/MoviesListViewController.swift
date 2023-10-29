import UIKit
import SnapKit

class MoviesListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    private func setupView(){
        self.title = "Discover Movies"
        
        setupTableView()
        
        self.view.addSubview(activityIndicator)
        self.view.addSubview(moviesTbl)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        moviesTbl.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        viewModel.viewModelChanged = { [weak self] () in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                weakSelf.reloadTableView()
                weakSelf.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.movieDetailLoaded = { [weak self] (movie) in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.displayMovieDetail(movie: movie)
            }
        }
        
        viewModel.handleErrorMessage = { [weak self] (message) in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                weakSelf.showAlert(message)
            }
        }
        
        activityIndicator.startAnimating()
        viewModel.initMoviesList()
    }
    
    private func loadMore(){
        activityIndicator.startAnimating()
        viewModel.loadMore()
    }
    
    private func loadMovieDetail(id: Int){
        activityIndicator.startAnimating()
        viewModel.loadMovie(id: id)
    }
    
    private func displayMovieDetail(movie: Movie){
        let movieDetailViewModel = MovieDetailViewModel(movie: movie, config: viewModel.configuration)
        let detailView = MovieDetailViewController(viewModel: movieDetailViewModel)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private let moviesService: MoviesService = MoviesService()
    
    lazy var viewModel: MoviesListViewModel = {
        return MoviesListViewModel(moviesService: moviesService)
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let c = UIActivityIndicatorView()
        c.color = .accentColor
        c.style = .large
        return c
    }()
    
    lazy var moviesTbl: UITableView = {
        let c = UITableView()
        c.separatorColor = .accentColor
        c.backgroundColor = .clear
        c.tableFooterView = UIView()
        return c
    }()
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        moviesTbl.register(MovieCell.self, forCellReuseIdentifier: MovieCell.className)
        moviesTbl.delegate = self
        moviesTbl.dataSource = self
        moviesTbl.estimatedRowHeight = 150
        moviesTbl.rowHeight = UITableView.automaticDimension
    }
    
    func reloadTableView() {
        moviesTbl.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.className, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.setMovie(viewModel: viewModel.movieViewModels[indexPath.row])
        
        if indexPath.row == viewModel.movieViewModels.count - 1 {
            self.loadMore()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loadMovieDetail(id: viewModel.movieViewModels[indexPath.row].id)
    }
}
