
import 'package:otobus_app/model/koltuk/koltuk_model.dart';

class SeferExtraModel {
  int? seferId;
  double? seferFiyati;
  String? seferTarihi;
  String? kalkisYeri;
  String? varisYeri;
  bool? seferTamamlandiMi;
  List<KoltukModel>? koltuk;

  SeferExtraModel(
      {this.seferId,
      this.seferFiyati,
      this.seferTarihi,
      this.kalkisYeri,
      this.varisYeri,
      this.seferTamamlandiMi,
      this.koltuk});

  SeferExtraModel.fromJson(Map<String, dynamic> json) {
    seferId = json['seferId'];
    seferFiyati = json['seferFiyati'];
    seferTarihi = json['seferTarihi'];
    kalkisYeri = json['kalkisYeri'];
    varisYeri = json['varisYeri'];
    seferTamamlandiMi = json['seferTamamlandiMi'];
    if (json['koltuk'] != null) {
      koltuk = <KoltukModel>[];
      json['koltuk'].forEach((v) {
        koltuk!.add(new KoltukModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seferId'] = this.seferId;
    data['seferFiyati'] = this.seferFiyati;
    data['seferTarihi'] = this.seferTarihi;
    data['kalkisYeri'] = this.kalkisYeri;
    data['varisYeri'] = this.varisYeri;
    data['seferTamamlandiMi'] = this.seferTamamlandiMi;
    if (this.koltuk != null) {
      data['koltuk'] = this.koltuk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

