import 'package:flutter/material.dart';
import '../widgets/quests_tab.dart';
import '../widgets/story_tab.dart';
import '../widgets/add_quest_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _tabs = [
    const QuestsTab(),
    const StoryTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuestList'),
        elevation: 0,
      ),
      body: _tabs[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddQuestDialog(),
                );
              },
              child: const Icon(Icons.add),
              tooltip: 'Add new quest',
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Quests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Story',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
