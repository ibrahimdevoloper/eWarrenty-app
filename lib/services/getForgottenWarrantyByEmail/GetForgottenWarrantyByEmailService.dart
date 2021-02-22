import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart' as constant;

part 'GetForgottenWarrantyByEmailService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/getForgottenwarrantybyEmail')
abstract class GetForgottenWarrantyByEmailService extends ChopperService {
  @Get(
    headers: {
      "Authorization": "Basic YWRtaW46YWRtaW4=",
    },
    path: "/{email}",
  )
  // Future<Response> getWarrenty(@QueryMap() Map<String, dynamic> body);
  Future<Response> getWarrenties(@Path('email') String email);

  static GetForgottenWarrantyByEmailService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      services: [
        // The generated implementation
        _$GetForgottenWarrantyByEmailService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$GetForgottenWarrantyByEmailService(client);
  }
}
