import 'dart:convert';

class User {
  static const genders = ['pria', 'wanita'];
  static const jenjangs = ['tk', 'sd', 'smp', 'sma'];

  int id;
  String fullName;
  String gender;
  String jenjang;
  String phone;

  User({this.id, this.fullName, this.gender, this.jenjang, this.phone});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map["id"],
        fullName: map["fullname"],
        gender: map["gender"],
        jenjang: map["jenjang"],
        phone: map["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullName,
      "gender": gender,
      "jenjang": jenjang,
      "phone": phone
    };
  }

  @override
  String toString() {
    return 'User{id: $id, fullname: $fullName, gender: $gender, jenjang: $jenjang, phone: $phone}';
  }
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
