import 'package:crypto_invest/view/screens/main_screen.dart';
import 'package:crypto_invest/view/screens/options_screen.dart';
import 'package:crypto_invest/view/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _tabs = [
    MainScreen(),
    WalletScreen(),
    OptionsScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
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
      ),
    );
  }
}
