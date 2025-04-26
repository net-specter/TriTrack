import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import '../tabs/tab_item.dart';

class TabComponent extends StatelessWidget {
  final Map<String, IconData?> tabs;
  final List<Widget> pages;
  const TabComponent({super.key, required this.tabs, required this.pages});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Expanded(
          child: Column(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TabBar(
                      // isScrollable: true,
                      splashBorderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: TriColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelColor: TriColors.white,
                      unselectedLabelColor: TriColors.primary,
                      tabs: [
                        for (var entry in tabs.entries)
                          Tab(
                            child: TabItem(
                              title: entry.key,
                              icon: entry.value,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: TabBarView(children: pages)),
            ],
          ),
        ),
      ),
    );
  }
}
