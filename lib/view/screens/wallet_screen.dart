import 'package:crypto_invest/view/widgets/custom_app_bar.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalletViewModel(),
      child: Consumer<WalletViewModel>(
        builder: (context, viewModel, index) {
          return viewModel.loading
              ? Center(child: RefreshProgressIndicator())
              : Column(
                  children: [
                    customAppBar(context, viewModel),
                    // const SizedBox(height: 25),
                    // Text(viewModel.coinBalance.toString().isNotEmpty
                    //     ? 'Coin Balance: ${viewModel.coinBalance}'
                    //     : '0')
                  ],
                );
        },
      ),
    );
  }
}
