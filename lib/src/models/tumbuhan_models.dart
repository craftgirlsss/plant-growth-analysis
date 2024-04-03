class TumbuhanModels {
  TumbuhanModels({
    required this.status,
    required this.message,
    required this.tumbuhan,
  });
  late final bool status;
  late final String message;
  late final List<Tumbuhan> tumbuhan;
  
  TumbuhanModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    tumbuhan = List.from(json['tumbuhan']).map((e)=>Tumbuhan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['tumbuhan'] = tumbuhan.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Tumbuhan {
  Tumbuhan({
    this.id,
    this.userId,
    this.deskripsi,
    this.nama,
    this.jenisKelaminTumbuhan,
    this.createDate,
    this.imgUrl,
  });
  String? id;
  String? userId;
  String? deskripsi;
  String? nama;
  String? jenisKelaminTumbuhan;
  String? createDate;
  String? imgUrl;
  String? provinsi;
  String? kabupaten;
  String? kecamatan;
  String? desa;
  
  Tumbuhan.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    deskripsi = json['deskripsi'] ?? '';
    nama = json['nama'];
    jenisKelaminTumbuhan = json['jenis_kelamin_tumbuhan'];
    createDate = json['create_date'];
    imgUrl = json['img_url'];
    provinsi = json['provinsi'];
    kabupaten = json['kabupaten'];
    kecamatan = json['kecamatan'];
    desa = json['desa'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['deskripsi'] = deskripsi;
    _data['nama'] = nama;
    _data['jenis_kelamin_tumbuhan'] = jenisKelaminTumbuhan;
    _data['create_date'] = createDate;
    _data['img_url'] = imgUrl;
    return _data;
  }
}