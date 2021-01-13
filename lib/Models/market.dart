// "id": 10,
// "name_en": "Nemo aut aut illo error.",
// "name_ar": "Dolorum quasi minus eos.",
// "email": "wstamm@volkman.com",
// "phone_number": "(826) 530-9531 x7814",
// "country": "Trinidad and Tobago",
// "address_en": "54575 Sanford Gateway Apt. 936\nLake Juanastad, NM 83887-2976",
// "address_ar": "662 Margarett Grove Apt. 695\nRansomport, CT 67731",
// "username": "thelma21",
// "created_at": "2021-01-09T10:31:42.000000Z",
// "updated_at": "2021-01-09T10:31:42.000000Z"
class Market {
  int _id;
  String _nameEn;
  String _nameAr;
  String _email;
  String _phoneNumber;
  String _country;
  String _addressEn;
  String _addressAr;
  String _username;
  String _createdAt;
  String _updatedAt;

  int get id => _id;

  String get nameEn => _nameEn;

  String get nameAr => _nameAr;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  String get country => _country;

  String get addressEn => _addressEn;

  String get addressAr => _addressAr;

  String get username => _username;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  Market(
      {int id,
      String nameEn,
      String nameAr,
      String email,
      String phoneNumber,
      String country,
      String addressEn,
      String addressAr,
      String username,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _nameEn = nameEn;
    _nameAr = nameAr;
    _email = email;
    _phoneNumber = phoneNumber;
    _country = country;
    _addressEn = addressEn;
    _addressAr = addressAr;
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
    _addressEn = json["address_en"];
    _addressAr = json["address_ar"];
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
    map["address_en"] = _addressEn;
    map["address_ar"] = _addressAr;
    map["username"] = _username;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
