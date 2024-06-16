import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Card Tasarla",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Card(
        // color: Colors.blue,
        color: Color.fromARGB(255, 248, 248, 248),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset(
                    "assets/otobüs.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "HAKKIMIZDA",
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 66, 66, 66)),
                        )
                      ])),
              Container(
                height: 120,
                width: double.infinity,
                // color: Colors.yellow,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  child: const Text(
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambl",
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 66, 66, 66)),
                    textAlign: TextAlign.justify,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
