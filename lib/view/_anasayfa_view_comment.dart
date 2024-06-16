// --------------------
// BUILD ANASAYFA BİLET
// --------------------
// Widget _buildAnasayfaBilet(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(12),
//     child: Column(
//       children: [
//         _buildBiletNereden(context),
//         _buildSizedBox(10),
//         _buildBiletNereye(context),
//         _buildSizedBox(10),
//         // Zaman seçimi yapılacak
//         _buildBiletNeZaman(context),
//       ],
//     ),
//   );
// }




// ----------------------
// BUILD DATE TIME PICKER
// ----------------------
// Future _buildDateTimePicker(BuildContext context) async {
//   var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
//   var firstDate = DateTime.now().year;
//   var lastDate = firstDate + 5;
//   var date = await showDatePicker(
//     context: context,
//     firstDate: DateTime(firstDate),
//     lastDate: DateTime(lastDate),
//   );
//   if (date != null) {
//     viewModel.date = date.toString();
//   }
// }




// ---------
// SEFER ARA
// ---------
// Widget _seferAra(BuildContext context) {
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
//           "SEFER ARA",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       _buildSizedBox(10),
//       _buildAnasayfaBilet(context),
//       _buildSizedBox(5),
//       _seferAramaButonu(context),
//       _buildSizedBox(20),
//     ],
//   );
// }




// ------------------
// SEFER ARAMA BUTONU 
// ------------------
// Widget _seferAramaButonu(BuildContext context) {
//   var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
//   return ElevatedButton(
//     onPressed: () {
//       viewModel.seferlerSayfasiniFiltreliAc(context);
//     },
//     style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         padding: const EdgeInsets.all(14),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//         )),
//     child: const Text(
//       "SEFER ARA",
//       style: TextStyle(color: Colors.white, fontSize: 16),
//     ),
//   );
// }




// ---------------------
// BUILD BİLET NEREDEN
// ---------------------
// Widget _buildBiletNereden(BuildContext context) {
//   AnasayfaVM viewModel = Provider.of<AnasayfaVM>(context, listen: false);
//   debugPrint("buildBiletNereden");
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       const Expanded(
//           flex: 2,
//           child: Text(
//             "Nereden : ",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           )),
//       Expanded(
//         flex: 4,
//         child: SizedBox(
//           height: 60,
//           child: DropdownButtonFormField<String>(
//             menuMaxHeight: 200,
//             value: viewModel.sehirNereden,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(width: 3),
//               ),
//             ),
//             borderRadius: BorderRadius.circular(4),
//             // dropdown-menu-item
//             items: viewModel.sehirler.map((sehir) {
//               return DropdownMenuItem(
//                 value: sehir,
//                 child: Row(
//                   children: [
//                     const Icon(Icons.location_city),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Text(sehir),
//                   ],
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? yeniValue) {
//               if (yeniValue != null) {
//                 viewModel.sehirNereden = yeniValue;
//               }
//             },
//           ),
//         ),
//       ),
//     ],
//   );
// }




// ------------
// BİLET NEREYE 
// ------------
// Widget _buildBiletNereye(BuildContext context) {
//   AnasayfaVM viewModel = Provider.of<AnasayfaVM>(context, listen: false);
//   return Row(
//     children: [
//       const Expanded(
//           flex: 2,
//           child: Text(
//             "Nereye : ",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           )),
//       Expanded(
//         flex: 4,
//         child: SizedBox(
//           height: 60,
//           child: DropdownButtonFormField<String>(
//             menuMaxHeight: 200,
//             value: viewModel.sehirNereye,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(width: 3),
//               ),
//             ),
//             borderRadius: BorderRadius.circular(4),
//             items: viewModel.sehirler.map((sehir) {
//               return DropdownMenuItem(
//                 value: sehir,
//                 child: Row(
//                   children: [
//                     const Icon(Icons.location_city),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Text(sehir),
//                   ],
//                 ),
//               );
//             }).toList(),
//             onChanged: (String? yeniValue) {
//               if (yeniValue != null) {
//                 viewModel.sehirNereye = yeniValue;
//               }
//             },
//           ),
//         ),
//       ),
//     ],
//   );
// }




// ---------------------
// BUILD BİLET NE ZAMAN
// ---------------------
// Widget _buildBiletNeZaman(BuildContext context) {
//   var viewModel = Provider.of<AnasayfaVM>(context, listen: false);
//   return Row(
//     children: [
//       const Expanded(
//           flex: 1,
//           child: Text(
//             "Ne Zaman : ",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           )),
//       Expanded(
//         flex: 2,
//         child: OutlinedButton(
//           onPressed: () async {
//             await _buildDateTimePicker(context);
//           },
//           style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.black,
//               padding: const EdgeInsets.all(10),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               )),
//           child: Row(
//             children: [
//               const Icon(Icons.calendar_month),
//               const SizedBox(
//                 width: 15,
//               ),
//               Consumer<AnasayfaVM>(
//                 builder:
//                     (BuildContext context, AnasayfaVM value, Widget? child) {
//                   return Text(
//                     viewModel.date,
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }













