class System {
  var pstYesterday: Double
  var rankingArticles: [SystemArticleRanking]
  var rankingGroups: [SystemGroupRanking]

  init(pstYesterday: Double, rankingArticles: [SystemArticleRanking], rankingGroups: [SystemGroupRanking]) {
    self.pstYesterday = pstYesterday
    self.rankingArticles = rankingArticles
    self.rankingGroups = rankingGroups
  }
}