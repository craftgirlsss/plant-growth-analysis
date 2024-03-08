class DetailTumbuhan {
  DetailTumbuhan({
    required this.status,
    required this.message,
    required this.perkembangan,
  });
  late final bool status;
  late final String message;
  late final List<Perkembangan> perkembangan;
  
  DetailTumbuhan.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    perkembangan = List.from(json['perkembangan']).map((e)=>Perkembangan.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['perkembangan'] = perkembangan.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Perkembangan {
  Perkembangan({
     this.id,
     this.idTumbuhan,
     this.diameter,
     this.tinggi,
     this.urutan,
     this.deskripsi,
     this.imgUrl,
     this.dateTime
  });
   String? id;
   String? idTumbuhan;
   String? diameter;
   String? tinggi;
   String? urutan;
   String? deskripsi;
   String? imgUrl;
   String? dateTime;
  
  Perkembangan.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idTumbuhan = json['id_tumbuhan'];
    diameter = json['diameter'];
    tinggi = json['tinggi'];
    urutan = json['urutan'];
    deskripsi = json['deskripsi'];
    imgUrl = json['img_url'];
    dateTime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['id_tumbuhan'] = idTumbuhan;
    _data['diameter'] = diameter;
    _data['tinggi'] = tinggi;
    _data['urutan'] = urutan;
    _data['deskripsi'] = deskripsi;
    _data['img_url'] = imgUrl;
    return _data;
  }
}