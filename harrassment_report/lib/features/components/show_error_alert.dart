import 'package:flutter/material.dart';

class ShowErrorAlert extends StatelessWidget {
  String errorValue;
  ShowErrorAlert({Key? key, required this.errorValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorValue,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
