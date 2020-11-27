import Foundation


class NewNetworkManager {
    
    func loadPhotosets(_ completionHandler: @escaping ([Photoset]) -> Void ) {
        if let url = URL(string: HelperUrl.mainUrl.rawValue) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let resultPhotoSets = try? decoder.decode(PhotoSetsModel.self, from: responceData)
                        completionHandler(resultPhotoSets?.photosets.photoset ?? [ ])
                    }
                }
            }.resume()
        }
    }
    
    func loadPhotoFromAlbum(_ idAlbum: String,_ userId: String, _ completionHandler: @escaping ([Photo]) -> Void ) {
        
        let url = HelperUrl.photosFromAlbumUrl.rawValue + idAlbum + HelperUrl.userId.rawValue + userId + HelperUrl.extrasForMedia.rawValue +  HelperUrl.formatUrl.rawValue
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let resultPhotos = try? decoder.decode(PhotosJSONModel.self, from: responceData)
                        completionHandler(resultPhotos?.photoset.photo ?? [ ])
                    }
                }
            }.resume()
        }
    }
}
