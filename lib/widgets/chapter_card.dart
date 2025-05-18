import 'package:flutter/material.dart';
import '../models/story_chapter.dart';

class ChapterCard extends StatelessWidget {
  final StoryChapter chapter;

  const ChapterCard({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: chapter.isUnlocked 
              ? Theme.of(context).primaryColor 
              : Colors.grey[300]!,
          width: 2.0,
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: chapter.isUnlocked,
        childrenPadding: const EdgeInsets.all(16.0),
        backgroundColor: chapter.isUnlocked ? Colors.white : Colors.grey[100],
        leading: Icon(
          chapter.isUnlocked ? Icons.book : Icons.lock,
          color: chapter.isUnlocked 
              ? Theme.of(context).primaryColor 
              : Colors.grey,
        ),
        title: Text(
          chapter.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: chapter.isUnlocked ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          chapter.isUnlocked 
              ? 'Chapter ${chapter.id + 1}' 
              : 'Complete more quests to unlock',
          style: TextStyle(
            color: chapter.isUnlocked ? Colors.black54 : Colors.grey,
          ),
        ),
        children: chapter.isUnlocked 
            ? [
                Text(
                  chapter.content,
                  style: const TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
