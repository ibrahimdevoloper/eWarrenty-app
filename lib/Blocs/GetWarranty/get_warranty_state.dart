part of 'get_warranty_cubit.dart';

@immutable
abstract class GetWarrantyState {
  GetWarrantyState();
}

class GetWarrantyInitial extends GetWarrantyState {
  GetWarrantyInitial();
}

class GetWarrantyLoading extends GetWarrantyState {
  GetWarrantyLoading();
}

class GetWarrantyLoaded extends GetWarrantyState {
  final Warranty warranty;

  GetWarrantyLoaded(this.warranty);
}

class GetWarrantyError extends GetWarrantyState {
  GetWarrantyError();
}
