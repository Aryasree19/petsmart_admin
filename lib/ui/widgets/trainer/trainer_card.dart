import 'package:flutter/material.dart';
import 'package:petsmart_admin/blocs/docs_trains/docs_trains_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';
import 'package:petsmart_admin/ui/widgets/trainer/add_edit_trainer_dialog.dart';

class TrainerCard extends StatefulWidget {
  final DocsTrainsBloc docsTrainsBloc;
  final dynamic trainerDetails;
  const TrainerCard({
    super.key,
    required this.docsTrainsBloc,
    required this.trainerDetails,
  });

  @override
  State<TrainerCard> createState() => _TrainerCardState();
}

class _TrainerCardState extends State<TrainerCard> {
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
                      text: widget.trainerDetails['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Phone',
                      text: widget.trainerDetails['phone'],
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
                      text: widget.trainerDetails['address_line'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Place',
                      text: widget.trainerDetails['place'],
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
                      text: widget.trainerDetails['district'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'State',
                      text: widget.trainerDetails['state'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Pin',
                text: widget.trainerDetails['pin_code'],
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
                            docsTrainsId: widget.trainerDetails['id'],
                            type: 'trainer',
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
                          builder: (context) => AddEditTrainerDialog(
                            docsTrainsBloc: widget.docsTrainsBloc,
                            trainerDetails: widget.trainerDetails,
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
