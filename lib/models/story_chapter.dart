class StoryChapter {
  final int id;
  final String title;
  final String content;
  bool isUnlocked;

  StoryChapter({
    required this.id,
    required this.title,
    required this.content,
    this.isUnlocked = false,
  });
}
