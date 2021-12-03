import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view/widgets/crypto_card.dart';
import 'package:crypto_invest/view/widgets/expanded_crypto_card.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MarketViewModel(),
      child: Column(
        children: [
          Consumer<MarketViewModel>(
            builder: (context, marketViewModel, index) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currenciesList.length - 10,
                  itemBuilder: (context, index) {
                    if (marketViewModel.isClicked &&
                        marketViewModel.listIndex == index) {
                      return expandedCryptoCard(
                        context: context,
                        index: index,
                        currenciesList: currenciesList,
                        onPressed: () {
                          marketViewModel.setClicked(false);
                        },
                      );
                    }
                    return cryptoCard(
                      context: context,
                      currency: currenciesList[index],
                      colour: index % 2 == 0
                          ? Color(0xFF1F2632)
                          : Color(0xFF12171A),
                      onPressed: () {
                        marketViewModel.setClicked(true);
                        marketViewModel.setListIndex(index);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
