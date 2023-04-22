import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/blocs/docs_trains/docs_trains_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/doctor/add_edit_doctor_dialog.dart';
import 'package:petsmart_admin/ui/widgets/doctor/doctor_card.dart';

import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_progress_indicator.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final DocsTrainsBloc docsTrainsBloc = DocsTrainsBloc();
  String? query;

  getDocTrains() {
    docsTrainsBloc.add(
      GetAllDocsTrainsEvent(
        type: 'doctor',
        query: query,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDocTrains();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<DocsTrainsBloc>.value(
        value: docsTrainsBloc,
        child: BlocConsumer<DocsTrainsBloc, DocsTrainsState>(
          listener: (context, state) {
            if (state is DocsTrainsFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomSearch(
                          onSearch: (search) {
                            query = search;
                            getDocTrains();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomActionButton(
                          iconData: Icons.add,
                          label: 'Add Doctor',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditDoctorDialog(
                                docsTrainsBloc: docsTrainsBloc,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is DocsTrainsSuccessState
                        ? state.docsTrains.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.docsTrains.length,
                                    (index) => DoctorCard(
                                      docsTrainsBloc: docsTrainsBloc,
                                      doctorDetails: state.docsTrains[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No doctors found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
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
