import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart'as constant;

part 'GetWarrantyService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/getWarrenty')
abstract class GetWarrantyService extends ChopperService {
  @Get()
  Future<Response> getWarrenty(
      @body Map<String,dynamic> body
      );

  static GetWarrantyService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      services: [
        // The generated implementation
        _$GetWarrantyService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$GetWarrantyService(client);
  }
}