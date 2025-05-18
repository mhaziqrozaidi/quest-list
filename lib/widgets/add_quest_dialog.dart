import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest_data.dart';

class AddQuestDialog extends StatefulWidget {
  const AddQuestDialog({Key? key}) : super(key: key);

  @override
  State<AddQuestDialog> createState() => _AddQuestDialogState();
}

class _AddQuestDialogState extends State<AddQuestDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Quest'),
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
              Provider.of<QuestData>(context, listen: false).addQuest(
                titleController.text,
                descriptionController.text,
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a quest title'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text('ADD QUEST'),
        ),
      ],
    );
  }
}
