import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class CategoriesSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const CategoriesSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  final CategoriesBloc departmentBloc = CategoriesBloc();

  @override
  void initState() {
    departmentBloc.add(GetAllCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<CategoriesBloc>.value(
        value: departmentBloc,
        child: BlocConsumer<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    departmentBloc.add(GetAllCategoriesEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CategoriesSuccessState) {
              return CustomSelectBox(
                iconData: Icons.pets,
                items: List<CustomSelectBoxItem>.generate(
                  state.categories.length,
                  (index) => CustomSelectBoxItem(
                    value: state.categories[index]['id'],
                    label: state.categories[index]['category'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is CategoriesFailureState) {
              return const SizedBox();
            } else {
              return const SizedBox(
                width: 100,
                child: SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
