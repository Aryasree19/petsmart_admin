import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';

class UserCard extends StatelessWidget {
  final dynamic userDetails;
  const UserCard({
    super.key,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 310,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${userDetails['id'].toString()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Name',
                text: userDetails['name'],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Phone',
                      text: userDetails['phone'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Email',
                      text: userDetails['email'],
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
