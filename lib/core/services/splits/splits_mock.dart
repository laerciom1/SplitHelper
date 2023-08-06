import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/models/split_data.dart';

parseSplit(jsonSplit) {
  final users = (jsonSplit['users'] as List<Map<String, Object>>)
      .map((jsonUser) => UserSplitData(
            userId: jsonUser['user_id'] as int,
            paidShare: double.parse(jsonUser['paid_share'] as String),
            owedShare: double.parse(jsonUser['owed_share'] as String),
            balance: double.parse(jsonUser['net_balance'] as String),
          ))
      .toList();
  final split = SplitData(
    id: jsonSplit['id'] as int,
    description: jsonSplit['description'] as String,
    cost: double.parse(jsonSplit['cost'] as String).toStringAsFixed(2),
    date: jsonSplit['date'] as String,
    users: users,
    category: Category.fromId((jsonSplit['category']['id'] as int)),
  );
  return split;
}

final mockedSplitsData = [
  {
    "id": 2535203648,
    "group_id": 0123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "HOME Sofá",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": null,
    "comments_count": 0,
    "payment": false,
    "creation_method": "percent",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "344.1",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "51.61"}
    ],
    "date": "2023-08-01T11:51:11Z",
    "category": {"id": 3, "name": "Geral"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "344.1",
        "owed_share": "292.49",
        "net_balance": "51.61"
      },
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "51.61",
        "net_balance": "-51.61"
      }
    ]
  },
  {
    "id": 2532115024,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "AUTO Gasolina",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "164.8",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "24.72"}
    ],
    "date": "2023-07-31T11:41:08Z",
    "created_at": "2023-07-31T11:41:08Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-31T11:41:08Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 15, "name": "Jantar fora"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "24.72",
        "net_balance": "-24.72"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "164.8",
        "owed_share": "140.08",
        "net_balance": "24.72"
      }
    ]
  },
  {
    "id": 2532113711,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "MERCADO Feira",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "175.94",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "26.39"}
    ],
    "date": "2023-07-31T11:40:35Z",
    "created_at": "2023-07-31T11:40:35Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-31T11:40:35Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 12, "name": "Animais de estimação"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "26.39",
        "net_balance": "-26.39"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "175.94",
        "owed_share": "149.55",
        "net_balance": "26.39"
      }
    ]
  },
  {
    "id": 2532111205,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "LAZER Cinema",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 1,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "886.79",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "133.02"}
    ],
    "date": "2023-07-31T11:39:31Z",
    "created_at": "2023-07-31T11:39:31Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-31T11:39:53Z",
    "updated_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 23, "name": "Animais de estimação"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "133.02",
        "net_balance": "-133.02"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "886.79",
        "owed_share": "753.77",
        "net_balance": "133.02"
      }
    ]
  },
  {
    "id": 2527283872,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "OTHERS Xerox",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "148.0",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "22.2"}
    ],
    "date": "2023-07-29T16:44:36Z",
    "created_at": "2023-07-29T16:44:36Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-29T16:44:36Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 18, "name": "Animais de estimação"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "22.2",
        "net_balance": "-22.2"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "148.0",
        "owed_share": "125.8",
        "net_balance": "22.2"
      }
    ]
  },
  {
    "id": 2526723583,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "PET Tapates laváveis",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "99.19",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "14.88"}
    ],
    "date": "2023-07-29T13:05:01Z",
    "created_at": "2023-07-29T13:05:01Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-29T13:05:01Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 29, "name": "Animais de estimação"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "14.88",
        "net_balance": "-14.88"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "99.19",
        "owed_share": "84.31",
        "net_balance": "14.88"
      }
    ]
  },
  {
    "id": 2523280442,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "TRAVEL Passagens Ouro Preto",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "83.0",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "12.45"}
    ],
    "date": "2023-07-27T23:13:48Z",
    "created_at": "2023-07-27T23:13:48Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-27T23:13:48Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 35, "name": "Animais de estimação"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "12.45",
        "net_balance": "-12.45"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "83.0",
        "owed_share": "70.55",
        "net_balance": "12.45"
      }
    ]
  },
  {
    "id": 2515309449,
    "group_id": 1123,
    "friendship_id": null,
    "expense_bundle_id": null,
    "description": "RECORRENTE YouTube",
    "repeats": false,
    "repeat_interval": null,
    "email_reminder": false,
    "email_reminder_in_advance": -1,
    "next_repeat": null,
    "details": "",
    "comments_count": 0,
    "payment": false,
    "creation_method": "split",
    "transaction_method": "offline",
    "transaction_confirmed": false,
    "transaction_id": null,
    "transaction_status": null,
    "cost": "3198.47",
    "currency_code": "BRL",
    "repayments": [
      {"from": 2123, "to": 1123, "amount": "479.77"}
    ],
    "date": "2023-07-24T11:22:52Z",
    "created_at": "2023-07-24T11:22:52Z",
    "created_by": {
      "id": 1123,
      "first_name": "Laércio",
      "last_name": null,
      "picture": {
        "medium":
            "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
      },
      "custom_picture": true
    },
    "updated_at": "2023-07-24T11:22:52Z",
    "updated_by": null,
    "deleted_at": null,
    "deleted_by": null,
    "category": {"id": 39, "name": "Avião"},
    "receipt": {"large": null, "original": null},
    "users": [
      {
        "user": {
          "id": 2123,
          "first_name": "Daiane",
          "last_name": null,
          "picture": {
            "medium":
                "https://s3.amazonaws.com/splitwise/uploads/user/default_avatars/avatar-teal47-100px.png"
          }
        },
        "user_id": 2123,
        "paid_share": "0.0",
        "owed_share": "479.77",
        "net_balance": "-479.77"
      },
      {
        "user": {
          "id": 1123,
          "first_name": "Laércio",
          "last_name": null,
          "picture": {
            "medium":
                "https://splitwise.s3.amazonaws.com/uploads/user/avatar/1123/medium_b85668da-7020-43fc-a651-bb7f7e0971f1.jpeg"
          }
        },
        "user_id": 1123,
        "paid_share": "3198.47",
        "owed_share": "2718.7",
        "net_balance": "479.77"
      }
    ]
  },
].map(parseSplit);
