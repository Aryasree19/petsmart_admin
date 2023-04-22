import 'package:flutter/material.dart';
import 'package:petsmart_admin/blocs/categories/categories_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';

class PetCategoryCard extends StatelessWidget {
  final dynamic categoryDetails;
  final CategoriesBloc categoriesBloc;
  const PetCategoryCard({
    super.key,
    this.categoryDetails,
    required this.categoriesBloc,
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
                '#${categoryDetails['id'].toString()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    categoryDetails['image_url'],
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Name',
                text: categoryDetails['category'],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomActionButton(
                color: Colors.red[400]!,
                iconData: Icons.delete_forever_outlined,
                label: 'Delete',
                onPressed: () {
                  categoriesBloc.add(
                    DeleteCategoriesEvent(
                      categoryId: categoryDetails['id'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
