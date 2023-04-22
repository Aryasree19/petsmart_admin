import 'package:flutter/material.dart';
import 'package:petsmart_admin/blocs/docs_trains/docs_trains_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';
import 'package:petsmart_admin/ui/widgets/doctor/add_edit_doctor_dialog.dart';

class DoctorCard extends StatefulWidget {
  final DocsTrainsBloc docsTrainsBloc;
  final dynamic doctorDetails;
  const DoctorCard({
    super.key,
    required this.docsTrainsBloc,
    required this.doctorDetails,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Name',
                      text: widget.doctorDetails['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone',
                      text: widget.doctorDetails['phone'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Address',
                      text: widget.doctorDetails['address_line'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Place',
                      text: widget.doctorDetails['place'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'District',
                      text: widget.doctorDetails['district'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'State',
                      text: widget.doctorDetails['state'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Pin',
                text: widget.doctorDetails['pin_code'],
              ),
              const Divider(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomActionButton(
                      color: Colors.red[700]!,
                      iconData: Icons.delete_forever_outlined,
                      onPressed: () {
                        widget.docsTrainsBloc.add(
                          DeleteDocsTrainsEvent(
                            docsTrainsId: widget.doctorDetails['id'],
                            type: 'doctor',
                          ),
                        );
                      },
                      label: 'Delete',
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      color: Colors.teal[300]!,
                      iconData: Icons.edit_outlined,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddEditDoctorDialog(
                            docsTrainsBloc: widget.docsTrainsBloc,
                            doctorDetails: widget.doctorDetails,
                          ),
                        );
                      },
                      label: 'Edit',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
