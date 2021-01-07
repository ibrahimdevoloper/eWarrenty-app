part of 'send_warranty_cubit.dart';

@immutable
abstract class SendWarrantyState {
  SendWarrantyState();
}

class SendWarrantyInitial extends SendWarrantyState {
  SendWarrantyInitial();
}

class SendWarrantyLoading extends SendWarrantyState {
  SendWarrantyLoading();
}

class SendWarrantyLoaded extends SendWarrantyState {
  final Warranty warranty;

  SendWarrantyLoaded(this.warranty);
}

class SendWarrantyError extends SendWarrantyState {
  SendWarrantyError();
}
