import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/custom_search.dart';
import 'package:petsmart_admin/ui/widgets/listing/show_seller_dialog.dart';
import 'package:petsmart_admin/ui/widgets/order/show_buyer_dialog.dart';
import 'package:petsmart_admin/ui/widgets/order/show_listing_dialog.dart';

class DashboardAndOrderScreen extends StatefulWidget {
  const DashboardAndOrderScreen({super.key});

  @override
  State<DashboardAndOrderScreen> createState() =>
      _DashboardAndOrderScreenState();
}

class _DashboardAndOrderScreenState extends State<DashboardAndOrderScreen> {
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                DashboardCard(
                  label: 'Today\'s Orders',
                  title: '20',
                ),
                DashboardCard(
                  label: 'Total Listings',
                  title: '100',
                ),
                DashboardCard(
                  label: 'Total Doctors',
                  title: '30',
                ),
                DashboardCard(
                  label: 'Total Trainers',
                  title: '40',
                ),
              ],
            ),

            const Divider(
              height: 30,
            ),
            CustomSearch(
              onSearch: (search) {},
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                OrderItem(
                  isSeleted: true,
                  label: 'Orderd',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                OrderItem(
                  isSeleted: false,
                  label: 'Picked',
                  onTap: () {},
                ),
              ],
            ),
            const Divider(
              height: 40,
            ),

            Expanded(
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: [
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "#ID",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Date",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Commission",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text(
                      "Price",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.L,
                    label: Text(
                      "Actions",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  20,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          index.toString(),
                        ),
                      ),
                      const DataCell(
                        Text(
                          "19/04/2023",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "₹2250",
                        ),
                      ),
                      const DataCell(
                        Text(
                          "₹15000",
                        ),
                      ),
                      DataCell(
                        Wrap(
                          children: [
                            CustomActionButton(
                              iconData: Icons.arrow_outward_outlined,
                              mainAxisSize: MainAxisSize.min,
                              label: 'Seller',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const ShowSellerDetailsDialog(),
                                );
                              },
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomActionButton(
                              mainAxisSize: MainAxisSize.min,
                              iconData: Icons.arrow_outward_outlined,
                              label: 'Buyer',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const ShowBuyerDetailsDialog(),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomActionButton(
                              iconData: Icons.arrow_outward_outlined,
                              mainAxisSize: MainAxisSize.min,
                              label: 'Listing',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const ShowListingDialog(),
                                );
                              },
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 40,
            // ),
          ],
        ),
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
