class Article {
  var id: Int
  var title: String
  var author: ArticleAuthor
  var coverImage: String
  var content: String
  var license: ArticleLicense
  var source: ArticleSource
  var statistics: ArticleStatistics
  var dna: String
  var outline: String
  var groupId: Int
  var created_at: Int
  
  init(id: Int, title: String, author: ArticleAuthor, coverImage: String, content: String, license: ArticleLicense, source: ArticleSource, statistics: ArticleStatistics, dna: String, outline: String, groupId: Int, created_at: Int) {
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
    self.created_at = created_at
  }
}
