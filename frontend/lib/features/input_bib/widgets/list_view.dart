import 'package:flutter/material.dart';
import 'package:frontend/data/dto/participant_dto.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/errors/loading.dart';
import '../../../core/widgets/errors/error.dart';
import 'pagination.dart';

class ListViewComponent extends StatelessWidget {
  final Stream<List<CombinedParticipantDto>> stream;
  final int currentPage;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<String> onClickSetTime;
  final ValueChanged<String> onClickRemoveTime;

  const ListViewComponent({
    super.key,
    required this.stream,
    required this.currentPage,
    required this.itemsPerPage,
    required this.onPageChanged,
    required this.onClickSetTime,
    required this.onClickRemoveTime,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CombinedParticipantDto>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Error(errorMessage: "${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No participants available.'));
        }

        final items = snapshot.data!;
        int start = currentPage * itemsPerPage;
        int end = (start + itemsPerPage).clamp(0, items.length);
        final paginatedItems = items.sublist(start, end);

        return Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 38,
                  vertical: 10,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: paginatedItems.length,
                  itemBuilder: (context, index) {
                    var item = paginatedItems[index];
                    return GestureDetector(
                      onTap:
                          () => {
                            if (item.checkpointLog.timeLog != null)
                              onClickRemoveTime(item.participant.id)
                            else
                              onClickSetTime(item.participant.id),
                          },
                      child: Card(
                        color:
                            item.checkpointLog.timeLog != null
                                ? TriColors.primaryLight
                                : TriColors.secondaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.participant.bibNumber.toString(),
                                style: (item.checkpointLog.timeLog != null
                                        ? TriTextStyles.bodySmall
                                        : TriTextStyles.body)
                                    .copyWith(fontWeight: FontWeight.w900),
                              ),
                              if (item.checkpointLog.timeLog != null)
                                Text(
                                  "${item.checkpointLog.duration}",
                                  style: TriTextStyles.captionSmall.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Pagination(
              currentPage: currentPage,
              totalItems: items.length,
              itemsPerPage: itemsPerPage,
              onPageChanged: onPageChanged,
            ),
          ],
        );
      },
    );
  }
}
