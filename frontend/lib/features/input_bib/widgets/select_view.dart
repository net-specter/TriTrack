import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/features/input_bib/widgets/keypad_view.dart';
import 'package:frontend/features/input_bib/widgets/list_view.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/participant_provider.dart';

class SelectView extends StatefulWidget {
  final String segmentType;
  const SelectView({super.key, required this.segmentType});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  String selectedToggle = 'Cards';
  int currentPage = 0;
  final int itemsPerPage = 12;

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(
      context,
      listen: false,
    );
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CardToggle(
                label: "Cards",
                isSelected: selectedToggle == 'Cards',
                onTap: () {
                  setState(() {
                    selectedToggle = 'Cards';
                  });
                },
              ),
              CardToggle(
                label: 'Keypad',
                isSelected: selectedToggle == 'Keypad',
                onTap: () {
                  setState(() {
                    selectedToggle = 'Keypad';
                  });
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child:
                  selectedToggle == 'Cards'
                      ? ListViewComponent(
                        segment: widget.segmentType,
                        stream: participantProvider.getParticipantBySegment(
                          widget.segmentType,
                        ),
                        itemsPerPage: itemsPerPage,
                        currentPage: currentPage,
                        onPageChanged: (page) {
                          setState(() {
                            currentPage = page;
                          });
                        },
                        onClickSetTime: (id) {
                          switch (widget.segmentType) {
                            case 'swimming':
                              participantProvider.cardClickSwimming(id);
                              break;
                            case 'running':
                              participantProvider.cardClickRunning(id);
                              break;
                            case 'cycling':
                              participantProvider.cardClickCycling(id);
                              break;
                          }
                        },
                        onClickRemoveTime: (id) {
                          switch (widget.segmentType) {
                            case 'swimming':
                              participantProvider.cardClickRemoveSwimming(id);
                              break;
                            case 'running':
                              participantProvider.cardClickRemoveRunning(id);
                              break;
                            case 'cycling':
                              participantProvider.cardClickRemoveCycling(id);
                              break;
                          }
                        },
                      )
                      : KeypadView(segmentType: widget.segmentType),
            ),
          ),
        ],
      ),
    );
  }
}

class CardToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CardToggle({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E61F6) : Colors.white,
          borderRadius:
              label == 'Cards'
                  ? const BorderRadius.horizontal(left: Radius.circular(6))
                  : const BorderRadius.horizontal(right: Radius.circular(6)),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF4E61F6),
          ),
        ),
        child: Text(
          label,
          style: TriTextStyles.bodySmall.copyWith(
            color: isSelected ? TriColors.white : TriColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
