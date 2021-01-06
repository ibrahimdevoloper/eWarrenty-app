import 'battery.dart';
import 'car_type.dart';
import 'market.dart';
import 'car_property.dart';

/// id : 112
/// bought_date : "2020-01-05 00:00:00"
/// battery_serial_number : "sdvhdnb"
/// warranty_code : "PWL83IS"
/// car_number : "dfbdfb"
/// customer_phone_number : "6516161"
/// customer_address : "fgnfgn"
/// customer_country : "fgnfgn"
/// customer_email : "4tyj@email.com"
/// customer_name : "dgjdfj"
/// car_number_image : "/storage/images/carNumbers/5N1FDnWIw2CcFR7vauwYRubouOYoToDfNv5y8iEK.png"
/// battery_front_image : "/storage/images/batteryFronts/od4mxCSbo8msG0RKCNf35uaFjWaStKNWmRRiCG8m.png"
/// fixed_battery_image : "/storage/images/fixedBattery/5dBN3EsZgbisrRZCT7IHQ6Mp2TGYFBUfHC6n7E5E.png"
/// notes : "61fgn1"
/// created_at : "2021-01-06T16:06:18.000000Z"
/// updated_at : "2021-01-06T16:06:18.000000Z"
/// warranty_duration : 10
/// battery : {"id":1,"capacity":60,"cca_ampere":877,"weight":"44.700","number":"1IXVS","info":"Quis voluptatem aut consequatur in ut enim. Et dignissimos et est aperiam sit quam.","dimensions":"6*850","description":"Voluptatum modi occaecati autem unde impedit aut.","image":"/storage/images/batteries/2.png","front_image":"/storage/images/batteries/2.png","serial_number_image":"/storage/images/batteries/2.png","terminal_id":2,"manufacturing_country_id":2,"created_at":"2021-01-06T15:51:54.000000Z","updated_at":"2021-01-06T15:51:54.000000Z"}
/// car_type : {"id":1,"name_ar":"فيراري","name_en":"Ferrari","image":null,"created_at":"2021-01-06T15:51:54.000000Z","updated_at":"2021-01-06T15:51:54.000000Z"}
/// market : {"id":1,"name_en":"Sed expedita qui et eum.","name_ar":"Fuga est vero et.","email":"frida.kessler@schmitt.com","phone_number":"993.663.3476","country":"Brazil","address":"9149 Christelle Forks Suite 394\nSouth Jacey, UT 08645-2433","username":"joshua.sporer","created_at":"2021-01-06T15:51:54.000000Z","updated_at":"2021-01-06T15:51:54.000000Z"}
/// car_property : {"id":1,"name_ar":"عام","name_en":"Private","created_at":"2021-01-06T15:51:54.000000Z","updated_at":"2021-01-06T15:51:54.000000Z"}

class Warranty {
  int _id;
  String _boughtDate;
  String _batterySerialNumber;
  String _warrantyCode;
  String _carNumber;
  String _customerPhoneNumber;
  String _customerAddress;
  String _customerCountry;
  String _customerEmail;
  String _customerName;
  String _carNumberImage;
  String _batteryFrontImage;
  String _fixedBatteryImage;
  String _notes;
  String _createdAt;
  String _updatedAt;
  int _warrantyDuration;
  Battery _battery;
  CarType _carType;
  Market _market;
  CarProperty _carProperty;

  int get id => _id;
  String get boughtDate => _boughtDate;
  String get batterySerialNumber => _batterySerialNumber;
  String get warrantyCode => _warrantyCode;
  String get carNumber => _carNumber;
  String get customerPhoneNumber => _customerPhoneNumber;
  String get customerAddress => _customerAddress;
  String get customerCountry => _customerCountry;
  String get customerEmail => _customerEmail;
  String get customerName => _customerName;
  String get carNumberImage => _carNumberImage;
  String get batteryFrontImage => _batteryFrontImage;
  String get fixedBatteryImage => _fixedBatteryImage;
  String get notes => _notes;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get warrantyDuration => _warrantyDuration;
  Battery get battery => _battery;
  CarType get carType => _carType;
  Market get market => _market;
  CarProperty get carProperty => _carProperty;

  Warranty({
      int id, 
      String boughtDate, 
      String batterySerialNumber, 
      String warrantyCode, 
      String carNumber, 
      String customerPhoneNumber, 
      String customerAddress, 
      String customerCountry, 
      String customerEmail, 
      String customerName, 
      String carNumberImage, 
      String batteryFrontImage, 
      String fixedBatteryImage, 
      String notes, 
      String createdAt, 
      String updatedAt, 
      int warrantyDuration, 
      Battery battery, 
      CarType carType,
      Market market, 
      CarProperty carProperty}){
    _id = id;
    _boughtDate = boughtDate;
    _batterySerialNumber = batterySerialNumber;
    _warrantyCode = warrantyCode;
    _carNumber = carNumber;
    _customerPhoneNumber = customerPhoneNumber;
    _customerAddress = customerAddress;
    _customerCountry = customerCountry;
    _customerEmail = customerEmail;
    _customerName = customerName;
    _carNumberImage = carNumberImage;
    _batteryFrontImage = batteryFrontImage;
    _fixedBatteryImage = fixedBatteryImage;
    _notes = notes;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _warrantyDuration = warrantyDuration;
    _battery = battery;
    _carType = carType;
    _market = market;
    _carProperty = carProperty;
}

  Warranty.fromJson(dynamic json) {
    _id = json["id"];
    _boughtDate = json["bought_date"];
    _batterySerialNumber = json["battery_serial_number"];
    _warrantyCode = json["warranty_code"];
    _carNumber = json["car_number"];
    _customerPhoneNumber = json["customer_phone_number"];
    _customerAddress = json["customer_address"];
    _customerCountry = json["customer_country"];
    _customerEmail = json["customer_email"];
    _customerName = json["customer_name"];
    _carNumberImage = json["car_number_image"];
    _batteryFrontImage = json["battery_front_image"];
    _fixedBatteryImage = json["fixed_battery_image"];
    _notes = json["notes"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _warrantyDuration = json["warranty_duration"];
    _battery = json["battery"] != null ? Battery.fromJson(json["battery"]) : null;
    _carType = json["car_type"] != null ? CarType.fromJson(json["car_type"]) : null;
    _market = json["market"] != null ? Market.fromJson(json["market"]) : null;
    _carProperty = json["car_property"] != null ? CarProperty.fromJson(json["car_property"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["bought_date"] = _boughtDate;
    map["battery_serial_number"] = _batterySerialNumber;
    map["warranty_code"] = _warrantyCode;
    map["car_number"] = _carNumber;
    map["customer_phone_number"] = _customerPhoneNumber;
    map["customer_address"] = _customerAddress;
    map["customer_country"] = _customerCountry;
    map["customer_email"] = _customerEmail;
    map["customer_name"] = _customerName;
    map["car_number_image"] = _carNumberImage;
    map["battery_front_image"] = _batteryFrontImage;
    map["fixed_battery_image"] = _fixedBatteryImage;
    map["notes"] = _notes;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["warranty_duration"] = _warrantyDuration;
    if (_battery != null) {
      map["battery"] = _battery.toJson();
    }
    if (_carType != null) {
      map["car_type"] = _carType.toJson();
    }
    if (_market != null) {
      map["market"] = _market.toJson();
    }
    if (_carProperty != null) {
      map["car_property"] = _carProperty.toJson();
    }
    return map;
  }

}