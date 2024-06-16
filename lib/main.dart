// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:otobus_app/providers/image_slider_provider.dart';
import 'package:otobus_app/providers/login_provider.dart';
import 'package:otobus_app/view/anasayfa_view.dart';
import 'package:otobus_app/view_model/anasayfa_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(), child: AnaUygulama()));
}

class AnaUygulama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginProvider>(context, listen: false);

    viewModel.tokenControl();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "CodecPro",
          appBarTheme:
              const AppBarTheme(color: Color.fromRGBO(62, 102, 197, 1)),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AnasayfaVM()),
            ChangeNotifierProvider(create: (context) => ImageSliderProvider()),
          ],
          child: AnasayfaView(),
        ));
  }
}
