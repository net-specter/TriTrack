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
    BottomBarItem(
      inactiveIcon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    BottomBarItem(
      inactiveIcon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'Participants',
    ),
    BottomBarItem(
      inactiveIcon: Icons.note_add_outlined,
      activeIcon: Icons.note_add,
      label: 'Input BIB',
    ),
    BottomBarItem(
      inactiveIcon: Icons.leaderboard_outlined,
      activeIcon: Icons.leaderboard,
      label: 'Leaderboard',
    ),
    // BottomBarItem(
    //   inactiveIcon: Icons.notifications_outlined,
    //   activeIcon: Icons.notifications,
    //   label: 'Notification',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
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
          item.onTap?.call(); // Call the item's onTap if provided
        },
        // ignore: deprecated_member_use
        splashColor: TriColors.primary.withOpacity(0.2),
        // ignore: deprecated_member_use
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
  final void Function()? onTap;

  const BottomBarItem({
    required this.inactiveIcon,
    required this.activeIcon,
    required this.label,
    this.onTap,
  });
}
