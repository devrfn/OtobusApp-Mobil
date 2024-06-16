import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:otobus_app/components/sefer_sehir_dropdown_button.dart';
import 'package:otobus_app/providers/image_slider_provider.dart';
import 'package:otobus_app/providers/login_provider.dart';
import 'package:otobus_app/tools/log/developer_log.dart';
import 'package:otobus_app/view_model/anasayfa_vm.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class AnasayfaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      drawer: _buildDrawer(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
    return AppBar(
      title: Text(viewModel.appBarTitle,
          style: const TextStyle(
            color: Colors.white,
          )),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    devLog.logSuccess("_buildBody() is created", where: "anasayfa_view.dart");
    return ListView(children: [
      Column(
        children: [
          _buildBackgroundImageAndSeferAra(context),
          _buildSizedBox(height: 60),
          Column(
            children: [
              _buildHakkindaCard(),
              _buildSizedBox(height: 60),
              _buildOtobusImageSlider(context),
              _buildSizedBox(height: 60),
              _buildWhyOtobusApp(),
              _buildSizedBox(height: 60),
              _buildSSS(),
              _buildSizedBox(height: 60),
            ],
          ),
          _buildFooter()
        ],
      ),
    ]);
  }

  // ANASAYFA SEFER ARAMA
  Widget _buildBackgroundImageAndSeferAra(BuildContext context) {
    var viewModel = Provider.of<AnasayfaVM>(context, listen: false);

    double genislik = (MediaQuery.of(context).size.width / 7) * 6;
    double solBosluk = (MediaQuery.of(context).size.width / 7) / 2;
    double fullGenislik = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: fullGenislik,
              height: 600,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      // image: AssetImage("assets/imgs/background_image1.jpg"),
                      image: AssetImage(
                          "assets/imgs/sefer_arama_background_image1.jpeg"),
                      fit: BoxFit.fill)),
            ),
            Positioned(
              top: 100,
              left: solBosluk,
              width: genislik,
              height: 400,
              child: Opacity(
                opacity: 0.75,
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // ANASAYFA - NEREDEN DROPDOWN BUTTON
                        SeferSehirDropDownButton(
                            labelText: "NEREDEN",
                            dropdownValue: viewModel.sehirNereden,
                            onChangedCallback: (
                              value,
                            ) {
                              if (value != null) {
                                viewModel.sehirNereden = value;
                              }
                            }),
                        // ANASAYFA - NEREYE DROPDOWN BUTTON
                        SeferSehirDropDownButton(
                            labelText: "NEREYE",
                            dropdownValue: viewModel.sehirNereye,
                            onChangedCallback: (
                              value,
                            ) {
                              if (value != null) {
                                viewModel.sehirNereye = value;
                              }
                            }),
                        _buildDateTimePicker(context),
                        _buildSeferAraButton(context),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ANASAYFA - TARİH SEÇME BUTTON
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
            Consumer<AnasayfaVM>(
              builder:
                  (BuildContext context, AnasayfaVM provider, Widget? child) {
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

  // ANASAYFA - DATETIME PICKER ALERT DIALOG
  Future _dateTimePicker(BuildContext context) async {
    var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
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

  // ANASAYFA - SEFER ARA BUTTON
  Widget _buildSeferAraButton(BuildContext context) {
    var viewModel = Provider.of<AnasayfaVM>(context, listen: false);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8, right: 10, left: 10, top: 10),
      child: ElevatedButton(
        onPressed: () {
          viewModel.seferlerSayfasiniFiltreliAc(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
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

  // ANASAYFA - HAKKINDA
  Widget _buildHakkindaCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HAKKIMIZDA",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 116, 115, 115)),
                      )
                    ])),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/imgs/about.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildSizedBox(height: 10),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                child: Text(
                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambl. ",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 94, 94, 94)),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ANASAYFA - IMAGE SLIDER
  Widget _buildOtobusImageSlider(BuildContext context) {
    var viewModel = Provider.of<ImageSliderProvider>(context, listen: false);
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              height: 200,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                viewModel.currentIndex = index;
              }),
          items: viewModel.sliderItems,
        ),
        const SizedBox(
          height: 18,
        ),
        Consumer<ImageSliderProvider>(
          builder: (BuildContext context, ImageSliderProvider provider,
              Widget? child) {
            return AnimatedSmoothIndicator(
              activeIndex: provider.currentIndex,
              count: provider.sliderItems.length,
              effect: WormEffect(
                  dotHeight: 14,
                  dotWidth: 14,
                  spacing: 14,
                  dotColor: Colors.grey.shade300,
                  activeDotColor: Colors.blue,
                  paintStyle: PaintingStyle.fill),
            );
          },
        )
      ],
    );
  }

  // ANASAYFA - WHY OTOBUS APP
  Widget _buildWhyOtobusApp() {
    // rgb(247,247,247)
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          _buildSizedBox(height: 15),
          const ListTile(
            leading: Icon(Icons.shield_outlined),
            title: Text(
              "Health and Safety",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle:
                Text("Keep yourself and others safe while traveling with us."),
          ),
          _buildSizedBox(height: 15),
          const ListTile(
            leading: Icon(Icons.airline_seat_recline_normal_rounded),
            title: Text(
              "Comfort on board",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Our buses are equipped with large and comfortable seats, a toilet, Wi-Fi and power outlets."),
          ),
          _buildSizedBox(height: 15),
          const ListTile(
            leading: Icon(Icons.map_outlined),
            title: Text(
              "Largest bus network in Europe",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Choose from over 3,000 travel destinations in 40+ countries and discover Europe with FlixBus"),
          ),
          _buildSizedBox(height: 15),
          const ListTile(
            leading: Icon(Icons.energy_savings_leaf_outlined),
            title: Text(
              "Travel environmentally-friendly",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Our efficient coaches are proven to have an excellent carbon footprint per driven passenger-kilometer."),
          ),
          _buildSizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildSSS() {
    return Card(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 238, 238, 238),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIKÇA SORULAN SORULAR",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildSSSCard(
              titleText: "Sed ut perspiciatis unde omnis?",
              contentText:
                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"),
          _buildSSSCard(
              titleText: "Li Europan lingues es membres del?",
              contentText:
                  "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular."),
          _buildSSSCard(
              titleText: "Far far away, behind the?",
              contentText:
                  "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right"),
          _buildSSSCard(
              titleText: "One morning, when Gregor Samsa?",
              contentText:
                  "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like"),
        ],
      ),
    );
  }

  Widget _buildSSSCard({String? titleText, String? contentText}) {
    contentText = contentText ??=
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod at massa id finibus. Sed felis magna, egestas dictum tincidunt ut, vulputate eget orci. Vestibulum efficitur.";

    titleText = titleText ?? "Lorem ipsum dolor sit?";

    return ExpansionTile(
      collapsedBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      title: Text(
        titleText,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      trailing: const Icon(
        Icons.add_box_outlined,
        color: Colors.blueGrey,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Text(
            contentText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // ANASAYFA - FOOTER
  Widget _buildFooter() {
    return Container(
      // rgb(1,58,145)
      padding: const EdgeInsets.all(18),
      color: const Color.fromRGBO(1, 58, 145, .8),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  "Seyehat Bilgileri",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Yolcu Hakları",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Şubelerimiz",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Servislerimiz",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  "Kurumsal",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Tarihçemiz",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Belgelerimiz",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Makaleler",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // ------------------------ DRAWER --------------------------
  // ------------------------< DRAWER >---------------------------
  // -------------------------------------------------------------
  Widget _buildDrawer(BuildContext context) {
    var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
    double width = (MediaQuery.of(context).size.width / 5) * 4;

    return Drawer(
      key: viewModel.scaffoldKey,
      // width: (MediaQuery.of(context).size.width / 100) * 85,
      width: width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // DRAWER HEADER
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration:
                // DRAWER HEADER BACKGROUND COLOR
                const BoxDecoration(color: Color.fromRGBO(62, 102, 197, 1)),
            child: Center(child: Consumer<LoginProvider>(
              builder: (BuildContext context, LoginProvider provider,
                  Widget? child) {
                // LOGIN OLUNDUĞUNDA KULLANICI İSMİNİ ALIR.
                String isim = (provider.isim != null)
                    ? provider.isim!.isNotEmpty
                        ? provider.isim.toString()
                        : ""
                    : "";
                // LOGIN OLUNMDA DURUMUNA GÖRE DRAWER HEADER
                return isim.isEmpty
                    ?
                    // LOGİN OLUNMAMIŞSA
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            viewModel.drawerHeaderText,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      )
                    :
                    // LOGIN OLUNMUŞSA
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            viewModel.drawerHeaderText,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          _buildSizedBox(height: 10),
                          Text(
                            "/$isim",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      );
              },
            )),
          ),
          const Divider(
            color: Color.fromARGB(255, 167, 167, 167),
            height: 1,
            thickness: 2,
          ),
          _buildDrawerMenuItem(context),
        ],
      ),
    );
  }

  // ANASAYFA DRAWER - MENU ITEM
  Widget _buildDrawerMenuItem(BuildContext context) {
    AnasayfaVM viewModel = Provider.of<AnasayfaVM>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // DRAWER MENU - ANASAYFA
        Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            leading: const Icon(Icons.home),
            title: Text(viewModel.drawerMenuItemAnasayfaText),
            onTap: () {},
          ),
        ),

        // DRAWER MENU - SEFERLER
        Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            leading: const Icon(Icons.directions_bus_sharp),
            title: Text(viewModel.drawerMenuItemSeferlerText),
            onTap: () {
              viewModel.seferlerSayfasiniAc(context);
            },
          ),
        ),

        // DRAWER MENU - PROFİL (ROLE => MEMBER)
        Consumer<LoginProvider>(
          builder:
              (BuildContext context, LoginProvider provider, Widget? child) {
            return (provider.rol == "Member" && provider.isLoginned == true)
                ? Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(viewModel.drawerMenuItemProfilText),
                      onTap: () {
                        viewModel.profilSayfasiniAc(context);
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),

        // DRAWER MENU - PANEL (ROLE => ADMİN)
        Consumer<LoginProvider>(
          builder:
              (BuildContext context, LoginProvider provider, Widget? child) {
            return (provider.rol == "Admin" && provider.isLoginned == true)
                ? Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: ListTile(
                      leading: const Icon(Icons.app_registration_rounded),
                      title: Text(viewModel.drawerMenuItemPanelText),
                      onTap: () {
                        viewModel.panelSayfasiniAc(context);
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),

        // DRAWER MENU - KAYIT OL (LOGIN => FALSE)
        Consumer<LoginProvider>(
          builder:
              (BuildContext context, LoginProvider provider, Widget? child) {
            return (provider.isLoginned != true)
                ? Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: ListTile(
                      leading: const Icon(Icons.person_add),
                      title: Text(viewModel.drawerMenuItemKayitOlText),
                      onTap: () {
                        viewModel.kayitOlSayfasiniAc(context);
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),

        // DRAWER MENU - GİRİŞ (LOGIN => FALSE)
        Consumer<LoginProvider>(
          builder:
              (BuildContext context, LoginProvider provider, Widget? child) {
            return (provider.isLoginned != true)
                ? Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: ListTile(
                      leading: const Icon(Icons.login),
                      title: Text(viewModel.drawerMenuItemGirisText),
                      onTap: () {
                        viewModel.girisSayfasiniAc(context);
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),

        // DRAWER MENU - ÇIKIŞ (LOGIN => TRUE)
        Consumer<LoginProvider>(
          builder:
              (BuildContext context, LoginProvider provider, Widget? child) {
            if (provider.isLoginned == true) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                margin: const EdgeInsets.only(bottom: 1),
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(viewModel.drawerMenuItemCikisText),
                  onTap: () async {
                    await viewModel.removeTokenWithSharedPrefences();
                    var loginProvider =
                        Provider.of<LoginProvider>(context, listen: false);
                    loginProvider.reset();
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
