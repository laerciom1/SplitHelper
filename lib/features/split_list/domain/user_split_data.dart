class UserSplitData {
  final double owedShare;
  final int userId;
  final double paidShare;
  double? balance;

  UserSplitData({
    required this.owedShare,
    required this.userId,
    required this.paidShare,
    this.balance,
  });
}
