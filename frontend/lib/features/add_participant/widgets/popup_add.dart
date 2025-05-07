import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/widgets/buttons/primary_button.dart';
import 'package:frontend/features/add_participant/controllers/crud_participant.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/participant_provider.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/space.dart';

class AddParticipantForm extends StatefulWidget {
  final String title;
  final bool isEdit;
  final String? id;
  final Participant? participant;

  const AddParticipantForm({
    super.key,
    this.id,
    required this.title,
    required this.isEdit,
    this.participant,
  });

  @override
  State<AddParticipantForm> createState() => _AddParticipantFormState();
}

class _AddParticipantFormState extends State<AddParticipantForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bibNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  String _category = 'Male 10-29';

  final List<String> _categories = [
    'Male 10-29',
    'Male 30-49',
    'Male 50+',
    'Female 10-29',
    'Female 30-49',
    'Female 50+',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.participant != null) {
      // Populate fields with existing participant data
      _bibNumberController.text = widget.participant!.bibNumber.toString();
      _fullNameController.text = widget.participant!.name;
      _category = widget.participant!.category;
    }
  }

  @override
  void dispose() {
    _bibNumberController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final participantProvider = Provider.of<ParticipantProvider>(
        context,
        listen: false,
      );

      final bibNumber = double.tryParse(_bibNumberController.text) ?? 0;
      final fullName = _fullNameController.text;

      if (!widget.isEdit) {
        // Add new participant
        final docRef =
            FirebaseFirestore.instance.collection('participants').doc();
        final autoId = docRef.id;
        final participant = Participant(
          id: autoId,
          name: fullName,
          bibNumber: bibNumber,
          category: _category,
        );

        await createParticipant(context, participantProvider, participant);
      } else {
        // Edit existing participant
        final participant = Participant(
          id: widget.id!,
          name: fullName,
          bibNumber: bibNumber,
          category: _category,
        );

        await participantProvider.updateParticipant(widget.id!, participant);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Textpacings.l),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormFieldLabel(label: 'BIB Number'),
              TextFormField(
                controller: _bibNumberController, // Use controller
                decoration: InputDecoration(
                  hintText: 'BIB #',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: TriColors.greyLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Textpacings.m,
                    vertical: Textpacings.m,
                  ),
                  filled: true,
                  fillColor: TriColors.lightGray,
                ),
                style: TriTextStyles.body,
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter BIB number'
                            : null,
              ),
              FormFieldLabel(label: 'Full Name'),
              TextFormField(
                controller: _fullNameController, // Use controller
                decoration: InputDecoration(
                  hintText: 'Participant Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: TriColors.greyLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Textpacings.m,
                    vertical: Textpacings.m,
                  ),
                  filled: true,
                  fillColor: TriColors.lightGray,
                ),
                style: TriTextStyles.body,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter full name'
                            : null,
              ),
              FormFieldLabel(label: 'Category'),
              DropdownButtonFormField<String>(
                value:
                    _categories.contains(_category)
                        ? _category
                        : null, // Ensure value is valid
                items:
                    _categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TriTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _category = value);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: TriColors.greyLight),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Textpacings.m,
                    vertical: Textpacings.s,
                  ),
                  filled: true,
                  fillColor: TriColors.lightGray,
                ),
                style: TriTextStyles.bodySmall.copyWith(color: Colors.black),
                dropdownColor: TriColors.lightGray,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Textpacings.l),
              PrimaryButton(label: widget.title, onPressed: _submitForm),
            ],
          ),
        ),
      ),
    );
  }
}

class FormFieldLabel extends StatelessWidget {
  final String label;

  const FormFieldLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Textpacings.m, bottom: Textpacings.s),
      child: Text(
        label,
        style: TriTextStyles.body.copyWith(
          color: TriColors.greyDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?) validator;

  const CustomTextFormField({
    required this.hintText,
    required this.onChanged,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: TriColors.greyLight),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Textpacings.m,
          vertical: Textpacings.m,
        ),
        filled: true,
        fillColor: TriColors.lightGray,
      ),
      style: TriTextStyles.body,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
