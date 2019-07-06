import Cocoa

class FeedItem: NSObject {
  let image: String
  let name: String
  
  init(dictionary: NSDictionary) {
    self.image = dictionary.object(forKey: "image") as! String
    self.name = dictionary.object(forKey: "name") as! String
  }
}
