// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InitDataService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$InitDataService extends InitDataService {
  _$InitDataService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = InitDataService;

  Future<Response> getData() {
    final $url = '/initData';
    final $request = Request('GET', $url, client.baseUrl);
    print($request.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
