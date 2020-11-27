import UIKit
import AVKit
import SnapKit
class DetailViewController: UIViewController {
    
    //MARK:- Properties -
    var selectedImage: String?
    var owner: String?
    var albumTitle: String?
    private var photosFromAlbum: [Photo] = []
    private let networkManager = NewNetworkManager()
    private var numberOfItemsInRow = 2
    private var minimumSpacing = 5
    private var edgeInsetPadding = 10
    private var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        loadPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpOrientation()
    }
    
    //MARK:- Private Func -
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        detailCollectionView.backgroundColor = .white
        
        detailCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.maxX)
            make.height.equalTo(view.frame.maxY)
        }
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        
        let nib = UINib(nibName: collectionViewCell.nibIdentifier.rawValue, bundle: nil)
        detailCollectionView.register(nib, forCellWithReuseIdentifier: collectionViewCell.cellIdentifier.rawValue)
        view.addSubview(detailCollectionView)
    }
    
    private func loadPhotos() {
        networkManager.loadPhotoFromAlbum(selectedImage ?? " ", owner ?? " " ) { [weak self] (photos) in
            DispatchQueue.main.async {
                self?.photosFromAlbum = photos
                self?.detailCollectionView.reloadData()
            }
        }
    }
    
    private func setUpOrientation() {
        navigationItem.title = albumTitle
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = .portrait
    }
}

//MARK:- Extenstions -
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosFromAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell.cellIdentifier.rawValue, for: indexPath) as! CollectionViewCell
        cell.configure(photosFromAlbum[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * minimumSpacing - edgeInsetPadding) / numberOfItemsInRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if photosFromAlbum[indexPath.row].media.rawValue == "photo" {
            
            let desVC = storyboard?.instantiateViewController(identifier: vcIdentifiers.photoVCIdentifier.rawValue) as! PhotoScreenViewController
            let idPhoto = photosFromAlbum[indexPath.row].id
            let secretPhoto = photosFromAlbum[indexPath.row].secret
            desVC.secretImage = secretPhoto
            desVC.selectedImage = idPhoto
            
            navigationController?.pushViewController(desVC, animated: true)
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            if let resultId = photosFromAlbum[indexPath.row].id, let resultSecret = photosFromAlbum[indexPath.row].secret {
                let urlPhoto = "\(HelperUrl.loadVIdeoUrl.rawValue)/\(resultId)/play/1080p/\(resultSecret)/"
                let photoUrl = URL(string: urlPhoto)!
                
                let player = AVPlayer(url: photoUrl)
                let vc = AVPlayerViewController()
                vc.player = player
                
                present(vc, animated: true) {
                    vc.player?.play()
                }
            }
        }
    }
}
