import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';

class PetImagesScreen extends StatefulWidget {
  final List<dynamic> images;
  const PetImagesScreen({
    super.key,
    required this.images,
  });

  @override
  State<PetImagesScreen> createState() => _PetImagesScreenState();
}

class _PetImagesScreenState extends State<PetImagesScreen> {
  @override
  void initState() {
    super.initState();
    Logger().wtf(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'IMAGES',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              // widget.images.isNotEmpty
              //     ?
              Expanded(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(
                    widget.images.length,
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.images[index]['image_url'],
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const Center(
                          child: CustomProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              // : const Text(
              //     'No images found',
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
