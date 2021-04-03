// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendCarService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SendCarService extends SendCarService {
  _$SendCarService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SendCarService;

  @override
  Future<Response<dynamic>> sendCar({String nameAr, String nameEn}) {
    final $url = '/cartype';
    final $headers = {'Authorization': 'Basic YWRtaW46YWRtaW4='};
    final $request = Request('POST', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
