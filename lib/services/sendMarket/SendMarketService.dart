import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;
import 'package:http/io_client.dart' as http;

part 'SendMarketService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/market')
abstract class SendMarketService extends ChopperService {
  @Post(
    headers: {
      "Authorization": "Basic YWRtaW46YWRtaW4=",
    },
  )
  Future<Response> sendMarket({
    // @Part('name_ar') String nameAr,
    // @Part('name_en') String nameEn,
    // @Part('email') String email,
    // @Part('phone_number') String phoneNumber,
    // @Part('country') String country,
    // @Part('address_ar') String addressAr,
    // @Part('address_en') String addressEn,
    @Body() body,
  });

  static SendMarketService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
      services: [
        // The generated implementation
        _$SendMarketService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$SendMarketService(client);
  }
}
