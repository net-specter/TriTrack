import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/space.dart';

class AddParticipantForm extends StatefulWidget {
  const AddParticipantForm({super.key});

  @override
  State<AddParticipantForm> createState() => _AddParticipantFormState();
}

class _AddParticipantFormState extends State<AddParticipantForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _bibNumber = '';
  String _fullName = '';
  String _category = 'Male 10-29';

  final List<String> _categories = [
    'Male 10-29',
    'Male 30-49',
    'Male 50+',
    'Female 10-29',
    'Female 30-49',
    'Female 50+',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Participant $_fullName added successfully!',
            style: TriTextStyles.bodySmall,
          ),
        ),
      );
      Navigator.pop(context);
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
              CustomTextFormField(
                hintText: 'BIB #',
                onChanged: (value) => setState(() => _bibNumber = value),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter BIB number'
                            : null,
              ),
              FormFieldLabel(label: 'Full Name'),
              CustomTextFormField(
                hintText: 'Participant Name',
                onChanged: (value) => setState(() => _fullName = value),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter full name'
                            : null,
              ),
              FormFieldLabel(label: 'Category'),
              DropdownButtonFormField<String>(
                value: _category,
                items:
                    _categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TriTextStyles.bodySmall.copyWith(
                            color:
                                Colors
                                    .black, // Set dropdown item text color to black
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => _category = value!),
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
                style: TriTextStyles.bodySmall.copyWith(
                  color:
                      Colors.black, // Set selected dropdown text color to black
                ),
                dropdownColor:
                    TriColors.lightGray, // Background color of the dropdown
              ),
              const SizedBox(height: Textpacings.l),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: TriColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: Textpacings.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add Participant',
                  style: TriTextStyles.body.copyWith(
                    color: TriColors.white,
                    fontWeight: FontWeight.bold,
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

class FormFieldLabel extends StatelessWidget {
  final String label;

  const FormFieldLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Textpacings.s),
      child: Text(
        label,
        style: TriTextStyles.body.copyWith(fontWeight: FontWeight.bold),
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
