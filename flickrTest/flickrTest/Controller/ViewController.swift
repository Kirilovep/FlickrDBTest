import UIKit
import SnapKit
class ViewController: UIViewController {
    
    //MARK:- Properties -
    private let mainTableView = UITableView()
    private var newPhotoSets: [Photoset]?
    private let newNetworkManager = NewNetworkManager()
    
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadPhoto()
    }
    
    //MARK:- Private func -
    private func loadPhoto() {
        newNetworkManager.loadPhotosets { [weak self] (photosets) in
            DispatchQueue.main.async {
                self?.newPhotoSets = photosets
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        let nib = UINib(nibName: mainTableViewCell.nibIdentifier.rawValue, bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: mainTableViewCell.mainCellIdentifier.rawValue)
        mainTableView.rowHeight = 75
    }
}

//MARK:- Extensions -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPhotoSets?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCell.mainCellIdentifier.rawValue) as! TableViewCell
        cell.configure(newPhotoSets?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: vcIdentifiers.detailVCIdentifier.rawValue) as! DetailViewController
        vc.selectedImage = newPhotoSets?[indexPath.row].id ?? " "
        vc.owner = newPhotoSets?[indexPath.row].owner ?? " "
        vc.albumTitle = newPhotoSets?[indexPath.row].title._content
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
