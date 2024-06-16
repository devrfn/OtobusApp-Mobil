import 'package:flutter/material.dart';
import 'package:otobus_app/components/sefer_sehir_dropdown_button.dart';
import 'package:otobus_app/model/koltuk/koltuk_model.dart';
import 'package:otobus_app/model/sefer/sefer_extra_model.dart';
import 'package:otobus_app/view_model/seferler_wm.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class SeferlerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: null,
      title: const Text(
        "Seferler",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(shrinkWrap: true, children: [
            Card(
              elevation: 5,
              child: ExpansionTile(
                  shape: const Border(
                      bottom: BorderSide.none,
                      left: BorderSide.none,
                      right: BorderSide.none,
                      top: BorderSide.none),
                  leading: const Icon(Icons.search),
                  title: const Text(
                    "SEFER ARA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Ne Zaman
                          _buildNeredenDropDown(context),

                          // Nereye
                          _buildNereyeDropDown(context),

                          // DateTime Picker
                          _buildDateTimePicker(context),

                          // Sefer Ara Button
                          _buildSeferAraButton(context),

                          _buildSizedBox(height: 10),
                        ],
                      ),
                    ),
                  ]),
            ),
            _buildSizedBox(height: 15),
            _buildDivider(),
            _buildSizedBox(height: 5),
            _buildSeferlerListe(context),
          ]),
        ),
      ],
    );
  }

  Widget _buildSeferAraButton(BuildContext context) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10, top: 10),
      child: ElevatedButton(
        onPressed: () async {
          await viewModel.seferleriGetirExtra();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 12),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        child: const Text(
          "SEFER ARA",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // SEFER ARA - NEREDEN DROPDOWN BUTTON
  Widget _buildNeredenDropDown(BuildContext context) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);
    return SeferSehirDropDownButton(
      dropdownValue: viewModel.sehirNereden,
      labelText: "NEREDEN",
      onChangedCallback: (String? value) {
        if (value != null) {
          viewModel.sehirNereden = value;
        }
      },
    );
  }

  // SEFER ARA - NEREYE DROPDOWN BUTTON
  Widget _buildNereyeDropDown(BuildContext context) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);
    return SeferSehirDropDownButton(
        dropdownValue: viewModel.sehirNereye,
        labelText: "NEREYE",
        onChangedCallback: (String? value) {
          if (value != null) {
            viewModel.sehirNereden = value;
          }
        });
  }

  // SEFER ARA - TARİH SEÇME BUTTON
  Widget _buildDateTimePicker(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 10),
      child: OutlinedButton(
        onPressed: () async {
          await _dateTimePicker(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TARİH TEXT
            Consumer<SeferlerVM>(
              builder:
                  (BuildContext context, SeferlerVM provider, Widget? child) {
                return Text(
                  provider.date,
                  style: const TextStyle(fontSize: 21, color: Colors.black),
                );
              },
            ),
            const SizedBox(
              width: 15,
            ),

            // TAKVİM ICON
            const Icon(
              Icons.calendar_month,
              color: Colors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  // DATETIME PICKER ALERT DIALOG
  Future _dateTimePicker(BuildContext context) async {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);
    int firstDate = DateTime.now().year;
    int lastDate = firstDate + 5;
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime(firstDate),
      lastDate: DateTime(lastDate),
    );
    if (date != null) {
      viewModel.date = date.toString();
    }
  }

  Widget _buildSizedBox({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 2,
    );
  }

  Widget _buildSeferlerListe(BuildContext context) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);
    return Consumer<SeferlerVM>(
      builder: (BuildContext context, SeferlerVM value, Widget? child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: viewModel.seferler.length,
          itemBuilder: (BuildContext context, int index) {
            SeferExtraModel sefer = viewModel.seferler[index];
            return _buildListTile(sefer, context);
          },
        );
      },
    );
  }

  Widget _buildListTile(SeferExtraModel sefer, BuildContext context) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: ExpansionTile(
          subtitle: Row(
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SAAT : ${viewModel.getTimeFromDateTimeString(sefer.seferTarihi ?? '')}",
                    ),
                    Text(
                      "${sefer.seferFiyati.toString()} TL",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
          shape: const Border(
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              top: BorderSide.none),
          title: Row(
            children: [
              Text(
                sefer.kalkisYeri ?? "___",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.trending_flat_outlined,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                sefer.varisYeri ?? "___",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),

          // Expantion Tile
          children: [
            _buildDivider(),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          const Color.fromRGBO(241, 70, 104, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "44",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Dolu Kadın",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ]),
            Row(children: [
              ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          const Color.fromRGBO(72, 95, 199, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "44",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Dolu Erkek",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ]),
            Row(children: [
              ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          const Color.fromRGBO(240, 240, 240, 1),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.4),
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "44",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Boş Koltuk",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ]),
            Row(children: [
              ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:
                          const Color.fromARGB(255, 32, 105, 36),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.4),
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "44",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Seçilen Koltuk",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ]),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "KOLTUK NO",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<SeferlerVM>(
                      builder: (BuildContext context, SeferlerVM provider,
                          Widget? child) {
                        return Text(
                          "${provider.selectedKoltukNo}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      },
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // [ ]: Koltuk seçili ise bilet satın alma sayfasına geçilecek.
                    // viewModel.biletSatinAlmaSayfasiniAc(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    "Satın Al",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _buildOtobusIlkSira(),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [1, 2, 3, 4],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [5, 6, 7, 8],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [9, 10, 11, 12],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [13, 14, 15, 16],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [17, 18, 19, 20],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [21, 22, 23, 24],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow2Koltuk(context,
                                  koltukNumaralari: [25, 26],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow2Koltuk(context,
                                  koltukNumaralari: [27, 28],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [29, 30, 31, 32],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [33, 34, 35, 36],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [37, 38, 39, 40],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [41, 42, 43, 44],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [45, 46, 47, 48],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [49, 50, 51, 52],
                                  koltuklar: sefer.koltuk),
                              _buildOtobusRow4Koltuk(context,
                                  koltukNumaralari: [53, 54, 55, 56],
                                  koltuklar: sefer.koltuk),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtobusRow2Koltuk(BuildContext context,
      {required List<int> koltukNumaralari,
      required List<KoltukModel>? koltuklar}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(context,
                  koltukNo: koltukNumaralari[0], koltuklar: koltuklar),
              _buildButton(context,
                  koltukNo: koltukNumaralari[1], koltuklar: koltuklar),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            width: 20,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
      ],
    );
  }

  Widget _buildOtobusRow4Koltuk(BuildContext context,
      {required List<int> koltukNumaralari,
      required List<KoltukModel>? koltuklar}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(context,
                  koltukNo: koltukNumaralari[0], koltuklar: koltuklar),
              _buildButton(context,
                  koltukNo: koltukNumaralari[1], koltuklar: koltuklar),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(
            height: 30,
            width: 20,
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(context,
                  koltukNo: koltukNumaralari[2], koltuklar: koltuklar),
              _buildButton(context,
                  koltukNo: koltukNumaralari[3], koltuklar: koltuklar),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtobusIlkSira() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.attractions,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required int koltukNo, required List<KoltukModel>? koltuklar}) {
    var viewModel = Provider.of<SeferlerVM>(context, listen: false);

    if (koltuklar != null) {
      var koltuk = koltuklar
          .where((koltukModel) => koltukModel.koltukNo == koltukNo)
          .toList();

      if (koltuk.isNotEmpty) {
        // rgb(161, 172, 224) => rgb(72,95,199)
        Color disabledErkekButtonColor = const Color.fromRGBO(72, 95, 199, 1);

        // rgb(241, 70, 104) => rgb(241,70,104)
        Color disabledKadinButtonColor = const Color.fromRGBO(241, 70, 104, 1);

        return koltuk[0].cinsiyet == true
            ? ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: disabledErkekButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text(
                  koltukNo.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ))
            : ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: disabledKadinButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text(
                  koltukNo.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ));
      }
      return viewModel.selectedKoltukNo == koltukNo
          ? ElevatedButton(
              onPressed: () {
                viewModel.selectedKoltukNo = koltukNo;
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 105, 36),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                koltukNo.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ))
          : ElevatedButton(
              onPressed: () {
                viewModel.selectedKoltukNo = koltukNo;
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                koltukNo.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              ));
    }
    return Container();
  }
}
