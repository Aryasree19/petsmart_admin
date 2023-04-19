import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';

class ShowBuyerDetailsDialog extends StatefulWidget {
  const ShowBuyerDetailsDialog({super.key});

  @override
  State<ShowBuyerDetailsDialog> createState() => _ShowBuyerDetailsDialogState();
}

class _ShowBuyerDetailsDialogState extends State<ShowBuyerDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 450,
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buyer Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.pink,
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
                  children: const [
                    Expanded(
                      child: LabelWithText(
                        label: 'Name',
                        text: 'Peter',
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone',
                        text: '9876152342',
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
                  children: const [
                    Expanded(
                      child: LabelWithText(
                        label: 'Email',
                        text: 'peter@email.com',
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Contact Number',
                        text: '87908764531',
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: LabelWithText(
                        label: 'Address',
                        text: 'address line 1, address line 2',
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Place',
                        text: 'Kannur',
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
                  children: const [
                    Expanded(
                      child: LabelWithText(
                        label: 'District',
                        text: 'Kannur',
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'State',
                        text: 'Kerala',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const LabelWithText(
                  label: 'Pin',
                  text: '670301',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomActionButton(
                  iconData: Icons.map_outlined,
                  onPressed: () {},
                  label: 'Location',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
