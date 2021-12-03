import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
            Text('Wallet'.toUpperCase(), style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
