// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetForgottenWarrantyByEmailService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GetForgottenWarrantyByEmailService
    extends GetForgottenWarrantyByEmailService {
  _$GetForgottenWarrantyByEmailService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GetForgottenWarrantyByEmailService;

  @override
  Future<Response<dynamic>> getWarrenties(String email) {
    final $url = '/getForgottenwarrantybyEmail/$email';
    final $headers = {'Authorization': 'Basic YWRtaW46YWRtaW4='};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
