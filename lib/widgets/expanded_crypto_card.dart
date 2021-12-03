import 'package:flutter/material.dart';

Widget expandedCryptoCard(
    {required BuildContext context,
    required int index,
    required List<String> currenciesList,
    Function()? onPressed}) {
  return Container(
    color: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
    child: Column(
      children: [
        Container(
          child: Center(
            child: Text(
              '${currenciesList[index]} / USD',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          height: MediaQuery.of(context).size.height - 140,
        ),
        ElevatedButton(onPressed: onPressed, child: Text('Close'))
      ],
    ),
  );
}
