import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class BottomBar extends StatefulWidget {
  final void Function(int)? onIndexChanged;

  const BottomBar({super.key, this.onIndexChanged});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  final List<BottomBarItem> _items = const [
    BottomBarItem(Icons.home_outlined, Icons.home, 'Home'),
    BottomBarItem(Icons.people_outline, Icons.people, 'Participant'),
    BottomBarItem(Icons.edit_note_outlined, Icons.edit_note, 'Input BIB'),
    BottomBarItem(Icons.timer_outlined, Icons.timer, 'Time Tracker'),
    BottomBarItem(Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (index) {
          return _buildTab(_items[index], index);
        }),
      ),
    );
  }

  Widget _buildTab(BottomBarItem item, int index) {
    final isSelected = _currentIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          setState(() => _currentIndex = index);
          widget.onIndexChanged?.call(index);
        },
        splashColor: TriColors.primary.withOpacity(0.2),
        highlightColor: TriColors.primary.withOpacity(0.1),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? item.activeIcon : item.inactiveIcon,
                size: 28,
                color: isSelected ? TriColors.primary : TriColors.greyDark,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? TriColors.primary : TriColors.greyDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarItem {
  final IconData inactiveIcon;
  final IconData activeIcon;
  final String label;

  const BottomBarItem(this.inactiveIcon, this.activeIcon, this.label);
}
