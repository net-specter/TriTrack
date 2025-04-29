import 'package:flutter/material.dart';
import '../../../core/theme/space.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/colors.dart';
import '../widgets/popup_add.dart';

class AddParticipantHome extends StatelessWidget {
  const AddParticipantHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              isDismissible: false,
              enableDrag: true,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.9,
                  builder: (
                    BuildContext context,
                    ScrollController scrollController,
                  ) {
                    return Container(
                      decoration: BoxDecoration(
                        color: TriColors.white, // Modal background color
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          ModalHeader(title: 'Add New Participant'),
                          Expanded(child: AddParticipantForm()),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: TriColors.primary,

            padding: const EdgeInsets.symmetric(
              horizontal: Textpacings.l,
              vertical: Textpacings.m,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Add Participant',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AddParticipantModal extends StatelessWidget {
  const AddParticipantModal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          width: 550,
          height: 450,
          decoration: BoxDecoration(
            color: TriColors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ModalHeader(title: 'Add New Participant'),
              Expanded(child: AddParticipantForm()),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalHeader extends StatelessWidget {
  final String title;

  const ModalHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Textpacings.l),
      child: Text(
        title,
        style: TriTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}
