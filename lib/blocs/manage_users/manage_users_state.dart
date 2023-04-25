part of 'manage_users_bloc.dart';

@immutable
abstract class ManageUsersState {}

class ManageUsersInitialState extends ManageUsersState {}

class ManageUsersSuccessState extends ManageUsersState {
  final List<Map<String, dynamic>> users;

  ManageUsersSuccessState({required this.users});
}

class ManageUsersLoadingState extends ManageUsersState {}

class ManageUsersFailureState extends ManageUsersState {
  final String message;

  ManageUsersFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}
