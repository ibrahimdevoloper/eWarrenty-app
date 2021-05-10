// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendMarketService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SendMarketService extends SendMarketService {
  _$SendMarketService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SendMarketService;

  @override
  Future<Response<dynamic>> sendMarket({dynamic body}) {
    final $url = '/market';
    final $headers = {
      'Authorization': 'Basic YWRtaW46YWRtaW4=',
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
