import UIKit

class CustomUIImage {

  private let imageCache = NSCache<NSString, UIImage>()
  private var keyString: String?

  func loadAsync(with path: String, imagePlace: UIImageView, placeHolder: UIImage) {

    if let imageFromCache = imageCache.object(forKey: path as NSString) {
      imagePlace.image = imageFromCache
      return
    }

    imagePlace.image = placeHolder

    DispatchQueue.main.async {
      let posterData = UrlManager.getPosterData(with: path)
      let image = UIImage(data: posterData)
      self.imageCache.setObject(image!, forKey: path as NSString)
      imagePlace.image = image
    }
  }
}
