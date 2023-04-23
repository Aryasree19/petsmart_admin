part of 'manage_listings_bloc.dart';

@immutable
abstract class ManageListingsEvent {}

class GetAllListingsEvent extends ManageListingsEvent {
  final String? query, status;
  final int? categoryId;

  GetAllListingsEvent({
    this.query,
    this.categoryId,
    this.status = 'pending',
  });
}
