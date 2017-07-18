class ArticleSource {
  var url: String
  var title: String
  var author: String
  var licensed: Bool

  init(url: String, title: String, author: String, licensed: Bool) {
    self.url = url
    self.title = title
    self.author = author
    self.licensed = licensed
  }
}