class Transaction {
  int? id;
  String? transactionType;
  String? transactionNumber;
  double? transactionAmount;
  String? transactionDate;
  double? comission;
  double? total;
  String? typeOfOperation;

  Transaction({
    this.id,
    this.total,
    this.comission,
    this.transactionAmount,
    this.transactionDate,
    this.transactionNumber,
    this.transactionType,
    this.typeOfOperation,
  });

  factory Transaction.fromJson(Map data) {
    return Transaction(
      id: data['id'],
      comission: data['comission'],
      typeOfOperation: data['typeOfOperation'],
      transactionDate: data['transactionDate'],
      transactionAmount: data['transactionAmount'],
      transactionType: data['transactionType'],
      transactionNumber: data['transactionNumber'],
      total: data['transactionAmount']+data['comission'],
    );
  }
}
