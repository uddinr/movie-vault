import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        selectionStyle = .none
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        containerView.addSubview(posterImg)
        containerView.addSubview(titleLbl)
        containerView.addSubview(releaseDateLbl)
        containerView.addSubview(ratingsLbl)
        containerView.addSubview(overviewLbl)
        
        addSubview(containerView)
        
        posterImg.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.high)
            make.width.height.equalTo(150)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(posterImg.snp.top)
            make.left.equalTo(posterImg.snp.right)
            make.right.equalToSuperview().offset(-20)
            
        }
        
        releaseDateLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.left.equalTo(titleLbl.snp.left)
            make.right.equalToSuperview().offset(-20)
        }
        
        ratingsLbl.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLbl.snp.bottom)
            make.left.equalTo(titleLbl.snp.left)
            make.right.equalToSuperview().offset(-20)
        }
        
        overviewLbl.snp.makeConstraints { make in
            make.top.equalTo(ratingsLbl.snp.bottom).offset(10)
            make.left.equalTo(titleLbl.snp.left)
            make.right.equalToSuperview().offset(-20)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        overviewLbl.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        }
    }
    
    func setMovie(viewModel: MovieCellViewModel){
        posterImg.sd_setImage(with: viewModel.image)
        titleLbl.text = viewModel.title
        releaseDateLbl.text = "Released: \(viewModel.releaseDate.toString())"
        ratingsLbl.text = "Rating: \(String(format: "%.1f", viewModel.voteAverage))/10"
        overviewLbl.text = viewModel.overview
    }
    
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
        c.font = .systemFont(ofSize: .titleFontSize, weight: .bold)
        c.textColor = .textPrimary
        return c
    }()
    
    lazy var releaseDateLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .bodyFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var ratingsLbl: UILabel = {
        let c = UILabel()
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .bodyFontSize)
        c.textColor = .textSecondary
        return c
    }()
    
    lazy var overviewLbl: UILabel = {
        let c = UILabel()
        c.numberOfLines = 0
        c.textAlignment = .left
        c.font = .systemFont(ofSize: .bodyFontSize)
        c.textColor = .textTertiary
        return c
    }()
}
