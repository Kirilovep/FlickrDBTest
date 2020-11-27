import UIKit
import Kingfisher
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    
    //MARK:- Properties -
    private let box = UIView()
    private let newImageView = UIImageView()
    private var videoImageView = UIImageView()
    
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        createPlayImage()
        
    }
    
    //MARK:- Private Func -
    private func createPlayImage() {
        let image = UIImage(systemName: "play.circle.fill")
        videoImageView = UIImageView(image: image)
        
        videoImageView.tintColor = .white
        
        newImageView.layer.cornerRadius = 15
        newImageView.clipsToBounds = true
    }
    
    private func setupView() {
        contentView.addSubview(box)
        
        box.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        box.addSubview(newImageView)
        newImageView.snp.makeConstraints { (make) in
            newImageView.contentMode = .scaleAspectFill
            make.left.equalTo(box).offset(8)
            make.top.equalTo(box).offset(8)
            make.bottom.equalTo(box).offset(-8)
            make.right.equalTo(box).offset(-8)
        }
    }
    
    func configure(_ result: Photo) {
        if let resultId = result.id, let resultSecret = result.secret {
            let urlPhoto = "\(HelperUrl.loadPhotoUrl.rawValue)0/\(resultId)_\(resultSecret)_b.jpg"
            let photoUrl = URL(string: urlPhoto)
            
            if result.media.rawValue == "video" {
                newImageView.addSubview(videoImageView)
                videoImageView.snp.makeConstraints { (make) in
                    make.centerX.equalTo(contentView)
                    make.centerY.equalTo(contentView)
                    make.width.height.equalTo(50)
                }
            }
            newImageView.kf.indicatorType = .activity
            newImageView.kf.setImage(with: photoUrl)
        }
    }
}
