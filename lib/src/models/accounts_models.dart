class AccountModels {
  AccountModels({
    required this.message,
    required this.status,
    required this.result,
  });
  late final String message;
  late final bool status;
  late final Result result;
  
  AccountModels.fromJson(Map<String, dynamic> json){
    message = json['message'];
    status = json['status'];
    result = Result.fromJson(json['result']);
  }
}

class Result {
  Result({
    this.id,
    this.name,
    this.email,
    this.username,
    this.password,
    this.isActive,
  });
    String? id;
    String? name;
    String? email;
    String? username;
    String? password;
    String? isActive;
  
  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    password = json['password'] ?? '';
    isActive = json['is_active'] ?? '';
  }
}