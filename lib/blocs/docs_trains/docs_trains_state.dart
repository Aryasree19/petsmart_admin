part of 'docs_trains_bloc.dart';

@immutable
abstract class DocsTrainsState {}

class DocsTrainsInitialState extends DocsTrainsState {}

class DocsTrainsSuccessState extends DocsTrainsState {
  final List<Map<String, dynamic>> docsTrains;

  DocsTrainsSuccessState({required this.docsTrains});
}

class DocsTrainsLoadingState extends DocsTrainsState {}

class DocsTrainsFailureState extends DocsTrainsState {
  final String message;

  DocsTrainsFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}
