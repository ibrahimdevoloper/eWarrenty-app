import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;

part 'SendWarrantyService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/Warranty')
abstract class SendWarrantyService extends ChopperService {
  @Post()
  @Multipart()
  Future<Response> SendWarrenty(
    @Body() Map<String, dynamic> body,
    // @Body() String battery_serial_number,
    // @Body() String bought_date,
    // @Body() String car_number,
    // @Body() int battery_model_id,
    // @Body() int car_property_id,
    // @body int car_type_id,
    // @body int market_id,
    // @body String customer_name,
    // @body String customer_email,
    // @body String customer_country,
    // @body String customer_phone_number,
    // @body String notes,
    @PartFile() String car_number_image,
    @PartFile() String battery_front_image,
    @PartFile() String fixed_battery_image,
  );

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
