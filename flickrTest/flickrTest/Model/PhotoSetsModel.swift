import Foundation

struct PhotoSetsModel: Codable {
    let photosets: Photosets
    let stat: String?

}

struct Photosets: Codable {
    let photoset: [Photoset]

}

struct Photoset: Codable {
    let id: String
    let owner: String
    let primary: String?
    let secret: String?
    let countViews: String?
    let countComments: String?
    let countPhotos: Int?
    let countVideos: Int?
    let title: Description
    let photos: Int?
    let videos: Int?
    let primaryPhotoExtras: PrimaryPhotoExtras
}
struct PrimaryPhotoExtras: Codable {
    let urlM: String?
    let heightM: Int?
    let widthM: Int?
}

struct Description: Codable {
    let _content: String
}


