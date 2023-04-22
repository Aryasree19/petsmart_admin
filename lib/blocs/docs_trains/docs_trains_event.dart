part of 'docs_trains_bloc.dart';

@immutable
abstract class DocsTrainsEvent {}

class AddDocsTrainsEvent extends DocsTrainsEvent {
  final String name,
      description,
      phone,
      address,
      place,
      district,
      state,
      pin,
      type;

  AddDocsTrainsEvent({
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.place,
    required this.district,
    required this.state,
    required this.pin,
    required this.type,
  });
}

class EditDocsTrainsEvent extends DocsTrainsEvent {
  final int docsTrainsId;
  final String name, description, phone, address, place, district, state, pin;
  final String type;

  EditDocsTrainsEvent({
    required this.docsTrainsId,
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.place,
    required this.district,
    required this.state,
    required this.pin,
    required this.type,
  });
}

class DeleteDocsTrainsEvent extends DocsTrainsEvent {
  final int docsTrainsId;
  final String type;

  DeleteDocsTrainsEvent({
    required this.docsTrainsId,
    required this.type,
  });
}

class GetAllDocsTrainsEvent extends DocsTrainsEvent {
  final String? query;
  final String type;

  GetAllDocsTrainsEvent({
    this.query,
    required this.type,
  });
}
