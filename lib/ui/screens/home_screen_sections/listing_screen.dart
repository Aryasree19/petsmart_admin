import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/ui/widgets/category_selector.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/listing/listing_card.dart';

import '../../../blocs/manage_listings/manage_listings_bloc.dart';
import '../../widgets/custom_alert_dialog.dart';

class ListingScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const ListingScreen({super.key, required this.manageListingsBloc});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  int selectedCategoryId = 0;
  String? query;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() {
    widget.manageListingsBloc.add(
      GetAllListingsEvent(
        query: query,
        categoryId: selectedCategoryId == 0 ? null : selectedCategoryId,
        status: 'pending',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<ManageListingsBloc, ManageListingsState>(
        listener: (context, state) {
          if (state is ManageListingsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  widget.manageListingsBloc.add(GetAllListingsEvent());
                  Navigator.pop(context);
                },
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
                  children: [
                    Expanded(
                      child: CustomSearch(
                        onSearch: (search) {
                          query = search;
                          getProducts();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 300,
                      child: CategoriesSelector(
                        onSelect: (id) {
                          selectedCategoryId = id;
                          getProducts();
                        },
                        label: 'Select Category',
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 40,
                ),
                Expanded(
                  child: state is ManageListingsSuccessState
                      ? SingleChildScrollView(
                          child: state.listings.isNotEmpty
                              ? Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.listings.length,
                                    (index) => ListingCard(
                                      listingDetails: state.listings[index],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No Listings'),
                                ),
                        )
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
    );
  }
}
