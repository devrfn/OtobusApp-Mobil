import 'package:flutter/material.dart';
import 'package:otobus_app/providers/login_provider.dart';
import 'package:otobus_app/view_model/giris_wm.dart';
import 'package:provider/provider.dart';

class GirisView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Giriş Sayfası",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    GirisVM viewModel = Provider.of<GirisVM>(context, listen: false);

    return ListView(children: [
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

              // Kullanıcıadı textField
              _buildEmailTextFormField(context),
              _buildSizedBox(height: 30),

              // Şifre textFormField
              _buildPasswordTextFormField(context),
              _buildSizedBox(height: 30),

              // Giriş butonu
              _buildGirisButton(context),
              _buildSizedBox(height: 15),

              // Kayıtol butonu
              _buildKayitOlButton(context),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildSizedBox({double height = 0, double width = 0}) {
    return SizedBox(height: height, width: width);
  }

  Widget _buildFormBaslik(BuildContext context) {
    GirisVM viewModel = Provider.of<GirisVM>(context, listen: false);

    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                viewModel.girisFormBaslik,
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
              child: Consumer<GirisVM>(
                builder:
                    (BuildContext context, GirisVM provider, Widget? child) {
                  return provider.isLoginFailed
                      ? Text(
                          provider.girisFormAltBaslik,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(provider.girisFormAltBaslik,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                          ));
                },
              ),
            )),
      ],
    );
  }

  Widget _buildEmailTextFormField(BuildContext context) {
    GirisVM viewModel = Provider.of<GirisVM>(context, listen: false);

    return TextFormField(
      controller: viewModel.tfEmailController,
      keyboardType: TextInputType.emailAddress,
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

  Widget _buildPasswordTextFormField(BuildContext context) {
    GirisVM viewModel = Provider.of<GirisVM>(context, listen: false);

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

  Widget _buildGirisButton(BuildContext context) {
    var viewModel = Provider.of<GirisVM>(context, listen: false);
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          bool formControl = viewModel.formControl();
          if (formControl) {
            bool result = await viewModel.login();
            if (result) {
              await loginProvider.tokenControl();
              if (context.mounted) {
                viewModel.anasayfaGec(context);
              }
            } else {
              if (context.mounted) {
                await viewModel.errorAlert(context);
              }
            }
          } else {
            viewModel.resetFormBaslik();
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              viewModel.girisYapButtonText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
      ),
    );
  }

  Widget _buildKayitOlButton(BuildContext context) {
    var viewModel = Provider.of<GirisVM>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          viewModel.kayitOlSayfasiniAc(context);
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
      ),
    );
  }
}
