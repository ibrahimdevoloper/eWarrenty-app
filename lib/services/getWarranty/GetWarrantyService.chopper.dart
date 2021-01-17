// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetWarrantyService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GetWarrantyService extends GetWarrantyService {
  _$GetWarrantyService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GetWarrantyService;

  @override
  Future<Response<dynamic>> getWarrenty(Map<String, dynamic> body) {
    final $url = '/getWarrenty';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
