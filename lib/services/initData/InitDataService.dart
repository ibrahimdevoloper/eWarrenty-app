import 'package:chopper/chopper.dart';
import 'package:ewarrenty/Constants/Constants.dart'as constant;

part 'InitDataService.chopper.dart';

// This baseUrl is now changed to specify only the endpoint '/posts'
@ChopperApi(baseUrl: '/initData')
abstract class InitDataService extends ChopperService {
  @Get()
  Future<Response> getData();

  static InitDataService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: constant.baseUrl,
      services: [
        // The generated implementation
        _$InitDataService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$InitDataService(client);
  }
}