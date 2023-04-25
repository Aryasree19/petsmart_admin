import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petsmart_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/listing/show_seller_dialog.dart';
import 'package:petsmart_admin/ui/widgets/order/show_buyer_dialog.dart';
import 'package:petsmart_admin/ui/widgets/order/show_listing_dialog.dart';

import '../../../blocs/manage_listings/manage_listings_bloc.dart';
import '../../widgets/category_selector.dart';
import '../../widgets/custom_alert_dialog.dart';

class DashboardAndOrderScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  const DashboardAndOrderScreen({super.key, required this.manageListingsBloc});

  @override
  State<DashboardAndOrderScreen> createState() =>
      _DashboardAndOrderScreenState();
}

class _DashboardAndOrderScreenState extends State<DashboardAndOrderScreen> {
  int selectedCategoryId = 0;
  String? query;
  String status = 'ordered';

  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  @override
  void initState() {
    super.initState();
    getProducts();
    dashboardCountBloc.add(DashboardCountEvent());
  }

  void getProducts() {
    widget.manageListingsBloc.add(
      GetAllListingsEvent(
        query: query,
        categoryId: selectedCategoryId == 0 ? null : selectedCategoryId,
        status: status,
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                BlocProvider<DashboardCountBloc>.value(
                  value: dashboardCountBloc,
                  child: BlocConsumer<DashboardCountBloc, DashboardCountState>(
                    listener: (context, dashState) {
                      if (dashState is DashboardCountFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Failed',
                            message: dashState.message,
                            primaryButtonLabel: 'Ok',
                            primaryOnPressed: () {
                              dashboardCountBloc.add(DashboardCountEvent());
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                    },
                    builder: (context, dashState) {
                      return dashState is DashboardCountSuccessState
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                DashboardCard(
                                  label: 'Total Orders',
                                  title: dashState.dashbordCount['orders'],
                                ),
                                DashboardCard(
                                  label: 'Total Listings',
                                  title: dashState.dashbordCount['listings'],
                                ),
                                DashboardCard(
                                  label: 'Total Doctors',
                                  title: dashState.dashbordCount['doctors'],
                                ),
                                DashboardCard(
                                  label: 'Total Trainers',
                                  title: dashState.dashbordCount['trainers'],
                                ),
                              ],
                            )
                          : const Center(
                              child: CustomProgressIndicator(),
                            );
                    },
                  ),
                ),

                const Divider(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Orders',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(width: 20),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    OrderItem(
                      isSeleted: status == 'ordered',
                      label: 'Ordered',
                      onTap: () {
                        status = 'ordered';
                        getProducts();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OrderItem(
                      isSeleted: status == 'complete',
                      label: 'Picked',
                      onTap: () {
                        status = 'complete';
                        getProducts();
                      },
                    ),
                  ],
                ),
                const Divider(
                  height: 40,
                ),

                Expanded(
                  child: state is OrdersListingsSuccessState
                      ? state.listings.isNotEmpty
                          ? DataTable2(
                              columnSpacing: 12,
                              horizontalMargin: 12,
                              columns: [
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "#ID",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "Date",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "Commission",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "Price",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.L,
                                  label: Text(
                                    "Actions",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                state.listings.length,
                                (index) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        state.listings[index]['id'].toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            DateTime.parse(state.listings[index]
                                                ['bought_at'])),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "₹${(((state.listings[index]['discounted_price']) / 100) * 10).toString()}",
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "₹${state.listings[index]['discounted_price'].toString()}",
                                      ),
                                    ),
                                    DataCell(
                                      Wrap(
                                        children: [
                                          CustomActionButton(
                                            iconData:
                                                Icons.arrow_outward_outlined,
                                            mainAxisSize: MainAxisSize.min,
                                            label: 'Seller',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ShowSellerDetailsDialog(
                                                  listingDetails:
                                                      state.listings[index],
                                                ),
                                              );
                                            },
                                            color: Colors.purple,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomActionButton(
                                            mainAxisSize: MainAxisSize.min,
                                            iconData:
                                                Icons.arrow_outward_outlined,
                                            label: 'Buyer',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ShowBuyerDetailsDialog(
                                                  listingDetails:
                                                      state.listings[index],
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomActionButton(
                                            iconData:
                                                Icons.arrow_outward_outlined,
                                            mainAxisSize: MainAxisSize.min,
                                            label: 'Listing',
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ShowListingDialog(
                                                  listingDetails:
                                                      state.listings[index],
                                                ),
                                              );
                                            },
                                            color: Colors.teal,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : const Center(child: Text('No Orders'))
                      : const Center(child: CustomProgressIndicator()),
                ),
                // const SizedBox(
                //   height: 40,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool isSeleted;
  const OrderItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: isSeleted ? Colors.pink : Colors.pink[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSeleted ? Colors.white : Colors.pink,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
