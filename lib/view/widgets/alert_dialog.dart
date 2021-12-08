import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/utilities/custom_text_field.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:flutter/material.dart';

import 'expanded_crypto_card.dart';

Future alertDialog(
    {required BuildContext context,
    String? title,
    MarketViewModel? viewModel}) {
  return showDialog(
    context: context,
    builder: (context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return AlertDialog(
        backgroundColor: grey,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        title: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'BUY $title',
                style: TextStyle(
                    fontSize: width / 16, fontWeight: FontWeight.bold),
              )),
        ),
        content: Container(
          height: height / 7,
          width: width / 1.5,
          child: Column(
            children: [
              customTextField(height, width, context, viewModel!),
              const SizedBox(height: 12),
              Container(
                width: width / 4,
                child: ElevatedButton(
                    onPressed: () {
                      var controller = viewModel.marketBuyController;
                      if (controller.text.isNotEmpty) {
                        print('Girilen Miktar: ${controller.text}');
                      }
                      Navigator.pop(context);
                      controller.clear();
                    },
                    child: Text('BUY'),
                    style: kBuyButtonStyle),
              ),
            ],
          ),
        ),
      );
    },
  );
}
