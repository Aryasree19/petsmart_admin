import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/user/user_card.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomSearch(
              onSearch: (search) {},
            ),
            const Divider(
              height: 40,
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List<Widget>.generate(
                10,
                (index) => const UserCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
