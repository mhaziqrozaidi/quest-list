class Quest {
  final int id;
  final String title;
  final String description;
  bool isComplete;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    this.isComplete = false,
  });

  void toggleComplete() {
    isComplete = !isComplete;
  }
}
