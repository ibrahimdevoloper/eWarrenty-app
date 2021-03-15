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
      {String battery_serial_number,
      String bought_date,
      String car_number,
      int battery_model_id,
      int car_property_id,
      int car_type_id,
      int market_id,
      String customer_name,
      String customer_email,
      String customer_country,
      String customer_address,
      String customer_phone_number,
      String notes,
      String car_number_image,
      String battery_front_image,
      String fixed_battery_image,
      String bill_image}) {
    final $url = '/Warranty';
    final $headers = {'Authorization': 'Basic YWRtaW46YWRtaW4='};
    final $parts = <PartValue>[
      PartValue<String>('battery_serial_number', battery_serial_number),
      PartValue<String>('bought_date', bought_date),
      PartValue<String>('car_number', car_number),
      PartValue<int>('battery_model_id', battery_model_id),
      PartValue<int>('car_property_id', car_property_id),
      PartValue<int>('car_type_id', car_type_id),
      PartValue<int>('market_id', market_id),
      PartValue<String>('customer_name', customer_name),
      PartValue<String>('customer_email', customer_email),
      PartValue<String>('customer_country', customer_country),
      PartValue<String>('customer_address', customer_address),
      PartValue<String>('customer_phone_number', customer_phone_number),
      PartValue<String>('notes', notes),
      PartValueFile<String>('car_number_image', car_number_image),
      PartValueFile<String>('battery_front_image', battery_front_image),
      PartValueFile<String>('fixed_battery_image', fixed_battery_image),
      PartValueFile<String>('bill_image', bill_image)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
