// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InitDataService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$InitDataService extends InitDataService {
  _$InitDataService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = InitDataService;

  @override
  Future<Response<dynamic>> getData() {
    final $url = '/initData';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
