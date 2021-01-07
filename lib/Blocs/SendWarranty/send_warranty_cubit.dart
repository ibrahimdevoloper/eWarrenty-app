import 'package:bloc/bloc.dart';
import 'package:ewarrenty/Models/warranty.dart';
import 'package:meta/meta.dart';

part 'send_warranty_state.dart';

class SendWarrantyCubit extends Cubit<SendWarrantyState> {
  SendWarrantyCubit() : super(SendWarrantyInitial());
}
