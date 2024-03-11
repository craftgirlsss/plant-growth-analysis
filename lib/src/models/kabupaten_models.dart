class KabupatenModels {
  KabupatenModels({
    required this.rajaongkir,
  });
  late final Rajaongkir rajaongkir;
  
  KabupatenModels.fromJson(Map<String, dynamic> json){
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
    required this.province,
  });
  late final String province;
  
  Query.fromJson(Map<String, dynamic> json){
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['province'] = province;
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
   this.cityId,
   this.provinceId,
   this.province,
   this.type,
   this.cityName,
   this.postalCode,
  });
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;
  
  Results.fromJson(Map<String, dynamic> json){
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['city_id'] = cityId;
    _data['province_id'] = provinceId;
    _data['province'] = province;
    _data['type'] = type;
    _data['city_name'] = cityName;
    _data['postal_code'] = postalCode;
    return _data;
  }
}