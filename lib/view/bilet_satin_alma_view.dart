// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:otobus_app/view_model/bilet_satin_alma_vm.dart';
import 'package:provider/provider.dart';

class BiletSatinAlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("build() is called in 'bilet_satin_alma_view.dart'");

    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  AppBar _buildAppBar(BuildContext context) {
    debugPrint("_buildAppBar() is called in 'bilet_satin_alma_view.dart'");

    var viewModel = Provider.of<BiletSatinAlVM>(context, listen: false);

    return AppBar(
      title: Text(
        viewModel.appBarTitleText,
        style: const TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody(BuildContext context) {
    debugPrint("_buildBody() is called in 'bilet_satin_alma_view.dart'");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView(
        children: [
          _buildSizedBox(height: 10),
          _buildSeyehatBilgileri(context),
          _buildSizedBox(height: 20),
          _buildYolcuBilgileri(context),
          _buildSizedBox(height: 20),
          _buildOdemeBilgileri(context),
          _buildSizedBox(height: 20),
          _buildOdemeYapButton(context),
          _buildSizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOdemeYapButton(BuildContext context) {
    debugPrint(
        "_buildOdemeYapButton() is called in 'bilet_satin_alma_view.dart'");

    var viewModel = Provider.of<BiletSatinAlVM>(context, listen: false);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),

      // ÖDEME YAP BUTTON
      child: ElevatedButton(
        onPressed: () {
          viewModel.odemeYap(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        child: Text(
          viewModel.odemeYapButtonText,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOdemeBilgileri(BuildContext context) {
    debugPrint(
        "_buildOdemeBilgiler() is called in 'bilet_satin_alma_view.dart'");

    var viewModel = Provider.of<BiletSatinAlVM>(context, listen: false);

    // ODEME BİLGİLERİ - CARD
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.odemeBilgileriText,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              // ODEME BİLGİLERİ - FORM
              Form(
                key: viewModel.odemeBilgileriFormKey,
                child: Column(
                  children: [
                    // ODEME BİLGİLERİ - KART NUMARASI
                    TextFormField(
                      onChanged: (String value) {
                        viewModel.kartNumarasiFormat(value);
                      },
                      controller: viewModel.kartNumarasiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: viewModel.kartNumarasiText,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {
                        return viewModel.kartNumarasiValidator(input);
                      },
                    ),

                    _buildSizedBox(height: 15),

                    // ODEME BİLGİLERİ - KART TARİHİ
                    TextFormField(
                      onChanged: (String value) {
                        viewModel.kartTarihFormat(value);
                      },
                      controller: viewModel.tarihController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          labelText: viewModel.kartTarihTextFormFieldLabelText,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {
                        return viewModel.kartTarihiValidator(input);
                      },
                    ),

                    _buildSizedBox(height: 15),

                    // ODEME BİLGİLERİ - CSV
                    TextFormField(
                      onChanged: (String value) {
                        if (value.length >= 4) {
                          viewModel.csvController.text = value.substring(0, 3);
                        }
                      },
                      controller: viewModel.csvController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: viewModel.kartCSVTextFormFieldLabelText,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {
                        return viewModel.kartCSVValidator(input);
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildYolcuBilgileri(BuildContext context) {
    debugPrint(
        "_buildYolcuBilgileri() is called in 'bilet_satin_alma_view.dart'");

    var viewModel = Provider.of<BiletSatinAlVM>(context, listen: false);

    // YOLCU BİLGİLERİ - CARD
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.yolcuBilgileriText,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              _buildSizedBox(height: 25),

              // YOLCU BİLGİLERİ FORM
              Form(
                key: viewModel.yolcuBilgileriFormKey,
                child: Column(
                  children: [
                    // YOLCU BİLGİLERİ - İSİM
                    TextFormField(
                      onChanged: (String value) {},
                      controller: viewModel.isimController,
                      decoration: InputDecoration(
                          labelText: viewModel.isimTextFormFieldLabelText,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {
                        return viewModel.isimValidator(input);
                      },
                    ),

                    _buildSizedBox(height: 15),

                    // YOLCU BİLGİLERİ - SOYİSİM
                    TextFormField(
                      onChanged: (String value) {},
                      controller: viewModel.soyisimController,
                      decoration: InputDecoration(
                          labelText: viewModel.soyisimTextFormFieldLabelText,
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {
                        return viewModel.soyisimValidator(input);
                      },
                    ),

                    _buildSizedBox(height: 15),

                    // YOLCU BİLGİLERİ - CİNSİYET
                    // [ ] CİNSİYET RADIO BUTTON'A DÖNÜŞTÜRÜLECEK
                    TextFormField(
                      onChanged: (String value) {},
                      controller: null,
                      decoration: InputDecoration(
                          labelText: "Cinsiyet",
                          filled: true,
                          fillColor: Colors.white30,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (String? input) {},
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildSeyehatBilgileri(BuildContext context) {
    debugPrint(
        "_buildSeyehatBilgileri() is called in 'bilet_satin_alma_view.dart'");

    var viewModel = Provider.of<BiletSatinAlVM>(context, listen: false);

    // SEYEHAT BİLGİLERİ - CARD
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.seyehatBilgileri,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              _buildSizedBox(height: 25),

              // SEYEHAT BİLGİLERİ - KALKIŞ
              Text(
                viewModel.seyehatBilgileriKalkisText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              _buildSizedBox(height: 5),

              Text("Ankara".toUpperCase(),
                  style: const TextStyle(fontSize: 18)),

              _buildSizedBox(height: 18),

              // SEYEHAT BİLGİLERİ - VARIŞ
              Text(viewModel.seyehatBilgileriVarisText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),

              _buildSizedBox(height: 5),

              Text("Konya".toUpperCase(), style: const TextStyle(fontSize: 18)),

              _buildSizedBox(height: 18),

              // SEYEHAT BİLGİLERİ - TARİH & SAAT
              Text(viewModel.seyehatBilgileriTarihVeSaatText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),

              _buildSizedBox(height: 5),

              Text("15/05/2024  22:00".toUpperCase(),
                  style: const TextStyle(fontSize: 18)),

              _buildSizedBox(height: 18),

              // SEYEHAT BİLGİLERİ - FİYAT
              Text(viewModel.seyehatBilgileriFiyatText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),

              _buildSizedBox(height: 5),
              Text("1000 TL".toUpperCase(),
                  style: const TextStyle(fontSize: 18)),
            ]),
      ),
    );
  }

  Widget _buildSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
