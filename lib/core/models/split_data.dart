class SplitData {
  final int id;
  final String description;
  final String cost;
  final String date;
  final List<UserSplitData> users;
  Category? category;

  SplitData({
    required this.id,
    required this.description,
    required this.cost,
    required this.date,
    required this.users,
    required categoryId,
  }) {
    category = Category(id: categoryId);
  }
}

class UserSplitData {
  final int userId;
  final double paidShare;
  final double owedShare;
  final double balance;

  UserSplitData({
    required this.userId,
    required this.paidShare,
    required this.owedShare,
    required this.balance,
  });
}

class Category {
  String prefix = '';
  String imageUrl = '';
  final int id;

  Category({
    required this.id,
  }) {
    switch (id) {
      case 3:
        {
          prefix = 'HOME ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/rent@2x.png";
        }
      case 15:
        {
          prefix = 'AUTO ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/transportation/car@2x.png";
        }
      case 12:
        {
          prefix = 'MERCADO ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/food-and-drink/groceries@2x.png";
        }
      case 23:
        {
          prefix = 'LAZER ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/entertainment/other@2x.png";
        }
      case 18:
        {
          prefix = 'OTHERS ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/uncategorized/general@2x.png";
        }
      case 29:
        {
          prefix = 'PET ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/pets@2x.png";
        }
      case 35:
        {
          prefix = 'TRAVEL ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/transportation/plane@2x.png";
        }
      case 39:
        {
          prefix = 'RECORRENTE ';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/electronics@2x.png";
        }
    }
  }
}

/* CATEGORIAS

  

*/