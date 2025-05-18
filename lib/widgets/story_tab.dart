import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest_data.dart';
import 'chapter_card.dart';

class StoryTab extends StatelessWidget {
  const StoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestData>(
      builder: (context, questData, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: questData.chapters.length,
          itemBuilder: (context, index) {
            final chapter = questData.chapters[index];
            return ChapterCard(chapter: chapter);
          },
        );
      },
    );
  }
}
