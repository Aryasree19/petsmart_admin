part of 'manage_listings_bloc.dart';

@immutable
abstract class ManageListingsState {}

class ManageListingsInitialState extends ManageListingsState {}

class ManageListingsSuccessState extends ManageListingsState {
  final List<Map<String, dynamic>> listings;

  ManageListingsSuccessState({required this.listings});
}

class OrdersListingsSuccessState extends ManageListingsState {
  final List<Map<String, dynamic>> listings;

  OrdersListingsSuccessState({required this.listings});
}

class ManageListingsLoadingState extends ManageListingsState {}

class ManageListingsFailureState extends ManageListingsState {
  final String message;

  ManageListingsFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}
