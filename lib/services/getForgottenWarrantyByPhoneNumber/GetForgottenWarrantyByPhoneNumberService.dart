import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;

part 'GetForgottenWarrantyByPhoneNumberService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/getForgottenwarrantybyPhone')
abstract class GetForgottenWarrantyByPhoneNumberService extends ChopperService {
  @Get(
    headers: {
      "Authorization": "Basic YWRtaW46YWRtaW4=",
    },
    path: "/{phoneNumber}",
  )
  // Future<Response> getWarrenty(@QueryMap() Map<String, dynamic> body);
  Future<Response> getWarrenties(@Path('phoneNumber') phoneNumber);

  static GetForgottenWarrantyByPhoneNumberService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      services: [
        // The generated implementation
        _$GetForgottenWarrantyByPhoneNumberService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$GetForgottenWarrantyByPhoneNumberService(client);
  }
}
