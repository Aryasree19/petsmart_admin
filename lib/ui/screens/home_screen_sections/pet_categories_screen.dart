import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/blocs/categories/categories_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/pet_categories/add_pet_category_dialog.dart';
import 'package:petsmart_admin/ui/widgets/pet_categories/pet_category_card.dart';

import '../../widgets/custom_alert_dialog.dart';

class PetCategoriesScreen extends StatefulWidget {
  const PetCategoriesScreen({super.key});

  @override
  State<PetCategoriesScreen> createState() => _PetCategoriesScreenState();
}

class _PetCategoriesScreenState extends State<PetCategoriesScreen> {
  final CategoriesBloc categoriesBloc = CategoriesBloc();

  String? query;

  void getCategories() {
    categoriesBloc.add(GetAllCategoriesEvent(query: query));
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<CategoriesBloc>.value(
        value: categoriesBloc,
        child: BlocConsumer<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                ),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          onSearch: (search) {
                            query = search;
                            getCategories();
                          },
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
                              builder: (context) => AddPetCategoryDialog(
                                categoriesBloc: categoriesBloc,
                              ),
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
                    child: state is CategoriesSuccessState
                        ? state.categories.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.categories.length,
                                    (index) => PetCategoryCard(
                                      categoriesBloc: categoriesBloc,
                                      categoryDetails: state.categories[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No categories found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
