import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    int totalPages = (totalItems / itemsPerPage).ceil();
    int windowSize = 4;
    int startIndex = (currentPage ~/ windowSize) * windowSize;
    int endIndex = (startIndex + windowSize).clamp(0, totalPages);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: currentPage > 0 ? () => onPageChanged(0) : null,
                  icon: const Icon(Icons.first_page),
                ),
                IconButton(
                  onPressed:
                      currentPage > 0
                          ? () => onPageChanged(currentPage - 1)
                          : null,
                  icon: const Icon(Icons.navigate_before),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(endIndex - startIndex, (i) {
                  int pageIndex = startIndex + i;
                  return GestureDetector(
                    onTap: () => onPageChanged(pageIndex),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color:
                            currentPage == pageIndex
                                ? TriColors.primary
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${pageIndex * itemsPerPage + 1}-${((pageIndex + 1) * itemsPerPage > totalItems ? totalItems : (pageIndex + 1) * itemsPerPage)}",
                        style: TriTextStyles.caption.copyWith(
                          color:
                              currentPage == pageIndex
                                  ? TriColors.white
                                  : Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed:
                      currentPage < totalPages - 1
                          ? () => onPageChanged(currentPage + 1)
                          : null,
                  icon: const Icon(Icons.navigate_next),
                ),
                IconButton(
                  onPressed:
                      currentPage < totalPages - 1
                          ? () => onPageChanged(totalPages - 1)
                          : null,
                  icon: const Icon(Icons.last_page),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
