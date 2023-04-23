import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/blocs/manage_users/manage_users_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/user/user_card.dart';

import '../../widgets/custom_alert_dialog.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ManageUsersBloc manageUsersBloc = ManageUsersBloc();

  String? query;

  void getUsers() {
    manageUsersBloc.add(ManageUsersEvent(query: query));
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<ManageUsersBloc>.value(
        value: manageUsersBloc,
        child: BlocConsumer<ManageUsersBloc, ManageUsersState>(
          listener: (context, state) {
            if (state is ManageUsersFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                ),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomSearch(
                    onSearch: (search) {
                      query = search;
                      getUsers();
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is ManageUsersSuccessState
                        ? state.users.isNotEmpty
                            ? Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: List<Widget>.generate(
                                  state.users.length,
                                  (index) => UserCard(
                                    userDetails: state.users[index],
                                  ),
                                ))
                            : const Center(
                                child: Text('No Users found'),
                              )
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
