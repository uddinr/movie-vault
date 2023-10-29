import Foundation
import UIKit

class MovieDetailViewController: BaseViewController {
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        setupView()
    }
    
    private func setupView(){
        self.title = viewModel.title
        
        posterImg.sd_setImage(with: viewModel.image)
        titleLbl.text = viewModel.title
        releaseDateLbl.text = "Released: \(viewModel.releaseDate.toString())"
        ratingsLbl.text = "Rating: \(String(format: "%.1f", viewModel.voteAverage))/10"
        genresLbl.text = viewModel.genres.joined(separator: " | ")
        revenueLbl.text = "Revenue: $\(viewModel.revenue.withCommas())"
        runtimeLbl.text = "Runtime: \(viewModel.runtime) minutes"
        overviewLbl.text = viewModel.overview
    
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self.view)
        }
        
        contentView.addSubview(posterImg)
        contentView.addSubview(titleLbl)
        contentView.addSubview(releaseDateLbl)
        contentView.addSubview(ratingsLbl)
        contentView.addSubview(genresLbl)
        contentView.addSubview(revenueLbl)
        contentView.addSubview(runtimeLbl)
        contentView.addSubview(overviewLbl)
        
        posterImg.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(1.5)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(posterImg.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        releaseDateLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        ratingsLbl.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        genresLbl.snp.makeConstraints { make in
            make.top.equalTo(ratingsLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        revenueLbl.snp.makeConstraints { make in
            make.top.equalTo(genresLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        runtimeLbl.snp.makeConstraints { make in
            make.top.equalTo(revenueLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        overviewLbl.snp.makeConstraints { make in
            make.top.equalTo(runtimeLbl.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    var viewModel: MovieDetailViewModel
    
    lazy var posterImg: UIImageView = {
        let c = UIImageView()
        c.contentMode = .scaleAspectFit
        return c
    }()
    
    lazy var titleLbl: UILabel = {
        let c = UILabel()
        c.numberOfLines = 0
        c.lineBreakMode = .byWordWrapping
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .navTitleFontSize, weight: .bold)
        c.textColor = .textPrimary
        return c
    }()
    
    lazy var releaseDateLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var ratingsLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var genresLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var revenueLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var runtimeLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var overviewLbl: UILabel = {
        let c = UILabel()
        c.numberOfLines = 0
        c.lineBreakMode = .byWordWrapping
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .titleFontSize)
        c.textColor = .textTertiary
        return c
    }()
}
