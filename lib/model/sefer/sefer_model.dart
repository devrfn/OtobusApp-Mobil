
class SeferModel {
  int? seferId;
  int? soforId;
  int? otobuId;
  String? soforName;
  String? soforSurname;
  String? soforTelefonNumarasi;
  String? otobusPlaka;
  double? seferFiyati;
  String? seferTarihi;
  String? kalkisYeri;
  String? varisYeri;
  bool? seferTamamlandiMi;

  SeferModel(
      {this.seferId,
      this.soforId,
      this.otobuId,
      this.soforName,
      this.soforSurname,
      this.soforTelefonNumarasi,
      this.otobusPlaka,
      this.seferFiyati,
      this.seferTarihi,
      this.kalkisYeri,
      this.varisYeri,
      this.seferTamamlandiMi});

  SeferModel.fromJson(Map<String, dynamic> json) {
    seferId = json['seferId'];
    soforId = json['soforId'];
    otobuId = json['otobuId'];
    soforName = json['soforName'];
    soforSurname = json['soforSurname'];
    soforTelefonNumarasi = json['soforTelefonNumarasi'];
    otobusPlaka = json['otobusPlaka'];
    seferFiyati = json['seferFiyati'];
    seferTarihi = json['seferTarihi'];
    kalkisYeri = json['kalkisYeri'];
    varisYeri = json['varisYeri'];
    seferTamamlandiMi = json['seferTamamlandiMi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seferId'] = this.seferId;
    data['soforId'] = this.soforId;
    data['otobuId'] = this.otobuId;
    data['soforName'] = this.soforName;
    data['soforSurname'] = this.soforSurname;
    data['soforTelefonNumarasi'] = this.soforTelefonNumarasi;
    data['otobusPlaka'] = this.otobusPlaka;
    data['seferFiyati'] = this.seferFiyati;
    data['seferTarihi'] = this.seferTarihi;
    data['kalkisYeri'] = this.kalkisYeri;
    data['varisYeri'] = this.varisYeri;
    data['seferTamamlandiMi'] = this.seferTamamlandiMi;
    return data;
  }
}
