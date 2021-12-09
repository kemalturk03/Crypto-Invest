import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/view/widgets/coin_list_widget.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarketViewModel()),
        ChangeNotifierProvider(create: (context) => WalletViewModel()),
      ],
      child: Column(
        children: [
          Consumer<MarketViewModel>(
            builder: (context, marketViewModel, index) {
              return StreamBuilder(
                stream: marketViewModel.streamController.stream,
                builder: (context, AsyncSnapshot? snapshot) {
                  if (snapshot!.hasData) {
                    Market coinData = snapshot.data;
                    return coinListWidget(
                        coins: coinData.data!,
                        marketViewModel: marketViewModel);
                  }
                  return Center(
                    child: RefreshProgressIndicator(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
