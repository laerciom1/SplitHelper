class UserSplitData {
  final double owedShare;
  int? userId;
  double? paidShare;
  double? balance;

  UserSplitData({
    required this.owedShare,
    this.userId,
    this.paidShare,
    this.balance,
  });
}
