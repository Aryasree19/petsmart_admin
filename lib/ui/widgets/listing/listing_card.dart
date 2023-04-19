import 'package:flutter/material.dart';
import 'package:petsmart_admin/ui/screens/pet_images.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:petsmart_admin/ui/widgets/label_with_text.dart';
import 'package:petsmart_admin/ui/widgets/listing/show_seller_dialog.dart';

class ListingCard extends StatelessWidget {
  final Color? hoverColor;
  final bool isOnDialog;
  const ListingCard({
    super.key,
    this.hoverColor = Colors.pink,
    this.isOnDialog = false,
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
                '#12',
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
                    'https://images.unsplash.com/photo-1676641244234-855100cee031?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Title',
                text: 'Dobermann for sale',
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Description',
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien.',
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
                    '₹20000',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '₹15000',
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
                            builder: (context) => const PetImagesScreen(
                              images: [],
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
                                builder: (context) =>
                                    const ShowSellerDetailsDialog(),
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
                                  builder: (context) => const PetImagesScreen(
                                    images: [],
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
