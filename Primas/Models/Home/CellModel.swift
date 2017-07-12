import Foundation

class CellModel {
  var title: String
  var description: String
  var imageUrl: String
  var groupImageUrl: String
  var groupName: String
  var date: Int
  var shared: Int
  var transfered: Int

  init(title: String, description: String, imageUrl: String, groupImageUrl: String, groupName: String, date: Int, shared: Int, transfered: Int) {
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

    data.append(CellModel(title: "敢欺负中国？不愧是好兄弟，巴铁发射战术核弹，印度这回玩大了", description: "据报道，巴铁在7月5日试射了一枚自主研发的新型短程导弹，与中国的『卫士2』火箭炮相比了一枚自动化啦啦啦", imageUrl: "http://img.hb.aicdn.com/6aea5f9b4c648aa76ed2df9a6ff90f337d7cef813b364-RWZdSO_fw658", groupImageUrl: "https://img3.doubanio.com/dae/niffler/niffler/images/aa81b9ba-1d1d-11e7-9570-0242ac110026.jpg", groupName: "铁血军事", date: 1499579198, shared: 1000, transfered: 2000))

    data.append(CellModel(title: "敢欺负中国？不愧是好兄弟", description: "据报道，巴铁在7月5日试射了一枚自主研发的新型短程导弹，与中国的『卫士2』火箭炮相比了一枚自动化啦啦啦", imageUrl: "http://img.hb.aicdn.com/6aea5f9b4c648aa76ed2df9a6ff90f337d7cef813b364-RWZdSO_fw658", groupImageUrl: "https://img3.doubanio.com/dae/niffler/niffler/images/aa81b9ba-1d1d-11e7-9570-0242ac110026.jpg", groupName: "铁血军事", date: 1499579198, shared: 1000, transfered: 2000))

    data.append(CellModel(title: "敢欺负中国？不愧是好兄弟，巴铁发射战术核弹，印度这回玩大了", description: "据报道，巴铁在7月5日试射了一枚自主研发的新型短程导弹，与中国的『卫士2』火箭炮相比了一枚自动化啦啦啦", imageUrl: "http://img.hb.aicdn.com/6aea5f9b4c648aa76ed2df9a6ff90f337d7cef813b364-RWZdSO_fw658", groupImageUrl: "https://img3.doubanio.com/dae/niffler/niffler/images/aa81b9ba-1d1d-11e7-9570-0242ac110026.jpg", groupName: "铁血军事", date: 1499579198, shared: 1000, transfered: 2000))

    data.append(CellModel(title: "敢欺负中国？不愧是好兄", description: "据报道，巴铁在7月5日试射了一枚自主研发的新", imageUrl: "http://img.hb.aicdn.com/6aea5f9b4c648aa76ed2df9a6ff90f337d7cef813b364-RWZdSO_fw658", groupImageUrl: "https://img3.doubanio.com/dae/niffler/niffler/images/aa81b9ba-1d1d-11e7-9570-0242ac110026.jpg", groupName: "铁血军事", date: 1499579198, shared: 1000, transfered: 2000))

    data.append(CellModel(title: "敢欺负中国？不愧是好兄弟，巴铁发射战术核弹，印度这回玩大了", description: "据报道，巴铁在7月", imageUrl: "http://img.hb.aicdn.com/6aea5f9b4c648aa76ed2df9a6ff90f337d7cef813b364-RWZdSO_fw658", groupImageUrl: "https://img3.doubanio.com/dae/niffler/niffler/images/aa81b9ba-1d1d-11e7-9570-0242ac110026.jpg", groupName: "铁血军事", date: 1499579198, shared: 1000, transfered: 2000))

    return data
  }
}
