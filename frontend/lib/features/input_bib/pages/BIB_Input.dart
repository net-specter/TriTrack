import 'package:flutter/material.dart';

class BIBInputPage extends StatefulWidget {
  const BIBInputPage({super.key});

  @override
  State<BIBInputPage> createState() => _BIBInputPageState();
}

class _BIBInputPageState extends State<BIBInputPage> {
  String selectedActivity = 'Swimming';
  bool showCardMode = false;
  final TextEditingController _bibController = TextEditingController();
  
  final Map<String, List<Map<String, dynamic>>> participants = {
    'Swimming': [
      {'bib': '101', 'name': 'ABC', 'time': '00:30:25'},
      {'bib': '102', 'name': 'ABC', 'time': '00:31:40'},
    ],
    'Cycling': [
      {'bib': '201', 'name': 'ABC', 'time': '01:15:30'},
    ],
    'Running': [
      {'bib': '301', 'name': 'ABC', 'time': '00:45:15'},
      {'bib': '302', 'name': 'ABC', 'time': '00:47:22'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Timer Display
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                '00:40:25:00',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,),
              ),
            ),
          ),

          // Activity Tabs with Icons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActivityTab('Swimming', Icons.pool, selectedActivity == 'Swimming'),
                const SizedBox(width: 8),
                _buildActivityTab('Cycling', Icons.directions_bike, selectedActivity == 'Cycling'),
                const SizedBox(width: 8),
                _buildActivityTab('Running', Icons.directions_run, selectedActivity == 'Running'),
              ],
            ),
          ),

          // Toggle Buttons (Cards/Keypad)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical:16.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF4E61F6)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton('Cards', showCardMode),
                      _buildToggleButton('Keypad', !showCardMode),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Input Section (always visible)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF9DB2CE)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _bibController,
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
          ),

          // Content Area - Shows leaderboard or card screen text
          Expanded(
            child: showCardMode 
                ? Center(
                    child: Text(
                      'CARD SCREEN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E61F6),
                      ),
                    ),
                  )
                : _buildLeaderboard(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(flex: 2, child: Text('BIB', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('NAME', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('TIME', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(height: 4),
          
          // Participants list
          Expanded(
            child: ListView.builder(
              itemCount: participants[selectedActivity]!.length,
              itemBuilder: (context, index) {
                final p = participants[selectedActivity]![index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(p['bib'])),
                      Expanded(flex: 3, child: const Text('ABC')),
                      Expanded(flex: 2, child: Text(p['time'])),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.refresh, size: 20, color: Color(0xFF4E61F6)),
                          onPressed: () => _refreshTime(index),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedActivity = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E61F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: const Color(0xFF4E61F6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : const Color(0xFF4E61F6),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF4E61F6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => showCardMode = label == 'Cards'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E61F6) : Colors.transparent,
          borderRadius: label == 'Cards' 
              ? const BorderRadius.horizontal(left: Radius.circular(6))
              : const BorderRadius.horizontal(right: Radius.circular(6)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4E61F6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _addParticipant() {
    final bib = _bibController.text.trim();
    if (bib.isEmpty) return;

    setState(() {
      participants[selectedActivity]!.insert(0, {
        'bib': bib,
        'name': 'ABC',
        'time': _formatTime(DateTime.now()),
      });
      _bibController.clear();
    });
  }

  void _refreshTime(int index) {
    setState(() {
      participants[selectedActivity]![index]['time'] = _formatTime(DateTime.now());
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
}