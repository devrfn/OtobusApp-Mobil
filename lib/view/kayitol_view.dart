import 'package:flutter/material.dart';
import 'package:otobus_app/view_model/kayitol_wm.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class KayitOlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return AppBar(
      title: Text(
        viewModel.appBarTitle,
        style: const TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return Column(
      children: [
        Expanded(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildSizedBox(height: 20),
                    // Form başlık
                    _buildFormBaslik(context),
                    _buildSizedBox(height: 30),

                    // İsim textField
                    _buildIsimTextFormField(context),
                    _buildSizedBox(height: 30),

                    // Soyisim textField
                    _buildSoyIsimTextFormField(context),
                    _buildSizedBox(height: 30),

                    // Email textField
                    _buildEmailTextFormField(context),
                    _buildSizedBox(height: 30),

                    // Password textField
                    _buildPasswordTextFormField(context),
                    _buildSizedBox(height: 30),

                    // Cinsiyet
                    _buildCinsiyetRadioButton(context),
                    _buildSizedBox(height: 30),

                    // Kayıtol butonu
                    _buildKayitOlButton(context),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  // CİNSİYET RADİO BUTTON
  Widget _buildCinsiyetRadioButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Consumer<KayitOlWM>(
            builder: (BuildContext context, KayitOlWM provider, Widget? child) {
              return provider.cinsiyetRadioButtonErrorText.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.cinsiyetRadioButtonText,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.cinsiyetRadioButtonText,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          provider.cinsiyetRadioButtonErrorText,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 189, 34, 23)),
                        )
                      ],
                    );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<KayitOlWM>(
          builder: (BuildContext context, KayitOlWM provider, Widget? child) {
            return RadioListTile(
                activeColor: Colors.blue,
                title: Text(provider.erkekRadioButtonTitleText),
                value: 1,
                groupValue: provider.cinsiyetGroupValue,
                onChanged: (int? num) {
                  print(provider.cinsiyetGroupValue);
                  provider.cinsiyetGroupValue = num;
                });
          },
        ),
        Consumer<KayitOlWM>(
          builder: (BuildContext context, KayitOlWM provider, Widget? child) {
            return // RADIO BUTTON KADIN
                RadioListTile(
                    activeColor: Colors.red,
                    title: Text(provider.kadinRadioButtonTitleText),
                    value: 0,
                    groupValue: provider.cinsiyetGroupValue,
                    onChanged: (int? num) {
                      print(provider.cinsiyetGroupValue);
                      provider.cinsiyetGroupValue = num;
                    });
          },
        ),
      ],
    );
  }

  // KAYIT OL FORM - BAŞLIK
  Widget _buildFormBaslik(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                viewModel.kayitOlFormBaslik,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            )),
        _buildSizedBox(height: 10),
        SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Consumer<KayitOlWM>(
                builder:
                    (BuildContext context, KayitOlWM provider, Widget? child) {
                  return provider.isKayitOlFailed
                      ? Text(
                          provider.kayitOlFormAltBaslik,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                      : Text(
                          provider.kayitOlFormAltBaslik,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        );
                },
              ),
            )),
      ],
    );
  }

  // KAYIT OL FORM - İSİM TEXT FORM FIELD
  Widget _buildIsimTextFormField(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return TextFormField(
      controller: viewModel.tfIsimController,
      decoration: InputDecoration(
          labelText: viewModel.isimTextFormFieldLabelText,
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (String? input) {
        return viewModel.isimValidator(input);
      },
    );
  }

  // KAYIT OL FORM - SOYİSİM TEXT FORM FIELD
  Widget _buildSoyIsimTextFormField(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return TextFormField(
      controller: viewModel.tfSoyisimController,
      decoration: InputDecoration(
          labelText: viewModel.soyisimTextFormFieldLabelText,
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (String? input) {
        return viewModel.soyisimValidator(input);
      },
    );
  }

  // KAYIT OL FORM - EMAİL TEXT FORM FIELD
  Widget _buildEmailTextFormField(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: viewModel.tfEmailController,
      decoration: InputDecoration(
          labelText: viewModel.emailTextFormFieldLabelText,
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (String? input) {
        return viewModel.emailValidator(input);
      },
    );
  }

  // KAYIT OL FORM - ŞİFRE TEXT FORM FIELD
  Widget _buildPasswordTextFormField(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return TextFormField(
      controller: viewModel.tfPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: viewModel.sifreTextFormFieldLabelText,
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (String? input) {
        return viewModel.sifreValidator(input);
      },
    );
  }

  // KAYIT OL FORM - KAYIT OL BUTTON
  Widget _buildKayitOlButton(BuildContext context) {
    KayitOlWM viewModel = Provider.of<KayitOlWM>(context, listen: false);

    return ElevatedButton(
      onPressed: () async {
        await viewModel.register(context);
      },
      style: ElevatedButton.styleFrom(
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            viewModel.kayitOlButtonText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )),
    );
  }

  Widget _buildSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
