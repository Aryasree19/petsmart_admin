import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';
import 'package:petsmart_admin/ui/widgets/listing/listing_card.dart';
import 'package:petsmart_admin/ui/widgets/user/user_card.dart';

class ShowUserDialog extends StatefulWidget {
  const ShowUserDialog({super.key});

  @override
  State<ShowUserDialog> createState() => _ShowUserDialogState();
}

class _ShowUserDialogState extends State<ShowUserDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 320,
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
                      'User Details',
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
                const Center(
                  child: UserCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
