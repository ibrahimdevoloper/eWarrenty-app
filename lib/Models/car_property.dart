/// id : 1
/// name_ar : "عام"
/// name_en : "Public"
/// created_at : "2021-01-03T12:08:57.000000Z"
/// updated_at : "2021-01-03T12:08:57.000000Z"

class CarProperty {
  int _id;
  String _nameAr;
  String _nameEn;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  CarProperty({
      int id, 
      String nameAr, 
      String nameEn, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CarProperty.fromJson(dynamic json) {
    _id = json["id"];
    _nameAr = json["name_ar"];
    _nameEn = json["name_en"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name_ar"] = _nameAr;
    map["name_en"] = _nameEn;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}