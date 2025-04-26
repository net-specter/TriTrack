import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/buttons/primary_button.dart';
import 'package:frontend/core/widgets/tabs/tab_component.dart';

import '../../../core/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('00:00:00', style: TriTextStyles.headline),
          Text('Participants Dashboard', style: TriTextStyles.title),
          const SizedBox(height: 20),
          PrimaryButton(
            label: "Submit",
            backgroundColor: TriColors.primary,
            icon: Icon(Icons.check, color: TriColors.white, size: 20),
          ),
          const SizedBox(height: 20),
          // TabComponent(
          //   tabs: {
          //     'Swimming': Icons.pool,
          //     'Cycling': Icons.pool,
          //     'Running': Icons.pool,
          //   },
          //   pages: [
          //     const Center(child: Text('Swimming')),
          //     const Center(child: Text('Cycling')),
          //     const Center(child: Text('Running')),
          //   ],
          // ),
          const SizedBox(height: 20),
          TabComponent(
            tabs: {
              'All': null,
              'Men': null,
              'Women': null,
              '10-29': null,
              '30-49': null,
              '50+': null,
            },
            pages: [
              const Center(child: Text('All')),
              const Center(child: Text('Men')),
              const Center(child: Text('Women')),
              const Center(child: Text('10-29')),
              const Center(child: Text('30-49')),
              const Center(child: Text('50+')),
            ],
          ),
        ],
      ),
    );
  }
}
