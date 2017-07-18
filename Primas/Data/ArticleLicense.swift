class ArticleLicense {
  var type: String
  var content: [String: String]

  init(type: String, content: [String: String]) {
    self.type = type
    self.content = content
  }
}