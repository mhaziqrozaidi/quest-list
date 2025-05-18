import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../models/quest_data.dart';

class QuestTile extends StatelessWidget {
  final Quest quest;

  const QuestTile({Key? key, required this.quest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(quest.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<QuestData>(context, listen: false).deleteQuest(quest.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quest removed from your log')),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        elevation: 2.0,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            quest.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: quest.isComplete ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            quest.description,
            style: TextStyle(
              color: Colors.grey[600],
              decoration: quest.isComplete ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            value: quest.isComplete,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool? newValue) {
              Provider.of<QuestData>(context, listen: false)
                  .toggleQuestComplete(quest.id);
              
              if (newValue == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Quest completed! A new chapter may have been unlocked.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
