import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../models/quest_data.dart';

class EditQuestDialog extends StatefulWidget {
  final int questId;

  const EditQuestDialog({Key? key, required this.questId}) : super(key: key);

  @override
  State<EditQuestDialog> createState() => _EditQuestDialogState();
}

class _EditQuestDialogState extends State<EditQuestDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Load current quest data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questData = Provider.of<QuestData>(context, listen: false);
      final quest = questData.getQuestById(widget.questId);
      
      if (quest != null) {
        titleController.text = quest.title;
        descriptionController.text = quest.description;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Quest'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Quest Title',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Quest Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty) {
              Provider.of<QuestData>(context, listen: false).editQuest(
                widget.questId,
                titleController.text,
                descriptionController.text,
              );
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Quest updated successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a quest title'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text('SAVE CHANGES'),
        ),
      ],
    );
  }
}
