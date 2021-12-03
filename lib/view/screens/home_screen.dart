import 'package:crypto_invest/view/screens/tab_bar_screen.dart';
import 'package:crypto_invest/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, index) => onAppStarting(mainViewModel),
    );
  }
}

Widget onAppStarting(MainViewModel mainViewModel) {
  /*Bunu buraya ayırmamın sebebi eğer loading falan yapılacak olursa uygulama başlangıcında onu kontrol edip,
  * Ona göre bir yuvarlak yükleniyor indicator döndüren bir sayfaya yönlendirmek için.
  * Mesela diyecektim ki burada mainViewModel.isLaoding == true ise return AppLoading else return TabBarScreen.
  * Bunu belki daha sonra kullanabiliriz*/
  return TabBarScreen(viewModel: mainViewModel);
}

/*

Widget appLoading() {
  return Scaffold(
    body: Center(
      child: RefreshProgressIndicator(),
    ),
  );
}

*/
