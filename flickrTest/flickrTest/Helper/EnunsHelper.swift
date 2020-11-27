import Foundation


enum HelperUrl: String {
    case photosFromAlbumUrl = "https://www.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=3b41e67ae76859760e5ab80d88f61eea&photoset_id="
    case extrasForMedia = "&extras=media"
    case userId = "&user_id="
    case formatUrl = "&format=json&nojsoncallback=1"
    case loadPhotoUrl = "https://live.staticflickr.com/"
    case loadVIdeoUrl = "https://www.flickr.com/photos/flickr/"
    case mainUrl = "https://www.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=3b41e67ae76859760e5ab80d88f61eea&user_id=66956608%40N06&primary_photo_extras=url_m&photo_ids=&format=json&nojsoncallback=1"
}

enum ImageUrl: String {
    case photoUrl = "https://www.flickr.com/photos/"
}

enum mainTableViewCell: String {
    case nibIdentifier = "TableViewCell"
    case mainCellIdentifier = "mainCell"
}

enum collectionViewCell: String {
    case nibIdentifier = "CollectionViewCell"
    case cellIdentifier = "detailCell"
}

enum vcIdentifiers: String {
    case detailVCIdentifier = "DetailViewController"
    case photoVCIdentifier = "ScreenVC"
}
