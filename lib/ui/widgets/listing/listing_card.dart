import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:petsmart_admin/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:petsmart_admin/ui/screens/pet_images.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';
import 'package:petsmart_admin/ui/widgets/listing/show_seller_dialog.dart';

class ListingCard extends StatelessWidget {
  final Color? hoverColor;
  final bool isOnDialog;
  final dynamic listingDetails;
  const ListingCard({
    super.key,
    this.hoverColor = Colors.pink,
    this.isOnDialog = false,
    required this.listingDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      hoverBorderColor: hoverColor!,
      child: SizedBox(
        width: 310,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${listingDetails['id'].toString()}',
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
                    listingDetails['images'][0]['image_url'],
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
                label: 'Title',
                text: listingDetails['title'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Description',
                text: listingDetails['description'],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Price',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹${listingDetails['price'].toString()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '₹${listingDetails['discounted_price'].toString()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              isOnDialog
                  ? CustomActionButton(
                      iconData: Icons.image_outlined,
                      label: 'Images',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PetImagesScreen(
                              images: listingDetails['images'],
                            ),
                          ),
                        );
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomActionButton(
                            iconData: Icons.arrow_outward_outlined,
                            label: 'Seller Details',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ShowSellerDetailsDialog(
                                    listingDetails: listingDetails),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomActionButton(
                            iconData: Icons.image_outlined,
                            label: 'Images',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PetImagesScreen(
                                    images: listingDetails['images'],
                                  ),
                                ),
                              );
                            },
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
