import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view/widgets/custom_app_bar.dart';
import 'package:crypto_invest/view/widgets/large_wallet_card.dart';
import 'package:crypto_invest/view/widgets/wallet_card.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WalletViewModel())
      ],
      child: Consumer<WalletViewModel>(
        builder: (context, viewModel, index) {
          return viewModel.loading
              ? customIndicator
              : Column(
                  children: [
                    customAppBar(context, viewModel),
                    StreamBuilder(
                      stream: viewModel.firebaseRef.onValue,
                      builder: (context, AsyncSnapshot? snapshot) {
                        if (snapshot!.hasData) {
                          List<dynamic> list = (snapshot.data.snapshot
                                  .value['balances'] as Map<dynamic, dynamic>)
                              .keys
                              .toList();
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, int? index) {
                                Balance balance = Balance.fromJson(
                                    snapshot.data.snapshot.value, list[index!]);
                                if (viewModel.isClicked &&
                                    viewModel.listIndex == index) {
                                  return largeWalletCard(
                                      context: context,
                                      index: index,
                                      size: size,
                                      url: (iconUrl +
                                          '${balance.coin!.coinSymbol!.toLowerCase()}' +
                                          '.png'),
                                      coinSymbol: balance.coin!.coinSymbol!
                                          .toUpperCase(),
                                      balance: balance,
                                      viewModel: viewModel);
                                }
                                return walletCard(
                                    index: index,
                                    size: size,
                                    url: (iconUrl +
                                        '${balance.coin!.coinSymbol!.toLowerCase()}' +
                                        '.png'),
                                    coinSymbol:
                                        balance.coin!.coinSymbol!.toUpperCase(),
                                    balance: balance,
                                    viewModel: viewModel,
                                    onPressed: () {
                                      viewModel.setClicked(true);
                                      viewModel.setListIndex(index);
                                    });
                              },
                            ),
                          );
                        } else
                          return customIndicator;
                      },
                    )
                  ],
                );
        },
      ),
    );
  }
}
