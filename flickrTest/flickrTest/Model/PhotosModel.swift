import Foundation

struct PhotosJSONModel: Codable {
    let photoset: Photos
    let stat: String
}

struct Photos: Codable {
    let id: String?
    let photo: [Photo]
}


struct Photo: Codable {
    let id: String?
    let secret: String?
    let media: Media
    let title: String?
}

enum Media: String, Codable {
    case photo = "photo"
    case video = "video"
}
