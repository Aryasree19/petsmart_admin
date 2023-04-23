import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/blocs/complaint/complaint_bloc.dart';
import 'package:petsmart_admin/ui/widgets/complaints/complaint_card.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';

import '../../widgets/custom_alert_dialog.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final ComplaintBloc complaintBloc = ComplaintBloc();
  @override
  void initState() {
    super.initState();
    complaintBloc.add(GetAllComplaintEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<ComplaintBloc>.value(
        value: complaintBloc,
        child: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state is ComplaintFailureState) {
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: state is ComplaintSuccessState
                        ? state.complaints.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) => ComplaintCard(
                                  complaintDetails: state.complaints[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: state.complaints.length,
                              )
                            : const Center(
                                child: Text('No complaints found'),
                              )
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
