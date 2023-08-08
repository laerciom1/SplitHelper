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
  final void Function() onApply;

  @override
  State<AddSplitBS> createState() => _AddSplitBSState();
}

class _AddSplitBSState extends State<AddSplitBS> {
  double cost = 0;
  String description = '';
  late int shareConfig;

  @override
  void initState() {
    shareConfig = widget.initialShareConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 228,
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
                              decoration: InputDecoration(
                                labelText: '${widget.category.prefix} ...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  description = value;
                                });
                              },
                              // inputFormatters: [// TODO Format to capitalize],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'R\$ ...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  cost =
                                      double.parse(value.replaceAll(',', '.'));
                                });
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter(
                                  RegExp(","),
                                  allow: false,
                                  replacementString: ".",
                                )
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
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: widget.onApply,
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
