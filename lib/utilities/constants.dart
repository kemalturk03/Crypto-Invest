import 'package:flutter/material.dart';

const String mainUrl = "https://pro-api.coinmarketcap.com/v1/";
const String apiKey = "58cdbe15-26d4-4eb3-8d28-4b43811e8b78";
const String fullUrl = "${mainUrl}cryptocurrency/listings/latest";

const String iconUrl =
    "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";

/*COLOR CONSTANTS*/
const Color white = Colors.white;
const Color white70 = Colors.white70;
const Color white60 = Colors.white60;
const Color black = Colors.black;
const Color black54 = Colors.black54;
const Color grey = Colors.grey;
const Color blue = Colors.blue;
const Color lightBlue = Colors.lightBlue;
const Color amber = Colors.amber;
const Color yellowAccent = Colors.yellowAccent;
const Color yellow = Colors.yellow;
const Color red = Colors.red;
const Color transparent = Colors.transparent;
const Color green = Colors.green;
const Color greenAccent = Colors.greenAccent;

/*TEXTSTYLE CONSTANTS*/
const kBlackTS = TextStyle(color: black);
const kBlackHeaderTS = TextStyle(color: black, fontWeight: FontWeight.bold);
const kRedTS = TextStyle(color: red);
const kBlueTS = TextStyle(color: blue);
const kBlack54TS = TextStyle(color: black54);
const kWhiteTS = TextStyle(color: white, fontSize: 13);
const kProductHeaderTS =
    TextStyle(color: black, fontSize: 32, fontWeight: FontWeight.bold);
const kBalanceTS = TextStyle(color: white, fontWeight: FontWeight.bold);

/*DURATION CONSTANTS*/
const Duration waitASecond = Duration(seconds: 1);

/*RADIUS CONSTANTS*/
const Radius radius12 = Radius.circular(12);
const Radius radius16 = Radius.circular(16);

/*BOX DECORATION CONSTANTS*/
const BoxDecoration radius12Box =
    BoxDecoration(color: white, borderRadius: BorderRadius.all(radius12));
const BoxDecoration squareButtonBox =
    BoxDecoration(color: blue, borderRadius: BorderRadius.all(radius12));

/*EDGE INSETS CONSTANTS*/
const EdgeInsets fourPxHorizontal = EdgeInsets.symmetric(horizontal: 4);
const EdgeInsets eightPxHorizontal = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets fourPxAll = EdgeInsets.all(4);
const EdgeInsets eightPxAll = EdgeInsets.all(8);
const EdgeInsets zeroPadding = EdgeInsets.zero;

/*SIZED BOX CONSTANTS*/
const SizedBox sevenPxHeightSpace = SizedBox(height: 7);
const SizedBox sevenPxWidthSpace = SizedBox(width: 7);

/*TEXT INPUT ACTION CONSTANTS*/
const TextInputAction actionNext = TextInputAction.next;
const TextInputAction actionDone = TextInputAction.done;

/*BUTTON STYLE CONSTANTS*/
final kSellButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red.shade700),
    shape: MaterialStateProperty.all(StadiumBorder()));

final kBuyButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green.shade500),
    shape: MaterialStateProperty.all(StadiumBorder()));
