import 'package:crypto_invest/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({MainViewModel? viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MainViewModel>(
        builder: (context, mainViewModel, index) {
          return Scaffold(
            backgroundColor: Colors.grey[800],
            body: mainViewModel.tabs[mainViewModel.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              currentIndex: mainViewModel.currentIndex,
              onTap: (int index) {
                mainViewModel.setCurrentIndex(index);
              },
              selectedIconTheme:
                  IconThemeData(color: Colors.yellow.shade800, size: 28),
              selectedItemColor: Colors.yellow.shade800,
              selectedFontSize: 16,
              unselectedIconTheme: IconThemeData(color: Colors.white),
              unselectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.stats_chart), label: 'Markets'),
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.wallet_outline), label: 'Wallet'),
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.cog_outline), label: 'Options'),
              ],
            ),
          );
        },
      ),
    );
  }
}
