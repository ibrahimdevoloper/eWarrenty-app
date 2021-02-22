import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;

part 'SendWarrantyService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/Warranty')
abstract class SendWarrantyService extends ChopperService {
  @Post(
    headers: {
      "Authorization": "Basic YWRtaW46YWRtaW4=",
    },
  )
  @multipart
  Future<Response> sendWarrenty({
    // @Part() Map<String, dynamic> body,
    @Part('battery_serial_number') String battery_serial_number,
    @Part('bought_date') String bought_date,
    @Part('car_number') String car_number,
    @Part('battery_model_id') int battery_model_id,
    @Part('car_property_id') int car_property_id,
    @Part('car_type_id') int car_type_id,
    @Part('market_id') int market_id,
    @Part('customer_name') String customer_name,
    @Part('customer_email') String customer_email,
    @Part('customer_country') String customer_country,
    @Part('customer_address') String customer_address,
    @Part('customer_phone_number') String customer_phone_number,
    @Part('notes') String notes,
    @PartFile('car_number_image') String car_number_image,
    @PartFile('battery_front_image') String battery_front_image,
    @PartFile('fixed_battery_image') String fixed_battery_image,
  });

  static SendWarrantyService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      services: [
        // The generated implementation
        _$SendWarrantyService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$SendWarrantyService(client);
  }
}
