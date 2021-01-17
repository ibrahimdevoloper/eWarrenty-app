// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendWarrantyService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SendWarrantyService extends SendWarrantyService {
  _$SendWarrantyService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SendWarrantyService;

  @override
  Future<Response<dynamic>> SendWarrenty(
      Map<String, dynamic> body,
      String car_number_image,
      String battery_front_image,
      String fixed_battery_image) {
    final $url = '/Warranty';
    final $body = body;
    final $parts = <PartValue>[
      PartValueFile<String>('car_number_image', car_number_image),
      PartValueFile<String>('battery_front_image', battery_front_image),
      PartValueFile<String>('fixed_battery_image', fixed_battery_image)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        body: $body, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
