part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<Map<String, dynamic>> categories;

  CategoriesSuccessState({required this.categories});
}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesFailureState extends CategoriesState {
  final String message;

  CategoriesFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}
