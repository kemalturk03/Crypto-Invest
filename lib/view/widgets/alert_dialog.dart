import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/utilities/custom_text_field.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';

Future alertDialog({
  required BuildContext context,
  String? coinTitle,
  WalletViewModel? viewModel,
  String? dialogLabel,
  TextEditingController? controller,
  ButtonStyle? buttonStyle,
  Function()? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext? context) {
      Size size = MediaQuery.of(context!).size;
      return AlertDialog(
        backgroundColor: grey,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        title: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              '${dialogLabel!.toUpperCase()} $coinTitle',
              style: TextStyle(
                  fontSize: size.width / 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: Container(
          height: size.height / 7,
          width: size.width / 1.2,
          child: Column(
            children: [
              customTextField(size.height, size.width, viewModel!, dialogLabel,
                  controller, true),
              const SizedBox(height: 12),
              Container(
                width: size.width / 4,
                child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text('${dialogLabel.toUpperCase()}'),
                    style: buttonStyle),
              ),
            ],
          ),
        ),
      );
    },
  );
}
