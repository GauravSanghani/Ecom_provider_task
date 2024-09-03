class Account {
  final String accountName;
  final double amount;
  final String transactionDate;

  Account({
    required this.accountName,
    required this.amount,
    required this.transactionDate,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountName: json['account_name'],
      amount: json['amount'].toDouble(),
      transactionDate: json['transaction_date'],
    );
  }
}
