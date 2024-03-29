import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:petsmart_admin/blocs/categories/categories_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';
import 'package:petsmart_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:petsmart_admin/util/custom_file_picker.dart';
import 'package:petsmart_admin/util/value_validators.dart';

import '../custom_button.dart';
import '../custom_card.dart';

class AddPetCategoryDialog extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  const AddPetCategoryDialog({
    super.key,
    required this.categoriesBloc,
  });

  @override
  State<AddPetCategoryDialog> createState() => _AddPetCategoryDialogState();
}

class _AddPetCategoryDialogState extends State<AddPetCategoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomCard(
        hoverBorderColor: Colors.transparent,
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Category",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Enter the following details to add a pet category.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
                  Text(
                    'Category Name',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomCard(
                    child: TextFormField(
                      controller: _nameController,
                      validator: alphanumericWithSpaceValidator,
                      decoration: const InputDecoration(
                        hintText: 'eg. Dog',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomActionButton(
                    color: selectedFile != null
                        ? Colors.green[300]!
                        : Colors.grey[300]!,
                    iconData: selectedFile != null
                        ? Icons.check_outlined
                        : Icons.upload_outlined,
                    iconColor: selectedFile != null
                        ? Colors.green[900]!
                        : Colors.grey[900]!,
                    onPressed: () async {
                      PlatformFile? file = await pickFile();
                      if (file != null) {
                        selectedFile = file;
                        setState(() {});
                      }
                    },
                    labelColor: selectedFile != null
                        ? Colors.green[900]!
                        : Colors.grey[900]!,
                    label: selectedFile != null ? 'Added' : 'Add Image',
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
                  CustomButton(
                    buttonColor: Colors.pink,
                    labelColor: Colors.white,
                    label: 'Add',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedFile != null) {
                          widget.categoriesBloc.add(
                            AddCategoriesEvent(
                              category: _nameController.text.trim(),
                              image: selectedFile!,
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const CustomAlertDialog(
                              title: 'Select Image',
                              message: 'Select an image to continue',
                              primaryButtonLabel: 'Ok',
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
