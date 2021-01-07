import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart'as constant;

part 'SendWarrantyService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/Warranty')
abstract class SendWarrantyService extends ChopperService {
  @Post()
  Future<Response> getData(
      @body Map<String,dynamic> body
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