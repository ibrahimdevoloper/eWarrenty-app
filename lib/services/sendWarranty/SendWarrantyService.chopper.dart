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
  Future<Response<dynamic>> sendWarrenty(
      {dynamic battery_serial_number,
      dynamic bought_date,
      dynamic car_number,
      dynamic battery_model_id,
      dynamic car_property_id,
      dynamic car_type_id,
      dynamic market_id,
      dynamic customer_name,
      dynamic customer_email,
      dynamic customer_country,
      dynamic customer_address,
      dynamic customer_phone_number,
      dynamic notes,
      dynamic car_number_image,
      dynamic battery_front_image,
      dynamic fixed_battery_image,
      dynamic bill_image}) {
    final $url = '/Warranty';
    final $headers = {
      'Authorization': 'Basic YWRtaW46YWRtaW4=',
    };

    final $parts = <PartValue>[
      PartValue<dynamic>('battery_serial_number', battery_serial_number),
      PartValue<dynamic>('bought_date', bought_date),
      PartValue<dynamic>('car_number', car_number),
      PartValue<dynamic>('battery_model_id', battery_model_id),
      PartValue<dynamic>('car_property_id', car_property_id),
      PartValue<dynamic>('car_type_id', car_type_id),
      PartValue<dynamic>('market_id', market_id),
      PartValue<dynamic>('customer_name', customer_name),
      PartValue<dynamic>('customer_email', customer_email),
      PartValue<dynamic>('customer_country', customer_country),
      PartValue<dynamic>('customer_address', customer_address),
      PartValue<dynamic>('customer_phone_number', customer_phone_number),
      PartValue<dynamic>('notes', notes),
      PartValueFile<dynamic>('car_number_image', car_number_image),
      PartValueFile<dynamic>('battery_front_image', battery_front_image),
      PartValueFile<dynamic>('fixed_battery_image', fixed_battery_image),
      PartValueFile<dynamic>('bill_image', bill_image)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
