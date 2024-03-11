class ProvinsiModels {
  ProvinsiModels({
    required this.rajaongkir,
  });
  late final Rajaongkir rajaongkir;
  
  ProvinsiModels.fromJson(Map<String, dynamic> json){
    rajaongkir = Rajaongkir.fromJson(json['rajaongkir']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rajaongkir'] = rajaongkir.toJson();
    return _data;
  }
}

class Rajaongkir {
  Rajaongkir({
    required this.query,
    required this.status,
    required this.results,
  });
  late final List<dynamic> query;
  late final Status status;
  late final List<Results> results;
  
  Rajaongkir.fromJson(Map<String, dynamic> json){
    query = List.castFrom<dynamic, dynamic>(json['query']);
    status = Status.fromJson(json['status']);
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['query'] = query;
    _data['status'] = status.toJson();
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Status {
  Status({
    this.code,
    this.description,
  });
  int? code;
  String? description;
  
  Status.fromJson(Map<String, dynamic> json){
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['description'] = description;
    return _data;
  }
}

class Results {
  Results({
    required this.provinceId,
    required this.province,
  });
  late final String provinceId;
  late final String province;
  
  Results.fromJson(Map<String, dynamic> json){
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['province_id'] = provinceId;
    _data['province'] = province;
    return _data;
  }
}