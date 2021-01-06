/// id : 1
/// name_en : "Et eum natus sit qui."
/// name_ar : "Sit voluptas qui vel."
/// email : "jwolf@hotmail.com"
/// phone_number : "(981) 636-0590"
/// country : "Sao Tome and Principe"
/// address : "3160 Marilie Fields\nEast Ulices, KS 06140-2077"
/// username : "braeden45"
/// created_at : "2021-01-03T12:08:58.000000Z"
/// updated_at : "2021-01-03T12:08:58.000000Z"

class Market {
  int _id;
  String _nameEn;
  String _nameAr;
  String _email;
  String _phoneNumber;
  String _country;
  String _address;
  String _username;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get nameEn => _nameEn;
  String get nameAr => _nameAr;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get country => _country;
  String get address => _address;
  String get username => _username;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Market({
      int id, 
      String nameEn, 
      String nameAr, 
      String email, 
      String phoneNumber, 
      String country, 
      String address, 
      String username, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _nameEn = nameEn;
    _nameAr = nameAr;
    _email = email;
    _phoneNumber = phoneNumber;
    _country = country;
    _address = address;
    _username = username;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Market.fromJson(dynamic json) {
    _id = json["id"];
    _nameEn = json["name_en"];
    _nameAr = json["name_ar"];
    _email = json["email"];
    _phoneNumber = json["phone_number"];
    _country = json["country"];
    _address = json["address"];
    _username = json["username"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name_en"] = _nameEn;
    map["name_ar"] = _nameAr;
    map["email"] = _email;
    map["phone_number"] = _phoneNumber;
    map["country"] = _country;
    map["address"] = _address;
    map["username"] = _username;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}