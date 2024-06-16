import 'package:flutter/material.dart';

class TEST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar();
  }

  Widget _buildBody() {
    return Column();
  }

  // Widget _nedenTercihEtmelisiniz(BuildContext context) {
  //   return Column(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.only(
  //           bottom: 0,
  //         ),
  //         decoration: const BoxDecoration(
  //           border: Border(bottom: BorderSide(color: Colors.black, width: 2.0)),
  //         ),
  //         width: double.infinity,
  //         child: const Text(
  //           "NEDEN BİZİ TERCİH ETMELİSİNİZ?",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 275,
  //         width: double.infinity,
  //         child: Container(
  //             child: CarouselSlider(
  //           items: [
  //             <String, dynamic>{
  //               "text": "HIZLI ve GÜVENLİ İŞLEMLER",
  //               "icon": Icons.shield,
  //               "color": Colors.orange
  //             },
  //             <String, dynamic>{
  //               "text": "7/24 CANLI DESTEK",
  //               "icon": Icons.contact_support,
  //               "color": Colors.blue
  //             },
  //             <String, dynamic>{
  //               "text": "TECRÜBE",
  //               "icon": Icons.science,
  //               "color": Colors.red
  //             },
  //             <String, dynamic>{
  //               "text": "MÜŞTERİ MEMNUNİYETİ",
  //               "icon": Icons.tag_faces,
  //               "color": Colors.green
  //             },
  //           ].map((iconMap) {
  //             return Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: Card(
  //                 child: Container(
  //                   height: 200,
  //                   // width: MediaQuery.of(context).size.width,
  //                   width: 300,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 60,
  //                         child: Icon(
  //                           iconMap["icon"],
  //                           size: 75,
  //                           color: iconMap["color"],
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8),
  //                         child: Text(
  //                           iconMap["text"].toString(),
  //                           style: const TextStyle(
  //                               fontSize: 20, fontWeight: FontWeight.bold),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           options: CarouselOptions(
  //             height: 300,
  //           ),
  //         )),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildHakkimizdaCard() {
    String hakkimizdaText = "Lorem ipsum dolor sit amet consectetur adipiscing "
        "elit penatibus ornare eget pulvinar eu laoreet justo elementum dictum "
        "et sagittis senectus praesent suscipit orci leo metus egestas "
        "tincidunt est eros vulputate vivamus iaculis pretium bibendum hac "
        "donec curae efficitur euismod tempor parturient congue massa erat "
        "quis varius taciti tempus aptent hendrerit";

    return Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 1),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2))),
                width: double.infinity,
                child: const Text(
                  "HAKKIMIZDA",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                hakkimizdaText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHedefimiz() {
    String hakkimizdaText = "Lorem ipsum dolor sit amet consectetur adipiscing "
        "elit penatibus ornare eget pulvinar eu laoreet justo elementum dictum "
        "et sagittis senectus praesent suscipit orci leo metus egestas "
        "tincidunt est eros vulputate vivamus iaculis pretium bibendum hac "
        "donec curae efficitur euismod tempor parturient congue massa erat "
        "quis varius taciti tempus aptent hendrerit";

    return Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              "assets/otobüs2.jpg",
              height: 260,
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            // _buildSizedBox(10),
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2))),
                    width: double.infinity,
                    child: const Text(
                      "HEDEFİMİZ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    hakkimizdaText,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
