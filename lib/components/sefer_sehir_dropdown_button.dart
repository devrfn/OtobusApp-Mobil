import 'package:flutter/material.dart';
import 'package:otobus_app/tools/constants/cities.dart';

class SeferSehirDropDownButton extends StatelessWidget {

  String? labelText;
  String? dropdownValue;
  void Function(String?) onChangedCallback;
  double? menuMaxHeight;

  SeferSehirDropDownButton({this.labelText, this.dropdownValue, required this.onChangedCallback, this.menuMaxHeight});

  @override
  Widget build(BuildContext context, ) {

    return Container(
      margin: const EdgeInsets.only(bottom:8, right: 10, left: 10, top: 10),
      child: DropdownButtonFormField<String>(
        // value
        value: dropdownValue,
        // max-height
        menuMaxHeight: 300,
        items: Cities.sehirler.map((sehir) {
          return DropdownMenuItem<String>(
            value: sehir,
            child: Row(
              children: [
                const Icon(Icons.location_city_outlined),
                const SizedBox(width: 10),
                Text(sehir, style: const TextStyle(fontSize: 20,),),
              ],
            ),
          );
        }).toList(),
        
        // onCHanged
        onChanged: (String? value){
          onChangedCallback(value);
        },

        iconSize: 22,


        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          labelText: labelText,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder:const  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
