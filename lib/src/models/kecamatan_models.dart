class KecamatanModels {
  KecamatanModels({
    required this.rajaongkir,
  });
  late final Rajaongkir rajaongkir;
  
  KecamatanModels.fromJson(Map<String, dynamic> json){
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
  late final Query query;
  late final Status status;
  late final List<Results> results;
  
  Rajaongkir.fromJson(Map<String, dynamic> json){
    query = Query.fromJson(json['query']);
    status = Status.fromJson(json['status']);
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['query'] = query.toJson();
    _data['status'] = status.toJson();
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Query {
  Query({
    required this.city,
  });
  late final String city;
  
  Query.fromJson(Map<String, dynamic> json){
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['city'] = city;
    return _data;
  }
}

class Status {
  Status({
    required this.code,
    required this.description,
  });
  late final int code;
  late final String description;
  
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
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });
  String? subdistrictId;
  String? provinceId;
  String? province;
  String? cityId;
  String? city;
  String? type;
  String? subdistrictName;
  
  Results.fromJson(Map<String, dynamic> json){
    subdistrictId = json['subdistrict_id'];
    provinceId = json['province_id'];
    province = json['province'];
    cityId = json['city_id'];
    city = json['city'];
    type = json['type'];
    subdistrictName = json['subdistrict_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subdistrict_id'] = subdistrictId;
    _data['province_id'] = provinceId;
    _data['province'] = province;
    _data['city_id'] = cityId;
    _data['city'] = city;
    _data['type'] = type;
    _data['subdistrict_name'] = subdistrictName;
    return _data;
  }
}