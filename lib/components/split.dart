import 'package:flutter/material.dart';
import 'package:split_helper/core/models/split_data.dart';

class Split extends StatelessWidget {
  final SplitData split;
  const Split({
    super.key,
    required this.split,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                split.category!.imageUrl,
                height: 64,
              ),
              Expanded(
                flex: 1,
                child: Date(
                  date: DateTime.parse(split.date),
                ),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 64),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            split.description,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'R\$ ${double.parse(split.cost).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: .5,
                        indent: 24,
                        endIndent: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${split.users[0].owedShare} - ${split.users[1].owedShare}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Text(
          //   '${split.users[0].userId} - ${split.users[0].owedShare} - ${split.users[0].paidShare} - ${split.users[0].balance}',
          // ),
          // Text(
          //   '${split.users[1].userId} - ${split.users[1].owedShare} - ${split.users[1].paidShare} - ${split.users[1].balance}',
          // ),
        ],
      ),
    );
  }
}

class Date extends StatelessWidget {
  const Date({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final day = '${date.day < 10 ? '0' : ''}${date.day}';
    final month = getMonth(date.month);
    final year = date.year % 2000;
    return SizedBox(
      height: 64,
      width: 36,
      child: Container(
        color: Theme.of(context).splashColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day),
            Text(month),
            Text('$year'),
          ],
        ),
      ),
    );
  }
}

String getMonth(int intMonth) {
  switch (intMonth) {
    case 1:
      return 'jan';
    case 2:
      return 'fev';
    case 3:
      return 'mar';
    case 4:
      return 'abr';
    case 5:
      return 'mai';
    case 6:
      return 'jun';
    case 7:
      return 'jul';
    case 8:
      return 'ago';
    case 9:
      return 'set';
    case 10:
      return 'out';
    case 11:
      return 'nov';
    case 12:
      return 'dez';
  }
  return '';
}
