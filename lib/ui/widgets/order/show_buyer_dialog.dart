import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';

class ShowBuyerDetailsDialog extends StatefulWidget {
  final dynamic listingDetails;
  const ShowBuyerDetailsDialog({super.key, required this.listingDetails});

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
                  children: [
                    Expanded(
                      child: LabelWithText(
                        label: 'Name',
                        text: widget.listingDetails['bought_user']['name'],
                      ),
                    ),
                    Expanded(
                      child: LabelWithText(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        label: 'Phone',
                        text: widget.listingDetails['bought_user']['phone'],
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
                        text: widget.listingDetails['bought_user']['email'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
