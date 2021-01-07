// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendWarrantyService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SendWarrantyService extends SendWarrantyService {
  _$SendWarrantyService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SendWarrantyService;

  Future<Response> getData(Map<String, dynamic> body) {
    final $url = '/Warranty';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
