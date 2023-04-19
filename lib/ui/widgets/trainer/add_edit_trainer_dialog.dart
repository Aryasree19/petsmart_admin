import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_action_button.dart';

import '../custom_button.dart';
import '../custom_card.dart';

class AddEditTrainerDialog extends StatefulWidget {
  final Map<String, dynamic>? trainerDetails;
  const AddEditTrainerDialog({
    super.key,
    this.trainerDetails,
  });

  @override
  State<AddEditTrainerDialog> createState() => _AddEditTrainerDialogState();
}

class _AddEditTrainerDialogState extends State<AddEditTrainerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    if (widget.trainerDetails != null) {
      _nameController.text = widget.trainerDetails!['name'];
      _addressController.text = widget.trainerDetails!['address'];
      _phoneNumberController.text = widget.trainerDetails!['phone'];
      _cityController.text = widget.trainerDetails!['city'];
      _districtController.text = widget.trainerDetails!['district'];
      _stateController.text = widget.trainerDetails!['state'];
      _descriptionController.text = widget.trainerDetails!['description'];
      _pinCodeController.text = widget.trainerDetails!['pin'].toString();
    }
    super.initState();
  }

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
                              widget.trainerDetails != null
                                  ? "Edit Trainer"
                                  : "Add Trainer",
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
                              widget.trainerDetails != null
                                  ? "Change the following details and save to apply them"
                                  : "Enter the following details to add a trainer.",
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
                    'Name',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomCard(
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter Name';
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'eg. Mr.John',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomCard(
                    child: TextFormField(
                      maxLines: 2,
                      controller: _descriptionController,
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter description';
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'eg.Decription of the trainer',
                      ),
                    ),
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
                  Text(
                    'Address',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomCard(
                    child: TextFormField(
                      maxLines: 2,
                      controller: _addressController,
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter address';
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'address line 1, address line 2',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            CustomCard(
                              child: TextFormField(
                                controller: _phoneNumberController,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Please enter Phone';
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'eg. 9876543210',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            CustomCard(
                              child: TextFormField(
                                controller: _cityController,
                                validator: (value) {
                                  if ((value != null &&
                                          value.trim().isNotEmpty) ||
                                      widget.trainerDetails != null) {
                                    return null;
                                  } else {
                                    return 'Please enter your city';
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Kannur',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'District',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            CustomCard(
                              child: TextFormField(
                                controller: _districtController,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Please enter your district';
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Kannur',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            CustomCard(
                              child: TextFormField(
                                controller: _stateController,
                                validator: (value) {
                                  if ((value != null &&
                                          value.trim().isNotEmpty) ||
                                      widget.trainerDetails != null) {
                                    return null;
                                  } else {
                                    return 'Please enter your state';
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Kerala',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pin Code',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 5),
                      CustomCard(
                        child: TextFormField(
                          controller: _pinCodeController,
                          validator: (value) {
                            if ((value != null && value.trim().isNotEmpty) ||
                                widget.trainerDetails != null) {
                              return null;
                            } else {
                              return 'Please enter pin code';
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'eg.123456',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
                  CustomActionButton(
                    iconData: Icons.map_outlined,
                    color: Colors.purple[200]!,
                    onPressed: () {},
                    label: 'Select Location from Map',
                  ),
                  const Divider(
                    height: 30,
                    color: Color.fromARGB(66, 176, 176, 176),
                  ),
                  CustomButton(
                    buttonColor: Colors.pink,
                    labelColor: Colors.white,
                    label: widget.trainerDetails != null ? 'Save' : 'Add',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.trainerDetails != null) {
                          // BlocProvider.of<PatientBloc>(context).add(
                          //   EditPatientEvent(
                          //     patientId: widget.patientDetails!['id'],
                          //     name: _nameController.text.trim(),
                          //     phone: _phoneNumberController.text.trim(),
                          //     address: _addressController.text.trim(),
                          //     city: _cityController.text.trim(),
                          //     district: _districtController.text.trim(),
                          //     dob: _dob!,
                          //     gender: _gender,
                          //     state: _stateController.text.trim(),
                          //   ),
                          // );
                        } else {
                          // BlocProvider.of<PatientBloc>(context).add(
                          //   AddPatientEvent(
                          //     name: _nameController.text.trim(),
                          //     phone: _phoneNumberController.text.trim(),
                          //     address: _addressController.text.trim(),
                          //     city: _cityController.text.trim(),
                          //     district: _districtController.text.trim(),
                          //     dob: _dob!,
                          //     gender: _gender,
                          //     state: _stateController.text.trim(),
                          //   ),
                          // );
                        }

                        Navigator.pop(context);
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
