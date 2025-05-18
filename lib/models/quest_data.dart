import 'package:flutter/foundation.dart';
import 'quest.dart';
import 'story_chapter.dart';

class QuestData extends ChangeNotifier {
  final List<Quest> _quests = [];
  final List<StoryChapter> _chapters = [
    StoryChapter(
      id: 0,
      title: 'The Beginning',
      content: 'You find yourself standing at the edge of a mysterious forest. '
          'Legends speak of great adventures awaiting those brave enough to enter...',
      isUnlocked: true,
    ),
    StoryChapter(
      id: 1,
      title: 'The Forest Path',
      content: 'As you venture deeper into the forest, you discover an ancient path. '
          'The trees whisper secrets of the past, guiding your journey forward...',
      isUnlocked: false,
    ),
    StoryChapter(
      id: 2,
      title: 'The Hidden Cave',
      content: 'Beyond a curtain of vines, you discover the entrance to a cave. '
          'Strange glowing symbols adorn the walls, and a cool breeze beckons you further in...',
      isUnlocked: false,
    ),
    StoryChapter(
      id: 3,
      title: 'The Ancient Guardian',
      content: 'Deep within the cave stands a stone guardian. Its eyes glow with ancient magic '
          'as it poses a riddle that will test your wisdom and courage...',
      isUnlocked: false,
    ),
    StoryChapter(
      id: 4,
      title: 'The Sacred Treasure',
      content: 'Having proven your worth, the guardian steps aside revealing a chamber filled with '
          'light. In the center rests an artifact of immense power, waiting for a worthy hero...',
      isUnlocked: false,
    ),
  ];

  // Getters
  List<Quest> get quests => _quests;
  List<StoryChapter> get chapters => _chapters;
  int get completedQuestsCount => _quests.where((quest) => quest.isComplete).length;
  double get progressPercentage => _quests.isEmpty 
      ? 0 
      : completedQuestsCount / _quests.length;
  int get unlockedChaptersCount => _chapters.where((chapter) => chapter.isUnlocked).length;

  // Methods
  void addQuest(String title, String description) {
    _quests.add(Quest(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
    ));
    notifyListeners();
  }

  void toggleQuestComplete(int id) {
    final questIndex = _quests.indexWhere((quest) => quest.id == id);
    if (questIndex != -1) {
      _quests[questIndex].toggleComplete();
      
      // Unlock a new chapter if available
      final completedCount = completedQuestsCount;
      if (completedCount > 0 && completedCount <= _chapters.length - 1) {
        _chapters[completedCount].isUnlocked = true;
      }
      
      notifyListeners();
    }
  }

  void deleteQuest(int id) {
    _quests.removeWhere((quest) => quest.id == id);
    notifyListeners();
  }

  // New method for editing quests
  void editQuest(int id, String newTitle, String newDescription) {
    final questIndex = _quests.indexWhere((quest) => quest.id == id);
    if (questIndex != -1) {
      _quests[questIndex].title = newTitle;
      _quests[questIndex].description = newDescription;
      notifyListeners();
    }
  }

  // Get a quest by ID
  Quest? getQuestById(int id) {
    try {
      return _quests.firstWhere((quest) => quest.id == id);
    } catch (e) {
      return null;
    }
  }
}
