import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ProfilView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Profil Sayfası",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  Widget _buildBody() {
    return const Center(child: Text("PROFİL SAYFASI BODY"));
  }
}
