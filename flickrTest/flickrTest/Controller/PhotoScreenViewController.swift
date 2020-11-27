import UIKit
import Kingfisher
import SnapKit
class PhotoScreenViewController: UIViewController {
    
    //MARK: - Properties -
    var selectedImage: String?
    var secretImage: String?
    private let photoImage = UIImageView()
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        showImage()
    }
    
    //MARK: - Private Func -
    private func showImage() {
        photoImage.backgroundColor = .black
        if let resultId = selectedImage, let resultSecret = secretImage {
            let urlPhoto = "\(HelperUrl.loadPhotoUrl.rawValue)0/\(resultId)_\(resultSecret)_b.jpg"
            let photoUrl = URL(string: urlPhoto)
            photoImage.kf.indicatorType = .activity
            photoImage.kf.setImage(with: photoUrl)
        }
    }
    
    private func setUpView() {
        view.addSubview(photoImage)
        photoImage.contentMode = .scaleAspectFit
        photoImage.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .allButUpsideDown
    }
}



