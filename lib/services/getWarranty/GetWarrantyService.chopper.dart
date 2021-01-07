// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetWarrantyService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$GetWarrantyService extends GetWarrantyService {
  _$GetWarrantyService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = GetWarrantyService;

  Future<Response> getWarrenty(Map<String, dynamic> body) {
    final $url = '/getWarrenty';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
