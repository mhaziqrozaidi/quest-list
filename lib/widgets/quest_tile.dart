import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../models/quest_data.dart';
import 'edit_quest_dialog.dart';

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
      confirmDismiss: (direction) async {
        // Show confirmation dialog before deleting
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete Quest"),
              content: Text("Are you sure you want to remove '${quest.title}' from your quest log?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    "DELETE", 
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<QuestData>(context, listen: false).deleteQuest(quest.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${quest.title} removed from your quest log'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                Provider.of<QuestData>(context, listen: false)
                    .addQuest(quest.title, quest.description);
              },
            ),
          ),
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quest.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  decoration: quest.isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    tooltip: 'Edit Quest',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditQuestDialog(questId: quest.id),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    tooltip: 'Delete Quest',
                    onPressed: () async {
                      bool? delete = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Quest"),
                            content: Text("Are you sure you want to remove '${quest.title}' from your quest log?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text(
                                  "DELETE", 
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (delete == true) {
                        Provider.of<QuestData>(context, listen: false)
                            .deleteQuest(quest.id);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${quest.title} removed from your quest log'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                Provider.of<QuestData>(context, listen: false)
                                    .addQuest(quest.title, quest.description);
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
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
