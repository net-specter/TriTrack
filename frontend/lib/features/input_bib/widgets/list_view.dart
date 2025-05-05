import 'package:flutter/material.dart';
import '../../../core/models/participant.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import 'pagination.dart';

class ListViewComponent extends StatelessWidget {
  final Stream<List<Participant>> stream;
  final int currentPage;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<String> onClickSetTime;
  final ValueChanged<String> onClickRemoveTime;
  final String segment;

  const ListViewComponent({
    super.key,
    required this.stream,
    required this.currentPage,
    required this.itemsPerPage,
    required this.onPageChanged,
    required this.onClickSetTime,
    required this.onClickRemoveTime,
    required this.segment,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Participant>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: paginatedItems.length,
                itemBuilder: (context, index) {
                  var item = paginatedItems[index];
                  DateTime? segmentTime;
                  String? segmentDuration;

                  if (segment == "swimming") {
                    segmentTime = item.swimmingTime;
                    segmentDuration = item.swimmingDuration;
                  } else if (segment == "cycling") {
                    segmentTime = item.cyclingTime;
                    segmentDuration = item.cyclingDuration;
                  } else if (segment == "running") {
                    segmentTime = item.runningTime;
                    segmentDuration = item.runningDuration;
                  }

                  return GestureDetector(
                    onTap:
                        () => {
                          if (segmentTime != null)
                            onClickRemoveTime(item.id)
                          else
                            onClickSetTime(item.id),
                        },
                    child: Card(
                      color:
                          segmentTime != null
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
                              item.bibNumber.toString(),
                              style: (segmentTime != null
                                      ? TriTextStyles.bodySmall
                                      : TriTextStyles.body)
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                            if (segmentTime != null)
                              Text(
                                "$segmentDuration",
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
