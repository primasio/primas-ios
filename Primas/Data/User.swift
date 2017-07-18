class User {
  var nickname: String
  var hp: Double
  var avatar: String
  var credit: String
  var articlesTotal: Int
  var articles: [UserArticleItem]
  var groupsTotal: Int
  var groups: [UserGroupItem]
  var balance: Double
  var amountYesterday: Double
  var amountDetail: AmountDetail

  init(nickname: String, hp: Double, avatar: String, credit: String, articlesTotal: Int, articles: [UserArticleItem], groupsTotal: Int, groups: [UserGroupItem], balance: Double, amountYesterday: Double, amountDetail: AmountDetail) {
    self.nickname = nickname
    self.hp = hp
    self.avatar = avatar
    self.credit = credit
    self.articles = articles
    self.groups = groups
    self.balance = balance
    self.amountYesterday = amountYesterday
    self.amountDetail = amountDetail
    self.articlesTotal = articlesTotal
    self.groupsTotal = groupsTotal
  }
}
