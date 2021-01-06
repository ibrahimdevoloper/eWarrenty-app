/// id : 1
/// name_ar : "BMW"
/// name_en : "BMW"
/// image : null
/// created_at : "2021-01-03T12:08:57.000000Z"
/// updated_at : "2021-01-03T12:08:57.000000Z"

class CarType {
  int _id;
  String _nameAr;
  String _nameEn;
  dynamic _image;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  dynamic get image => _image;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  CarType({
      int id, 
      String nameAr, 
      String nameEn, 
      dynamic image, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CarType.fromJson(dynamic json) {
    _id = json["id"];
    _nameAr = json["name_ar"];
    _nameEn = json["name_en"];
    _image = json["image"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name_ar"] = _nameAr;
    map["name_en"] = _nameEn;
    map["image"] = _image;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}