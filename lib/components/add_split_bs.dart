import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_helper/core/models/settings_data.dart';

class AddSplitBS extends StatefulWidget {
  const AddSplitBS({
    super.key,
    required this.category,
    required this.initialShareConfig,
    required this.onApply,
  });

  final Category category;
  final int initialShareConfig;
  final void Function(Category, String, double, int) onApply;

  @override
  State<AddSplitBS> createState() => _AddSplitBSState();
}

class _AddSplitBSState extends State<AddSplitBS> {
  double cost = 0;
  String description = '';
  late int shareConfig;
  bool descriptionValid = false;
  bool costValid = false;

  @override
  void initState() {
    super.initState();
    shareConfig = widget.initialShareConfig;
  }

  onFinish(context) {
    widget.onApply(widget.category, description, cost, shareConfig);
    Navigator.pop(context);
  }

  String? descriptionValidator(String? value) {
    final str = value ?? '';
    if (str.length < 3) {
      return 'Must have at least 3 chars';
    }
    return null;
  }

  String? costValidator(String? value) {
    try {
      final str = value ?? '';
      if (double.parse(str) <= 0) {
        return 'Must be greater than 0';
      }
    } catch (_) {
      return 'Must be greater than 0';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 220,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 4,
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            widget.category.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: '${widget.category.prefix} ...',
                              ),
                              textInputAction: TextInputAction.next,
                              onChanged: (inputValue) {
                                final inputValid =
                                    descriptionValidator(inputValue) == null;
                                setState(() {
                                  descriptionValid = inputValid;
                                  if (inputValid) {
                                    description = inputValue;
                                  }
                                });
                              },
                              validator: descriptionValidator,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'R\$ ...',
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (inputValue) {
                                final inputValid =
                                    costValidator(inputValue) == null;
                                setState(() {
                                  costValid = inputValid;
                                  if (inputValid) {
                                    cost = double.parse(inputValue);
                                  }
                                });
                              },
                              validator: costValidator,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  RegExp pattern =
                                      RegExp(r'^[0-9]*[.,]{0,1}[0-9]{0,2}$');
                                  final newValueText = newValue.text;
                                  final match = pattern.hasMatch(newValueText);
                                  if (match) {
                                    newValue = newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll(',', '.'));
                                    return newValue;
                                  }
                                  return oldValue;
                                }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '$shareConfig/${100 - shareConfig}',
                                ),
                                Slider.adaptive(
                                    value: (shareConfig / 100),
                                    onChanged: (value) {
                                      setState(() {
                                        shareConfig = (value * 100).toInt();
                                      });
                                    })
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                    if (descriptionValid && costValid)
                      const SizedBox(
                        height: 4,
                      ),
                    if (descriptionValid && costValid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () => onFinish(context),
                            child: SizedBox(
                              width: 64,
                              child: Text(
                                'Add',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
