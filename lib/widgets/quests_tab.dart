import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest_data.dart';
import 'add_quest_dialog.dart';
import 'quest_tile.dart';

class QuestsTab extends StatelessWidget {
  const QuestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestData>(
      builder: (context, questData, child) {
        return Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: questData.progressPercentage,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(questData.progressPercentage * 100).toStringAsFixed(0)}% Complete',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Chapters unlocked: ${questData.unlockedChaptersCount}/${questData.chapters.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Quests list
            Expanded(
              child: questData.quests.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.fact_check_outlined, size: 70, color: Colors.grey),
                          SizedBox(height: 20),
                          Text(
                            'Your quest log is empty!',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Add a quest to begin your adventure.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: questData.quests.length,
                      itemBuilder: (context, index) {
                        final quest = questData.quests[index];
                        return QuestTile(quest: quest);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
