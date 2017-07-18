import Foundation

class Group {
  var id: Int?
  var name: String?
  var image: String?
  var contentTotal: Int
  var contentNew: Int
  var memberTotal: Int 

    init(id: Int, name: String, image: String, contentTotal: Int, contentNew: Int, memberTotal: Int) {
    self.id = id 
    self.name = name
    self.image = image
    self.contentTotal = contentTotal
    self.contentNew = contentNew
    self.memberTotal = memberTotal
  }
    
}
