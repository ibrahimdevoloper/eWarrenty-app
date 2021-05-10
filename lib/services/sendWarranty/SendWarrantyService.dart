import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;
import 'package:http/io_client.dart' as http;

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
    @Part('battery_serial_number') battery_serial_number,
    @Part('bought_date') bought_date,
    @Part('car_number') car_number,
    @Part('battery_model_id') battery_model_id,
    @Part('car_property_id') car_property_id,
    @Part('car_type_id') car_type_id,
    @Part('market_id') market_id,
    @Part('customer_name') customer_name,
    @Part('customer_email') customer_email,
    @Part('customer_country') customer_country,
    @Part('customer_address') customer_address,
    @Part('customer_phone_number') customer_phone_number,
    @Part('notes') notes,
    @PartFile('car_number_image') car_number_image,
    @PartFile('battery_front_image') battery_front_image,
    @PartFile('fixed_battery_image') fixed_battery_image,
    @PartFile('bill_image') bill_image,
  });

  static SendWarrantyService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
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
