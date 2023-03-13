import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdaptativeTextField extends StatelessWidget {
  AdaptativeTextField({
    controller,
    keyboardType = TextInputType.text,
    onSubmitted,
    label,
  });

  TextEditingController? controller;
  TextInputType? keyboardType;
  Function? onSubmitted;
  String? label;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              keyboardType: keyboardType,
              controller: controller,
              onSubmitted: (value) => onSubmitted,
              placeholder: label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            keyboardType: keyboardType,
            controller: controller,
            onSubmitted: (value) => onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
