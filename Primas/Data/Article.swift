class Article {
  var id: Int
  var title: String
  var author: ArticleAuthor
  var coverImage: String
    var content: [Any]
  var license: ArticleLicense
  var source: ArticleSource
  var statistics: ArticleStatistics
  var dna: String
  var outline: String
  var groupId: Int
  var createdAt: Int
  
  init(id: Int, title: String, author: ArticleAuthor, coverImage: String, content: [Any], license: ArticleLicense, source: ArticleSource, statistics: ArticleStatistics, dna: String, outline: String, groupId: Int, createdAt: Int) {
    self.id = id
    self.title = title
    self.author = author
    self.coverImage = coverImage
    self.content = content
    self.license = license
    self.source = source
    self.statistics = statistics
    self.dna = dna
    self.outline = outline
    self.groupId = groupId
    self.createdAt = createdAt
  }
}
