import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters
import 'package:frontend/features/input_bib/widgets/table_keypad.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/participant_provider.dart';

class KeypadView extends StatelessWidget {
  final String segmentType;
  const KeypadView({super.key, required this.segmentType});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _bibController = TextEditingController();

    // ignore: no_leading_underscores_for_local_identifiers
    void _addParticipant() async {
      final bibNumber = _bibController.text.trim();
      if (bibNumber.isNotEmpty) {
        String result = '';
        switch (segmentType) {
          case 'swimming':
            result = await participantProvider.inputParticipantSwimming(
              bibNumber,
            );
            break;
          case 'cycling':
            result = await participantProvider.inputParticipantCycling(
              bibNumber,
            );
            break;
          case 'running':
            result = await participantProvider.inputParticipantRunning(
              bibNumber,
            );
            break;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result), duration: const Duration(seconds: 2)),
        );
        if (result == 'Success') {
          _bibController.clear();
        }
      }
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF9DB2CE)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _bibController,
                  keyboardType: TextInputType.number, // Numeric keyboard
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'Input BIB number',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _addParticipant(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF4E61F6)),
                onPressed: _addParticipant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: TableKeypad(segmentType: segmentType)),
        const SizedBox(height: 20),
      ],
    );
  }
}
