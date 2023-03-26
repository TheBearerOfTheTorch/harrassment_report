import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/states.dart';

Widget customGenderPicker(context) {
  final size = MediaQuery.of(context).size.width;
  return Consumer<FieldsStateManager>(
      builder: (context, fieldStateManager, child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 130,
          height: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: fieldStateManager.isGenderNull
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Female"),
              Checkbox(
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  if (value!) {
                    //checking if male is checked and unselecting the others
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isMaleChecked = false;
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isFemaleChecked = true;
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isOtherChecked = false;

                    //gender controller
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .setGenderController = "Female";
                  }
                },
                value: fieldStateManager.isGenderRegisterFemaleFilled,
              ),
            ],
          ),
        ),
        Container(
          width: 130,
          height: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: fieldStateManager.isGenderNull
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Other"),
              Checkbox(
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  if (value!) {
                    //checking if male is checked and unselecting the others
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isMaleChecked = false;
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isFemaleChecked = false;
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .isOtherChecked = true;

                    //gender controller
                    Provider.of<FieldsStateManager>(context, listen: false)
                        .setGenderController = "Other";
                  }
                },
                value: fieldStateManager.isGenderRegisterOtherFilled,
              ),
            ],
          ),
        ),
        Container(
          width: 130,
          height: 34,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: fieldStateManager.isGenderNull
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Male"),
              Checkbox(
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    if (value!) {
                      //checking if male is checked and unselecting the others
                      Provider.of<FieldsStateManager>(context, listen: false)
                          .isMaleChecked = true;
                      Provider.of<FieldsStateManager>(context, listen: false)
                          .isFemaleChecked = false;
                      Provider.of<FieldsStateManager>(context, listen: false)
                          .isOtherChecked = false;

                      //gender controller
                      Provider.of<FieldsStateManager>(context, listen: false)
                          .setGenderController = "Male";
                    }
                  },
                  value: fieldStateManager.isGenderRegisterMaleFilled),
            ],
          ),
        )
      ],
    );
  });
}
