class Battery {
  int _id;
  int _capacity;
  int _ccaAmpere;
  dynamic _weight;
  String _number;
  String _infoAr;
  String _infoEn;
  String _dimensions;
  String _description;
  String _image;
  String _frontImage;
  String _serialNumberImage;
  String _createdAt;
  String _updatedAt;
  String _terminal;
  String _manufacturingCountryAr;
  String _manufacturingCountryEn;

  int get id => _id;
  int get capacity => _capacity;
  int get ccaAmpere => _ccaAmpere;
  dynamic get weight => _weight;
  String get number => _number;
  String get infoEn => _infoEn;
  String get infoAr => _infoAr;
  String get dimensions => _dimensions;
  String get description => _description;
  String get image => _image;
  String get frontImage => _frontImage;
  String get serialNumberImage => _serialNumberImage;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get terminal => _terminal;
  String get manufacturingCountryAr => _manufacturingCountryAr;
  String get manufacturingCountryEn => _manufacturingCountryEn;

  Battery(
      {int id,
      int capacity,
      int ccaAmpere,
      dynamic weight,
      String number,
      String infoEn,
      String infoAr,
      String dimensions,
      String description,
      String image,
      String frontImage,
      String serialNumberImage,
      String createdAt,
      String updatedAt,
      String terminal,
      String manufacturingCountryAr,
      String manufacturingCountryEn}) {
    _id = id;
    _capacity = capacity;
    _ccaAmpere = ccaAmpere;
    _weight = weight;
    _number = number;
    _infoEn = infoEn;
    _infoAr = infoAr;
    _dimensions = dimensions;
    _description = description;
    _image = image;
    _frontImage = frontImage;
    _serialNumberImage = serialNumberImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _terminal = terminal;
    _manufacturingCountryAr = manufacturingCountryAr;
    _manufacturingCountryEn = manufacturingCountryEn;
  }

  Battery.fromJson(dynamic json) {
    _id = json["id"];
    _capacity = json["capacity"];
    _ccaAmpere = json["cca_ampere"];
    _weight = json["weight"];
    _number = json["number"];
    _infoEn = json["info_en"];
    _infoAr = json["info_ar"];
    _dimensions = json["dimensions"];
    _description = json["description"];
    _image = json["image"];
    _frontImage = json["front_image"];
    _serialNumberImage = json["serial_number_image"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _terminal = json["terminal"];
    _manufacturingCountryAr = json["manufacturing_country_ar"];
    _manufacturingCountryEn = json["manufacturing_country_en"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["capacity"] = _capacity;
    map["cca_ampere"] = _ccaAmpere;
    map["weight"] = _weight;
    map["number"] = _number;
    map["info_en"] = _infoEn;
    map["info_ar"] = _infoAr;
    map["dimensions"] = _dimensions;
    map["description"] = _description;
    map["image"] = _image;
    map["front_image"] = _frontImage;
    map["serial_number_image"] = _serialNumberImage;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["terminal"] = _terminal;
    map["manufacturing_country_ar"] = _manufacturingCountryAr;
    map["manufacturing_country_en"] = _manufacturingCountryEn;
    return map;
  }
}
