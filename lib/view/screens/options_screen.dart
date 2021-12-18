import 'package:crypto_invest/utilities/components.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/utilities/custom_text_field.dart';
import 'package:crypto_invest/view/widgets/custom_app_bar.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WalletViewModel()),
      ],
      child: Consumer<WalletViewModel>(
        builder: (context, walletVM, index) {
          walletVM.firebaseRef.child('usdBalance').once().then((value) {
            print("Dollar Balance: ${value.value}");
          });
          return walletVM.loading
              ? customIndicator
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customAppBar(
                      context,
                      optionScreenAppBar(size),
                    ),
                    SizedBox(height: size.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customTextField(size.height, size.width / 1.5, walletVM,
                            'Add', walletVM.topUpBalanceController, false),
                        Container(
                          height: size.height / 20,
                          width: size.width / 5,
                          child: ElevatedButton(
                              onPressed: () async {
                                var controller =
                                    walletVM.topUpBalanceController;
                                if (controller.text.isNotEmpty) {
                                  var enteredValue =
                                      double.parse(controller.text);
                                  if (enteredValue <= 0) {
                                    walletVM.setSnackBarContent(
                                        'The value must be higher than 0!');
                                  } else if (enteredValue > 1000) {
                                    walletVM.setSnackBarContent(
                                        'The maximum value you can enter is \$1000');
                                  } else {
                                    walletVM.topUpBalance(enteredValue);
                                    walletVM.setSnackBarContent(
                                        '\$$enteredValue is successfully added to your account');
                                  }
                                } else {
                                  walletVM.setSnackBarContent(
                                      'The value cannot be empty!');
                                }
                                controller.clear();
                                showSnackBar(
                                    context: context,
                                    description: walletVM.snackBarContent);
                              },
                              child: Text('ADD', style: kBlackTS),
                              style: kYellowButtonStyle),
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
