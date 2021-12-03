import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/service/market_service.dart';
import 'package:flutter/material.dart';

class MarketViewModel extends ChangeNotifier {
  MarketService _marketService = MarketService();
  /*Kanka bu class sana bahsettiğim state management ile ilgili class
  * Yani biz fonksiyonlarımızı buraya yazıcaz screen classlarında kullanıcaz
  * Screen classlarında kullanırken bu classa erişmek için Consumer diye bir widget var onu kulanıyoruz.*/

  MarketViewModel() {
    print("MarketViewModel Constructor Called");
    getMarkets();
    /*Burası bu classın constructorı gibi düşünebiliriz.
    Burada getMarkets metodunu çağırdım çünkü uygulama her açıldığında bu classı çağıracak ve
    Classı her çağırdığında bu metotu çağırarak API den aldığımız verileri listeye aktaracak*/
  }

  List<Market> _marketsList = [];
  int _listIndex = 0;
  bool _isClicked = false;

  /*_ ile başlayan değişkenler veya metotlar private anlamına geliyor.
  * Yani sadece bu classın içinde kullanabiliriz.
  * Önce private ları yukarıda tanımladık. Aşağıda ise get kullarak public olanlarını tanımladık.
  * Bu public olanları diğer screen classlarında veya herhangi bir diğer classta kullanabilicez
  * Özetle yukarıdakiler setter aşağıdakiler getter*/

  List<Market> get marketsList => _marketsList;
  int get listIndex => _listIndex;
  bool get isClicked => _isClicked;

  void setMarketsList(List<Market> marketsList) {
    /*Bu metot ise içine verdiğimiz listeyi bizim bu classtaki _marketsList'e atayacak*/
    _marketsList = marketsList;
    notifyListeners();
    /*notifyListeners'ı kullandığımız yerdeki işlem her neyse o işlemden sonra UI update ediliyor*/
  }

  void getMarkets() async {
    /*Bu getMarkets metotunu constructorda çağırarak bu metotun içindeki setMarketList'i kurmuş olucaz*/
    final response = await _marketService.fetchMarket();
    setMarketsList(response);
  }

  void setListIndex(int listIndex) {
    _listIndex = listIndex;
    notifyListeners();
  }

  void setClicked(bool isClicked) {
    _isClicked = isClicked;
    notifyListeners();
  }
}
