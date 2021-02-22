// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetForgottenWarrantyByPhoneNumberService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GetForgottenWarrantyByPhoneNumberService
    extends GetForgottenWarrantyByPhoneNumberService {
  _$GetForgottenWarrantyByPhoneNumberService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GetForgottenWarrantyByPhoneNumberService;

  @override
  Future<Response<dynamic>> getWarrenties(String phoneNumber) {
    final $url = '/getForgottenwarrantybyPhone/$phoneNumber';
    final $headers = {'Authorization': 'Basic YWRtaW46YWRtaW4='};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
