import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/pet_categories/add_pet_category_dialog.dart';
import 'package:petsmart_admin/ui/widgets/pet_categories/pet_category_card.dart';

class PetCategoriesScreen extends StatefulWidget {
  const PetCategoriesScreen({super.key});

  @override
  State<PetCategoriesScreen> createState() => _PetCategoriesScreenState();
}

class _PetCategoriesScreenState extends State<PetCategoriesScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: CustomSearch(
                    onSearch: (search) {},
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomActionButton(
                    iconData: Icons.add,
                    label: 'Add Category',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddPetCategoryDialog(),
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
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(
                    10,
                    (index) => const PetCategoryCard(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
