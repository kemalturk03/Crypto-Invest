import 'package:crypto_invest/view/screens/tab_bar_screen.dart';
import 'package:crypto_invest/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, index) =>
          TabBarScreen(viewModel: mainViewModel),
    );
  }
}
