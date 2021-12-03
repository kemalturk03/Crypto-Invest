import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/widgets/crypto_card.dart';
import 'package:crypto_invest/widgets/expanded_crypto_card.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isClicked = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: currenciesList.length - 10,
              itemBuilder: (context, index) {
                if (isClicked == true && currentIndex == index) {
                  return expandedCryptoCard(
                    context: context,
                    index: index,
                    currenciesList: currenciesList,
                    onPressed: () {
                      setState(() {
                        isClicked = false;
                      });
                    },
                  );
                }
                return cryptoCard(
                  context: context,
                  currency: currenciesList[index],
                  colour:
                      index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
                  onPressed: () {
                    setState(() {
                      isClicked = true;
                      currentIndex = index;
                    });
                    print("$index. index clicked $isClicked");
                  },
                );
              }),
        ),
      ],
    );
  }
}
/*_isClicked == false
                  ?
                  : */
