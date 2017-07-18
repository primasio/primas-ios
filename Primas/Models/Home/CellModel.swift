import Foundation

class CellModel {
  var id: Int
  var title: String
  var description: String
  var imageUrl: String
  var groupImageUrl: String
  var groupName: String
  var date: Int
  var shared: Int
  var transfered: Int

  init(id: Int, title: String, description: String, imageUrl: String, groupImageUrl: String, groupName: String, date: Int, shared: Int, transfered: Int) {
    self.id = id
    self.title = title
    self.description = description
    self.imageUrl = imageUrl
    self.groupImageUrl = groupImageUrl
    self.groupName = groupName
    self.date = date
    self.shared = shared
    self.transfered = transfered
  }

  static func generateTestData() -> Array<CellModel> {
    var data: Array<CellModel> = []

    let resource = app().client.data!
    let articles = resource["articles"]  as! Array<[String: Any]>
    let _baseURL = app().client.baseURL

    for item in articles {
        let groupId = item["group_id"] as! Int
        let group = app().client.getGroupById(groupId)
        let statistics = item["statistics"] as! [String: Int]
        data.append(CellModel(id: item["id"] as! Int,title: item["title"] as! String, description: (item["outline"] as? String) ?? "", imageUrl: _baseURL + (item["cover_image"] as! String), groupImageUrl: _baseURL + (group?["image"] as! String), groupName: group?["name"] as! String, date: item["created_at"] as! Int, shared: statistics["share"] ?? 0 , transfered: statistics["reproduction"] ?? 0))
   }

    return data
  }
}
