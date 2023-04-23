import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';

class ShowSellerDetailsDialog extends StatefulWidget {
  final dynamic listingDetails;
  const ShowSellerDetailsDialog({super.key, required this.listingDetails});

  @override
  State<ShowSellerDetailsDialog> createState() =>
      _ShowSellerDetailsDialogState();
}

class _ShowSellerDetailsDialogState extends State<ShowSellerDetailsDialog> {
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
                      'Seller Details',
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
                  children: [
                    Expanded(
                      child: LabelWithText(
                        label: 'Name',
                        text: widget.listingDetails['seller']['name'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone',
                        text: widget.listingDetails['seller']['phone'],
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
                        label: 'Email',
                        text: widget.listingDetails['seller']['email'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Contact Number',
                        text: widget.listingDetails['phone'],
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
                  children: [
                    Expanded(
                      child: LabelWithText(
                        label: 'Address',
                        text: widget.listingDetails['address_line'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Place',
                        text: widget.listingDetails['place'],
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
                        text: widget.listingDetails['district'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'State',
                        text: widget.listingDetails['state'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LabelWithText(
                  label: 'Pin',
                  text: widget.listingDetails['pin_code'].toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
