class UserAmountDetailItem {
  var date: String
  var title: String
  var amount: Double
  var type: PrimasAwardType

  init(date: String, title: String, amount: Double, type: PrimasAwardType) {
    self.date = date
    self.title = title 
    self.amount = amount
    self.type = type
  }
}