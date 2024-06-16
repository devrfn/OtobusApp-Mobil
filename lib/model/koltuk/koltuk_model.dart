class KoltukModel {
  int? koltukNo;
  bool? cinsiyet;

  KoltukModel({this.koltukNo, this.cinsiyet});

  KoltukModel.fromJson(Map<String, dynamic> json) {
    koltukNo = json['koltukNo'];
    cinsiyet = json['cinsiyet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['koltukNo'] = this.koltukNo;
    data['cinsiyet'] = this.cinsiyet;
    return data;
  }
}
