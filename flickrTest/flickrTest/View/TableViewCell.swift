import UIKit
import SnapKit
import Kingfisher
class TableViewCell: UITableViewCell {
    
    //MARK: - Properties -
    private let box = UIView()
    private let newImageView = UIImageView()
    private let nameLabel = UILabel()
    private let itemsLabel = UILabel()
    private let viewLabel = UILabel()
    private let commentsLabel = UILabel()
    private let arrowImage = UIImageView()
    private let newBox = UIView()
    
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()

    }
    
    //MARK: - Private Func -
    private func configureView() {
        contentView.addSubview(box)
        box.backgroundColor = .white
        box.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
        box.addSubview(newImageView)
        newImageView.snp.makeConstraints { (make) in
            make.width.equalTo(51)
            make.top.equalTo(box).offset(10)
            make.left.equalTo(box).offset(10)
            make.bottom.equalTo(box).offset(-10)
            
        }
        box.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(newImageView).offset(60)
            make.top.equalTo(box).offset(10)
            make.right.equalTo(box).offset(-20)
        }
        box.addSubview(itemsLabel)
        itemsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel).offset(22)
            make.left.equalTo(newImageView).offset(60)
        }
        box.addSubview(viewLabel)
        viewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel).offset(22)
            make.left.equalTo(itemsLabel).offset(60)
        }
        box.addSubview(commentsLabel)
        commentsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel).offset(22)
            make.left.equalTo(viewLabel).offset(84)
        }
        box.addSubview(newBox)
        newBox.backgroundColor = .black
        newBox.snp.makeConstraints { (make) in
            make.height.width.equalTo(35)
            make.top.equalTo(box).offset(10)
            make.right.equalTo(box).offset(-15)
            newBox.layer.cornerRadius = 17
        }
        newBox.addSubview(arrowImage)
        arrowImage.image = UIImage(systemName: "arrow.right")
        arrowImage.tintColor = .white
        arrowImage.snp.makeConstraints { (make) in
            make.center.equalTo(newBox)
            make.width.equalTo(25)
            arrowImage.alpha = 0.7
            
        }
    }
    
    
    func configure(_ result: Photoset?) {
        guard let newResult = result else { return}
        setUpView()
        nameLabel.text = newResult.title._content
        if newResult.countComments == "0" {
            commentsLabel.text = "No comments"
        } else {
            commentsLabel.text = newResult.countComments
        }
        viewLabel.textColor = .gray
        viewLabel.text = "\(newResult.countViews ?? " ") views"
        if let photoResult = newResult.photos, let videoResult = newResult.videos {
            itemsLabel.text = "\(photoResult + videoResult) items"
        }
        if let urlImage = newResult.primaryPhotoExtras.urlM {
            let url = URL(string: urlImage)
            newImageView.kf.setImage(with: url)
        }
    }
    
    private func setUpView() {
        newImageView.layer.cornerRadius = 25
        newImageView.contentMode = .scaleAspectFill
        newImageView.clipsToBounds = true
        newImageView.backgroundColor = .red
        itemsLabel.textColor = .gray
        itemsLabel.font = itemsLabel.font.withSize(12)
        viewLabel.font = viewLabel.font.withSize(12)
        commentsLabel.textColor = .gray
        commentsLabel.font = commentsLabel.font.withSize(12)
    }
}
