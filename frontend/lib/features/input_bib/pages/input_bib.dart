import 'package:flutter/material.dart';
import 'package:frontend/features/input_bib/widgets/timecount.dart';
import '../../../core/widgets/tabs/tab_component.dart';
import '../widgets/select_view.dart';

class InputBib extends StatefulWidget {
  const InputBib({super.key});

  @override
  State<InputBib> createState() => _InputBibState();
}

class _InputBibState extends State<InputBib> {
  String currentPage = "swimming";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Timecount(),
            const SizedBox(height: 10),
            TabComponent(
              tabs: {
                "swimming": Icons.pool,
                "cycling": Icons.directions_bike,
                "running": Icons.directions_run,
              },
              onTabSelected: [
                () {
                  setState(() => currentPage = "swimming");
                },
                () {
                  setState(() => currentPage = "cycling");
                },
                () {
                  setState(() => currentPage = "running");
                },
              ],
            ),
            Expanded(child: SelectView(segmentType: currentPage)),
          ],
        ),
      ),
    );
  }
}
