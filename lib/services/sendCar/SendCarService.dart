import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;
import 'package:http/io_client.dart' as http;

part 'SendCarService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/cartype')
abstract class SendCarService extends ChopperService {
  @Post(
    headers: {
      "Authorization": "Basic YWRtaW46YWRtaW4=",
    },
  )
  Future<Response> sendCar({
    // @Part('name_ar') String nameAr,
    // @Part('name_en') String nameEn,
    @Body() body,
  });

  static SendCarService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
      services: [
        // The generated implementation
        _$SendCarService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$SendCarService(client);
  }
}
