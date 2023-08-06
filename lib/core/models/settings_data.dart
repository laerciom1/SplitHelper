class Category {
  String prefix = '';
  String imageUrl = '';
  int id = 0;

  Category({required this.prefix, required this.imageUrl, required this.id});

  Category.fromId(id) {
    switch (id) {
      case 3:
        {
          prefix = 'HOME';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/rent@2x.png";
        }
      case 15:
        {
          prefix = 'AUTO';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/transportation/car@2x.png";
        }
      case 12:
        {
          prefix = 'MERCADO';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/food-and-drink/groceries@2x.png";
        }
      case 23:
        {
          prefix = 'LAZER';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/entertainment/other@2x.png";
        }
      case 18:
        {
          prefix = 'OTHERS';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/uncategorized/general@2x.png";
        }
      case 29:
        {
          prefix = 'PET';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/pets@2x.png";
        }
      case 35:
        {
          prefix = 'TRAVEL';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/transportation/plane@2x.png";
        }
      case 39:
        {
          prefix = 'RECORRENTE';
          imageUrl =
              "https://s3.amazonaws.com/splitwise/uploads/category/icon/square_v2/home/electronics@2x.png";
        }
      default:
        {
          prefix = 'DEFAULT';
          imageUrl = "";
        }
    }
  }

  Category.fromJson(dynamic json) {
    imageUrl = json['imageUrl'] as String;
    prefix = json['prefix'] as String;
    id = json['id'] as int;
  }
}

class Settings {
  List<Category>? myCategories;
  int? shareConfig;

  Settings.fromJson(dynamic json) {
    if (json['myCategories'] != null) {
      myCategories = (json['myCategories'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList();
    }

    if (json['shareConfig'] != null) {
      shareConfig = json['shareConfig'] as int;
    }
  }
}

class SplitCategory {
  String? imageUrl;
  int? id;

  SplitCategory.fromJson(dynamic json) {
    imageUrl = json['icon_types']['square']['large'] as String;
    id = json['id'] as int;
  }
}

class SplitCategories {
  List<SplitCategory>? categories;

  SplitCategories.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = (json['categories'] as List<dynamic>).fold([], (accu, curr) {
        final List<SplitCategory> categories =
            (curr['subcategories'] as List<dynamic>)
                .map((category) => SplitCategory.fromJson(category))
                .toList();
        accu!.addAll(categories);
        return accu;
      });
    }
  }
}
