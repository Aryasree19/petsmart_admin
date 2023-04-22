part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class AddCategoriesEvent extends CategoriesEvent {
  final String category;
  final PlatformFile image;

  AddCategoriesEvent({
    required this.category,
    required this.image,
  });
}

class EditCategoriesEvent extends CategoriesEvent {
  final int categoryId;
  final String category;
  final PlatformFile? image;

  EditCategoriesEvent({
    required this.categoryId,
    required this.category,
    this.image,
  });
}

class DeleteCategoriesEvent extends CategoriesEvent {
  final int categoryId;

  DeleteCategoriesEvent({required this.categoryId});
}

class GetAllCategoriesEvent extends CategoriesEvent {
  final String? query;

  GetAllCategoriesEvent({this.query});
}
