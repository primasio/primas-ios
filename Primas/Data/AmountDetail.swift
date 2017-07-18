class AmountDetail {
  var date: String
  var items: [UserAmountDetailItem]

  init(date: String, items: [UserAmountDetailItem]) {
    self.date = date
    self.items = items
  }
}
