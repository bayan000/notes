import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/note_controller.dart';

class AddNoteDialog extends StatelessWidget {
  final NotesController notesController = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _discriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Note'),
      content: TextField(
        controller: _discriptionController,
        decoration: const InputDecoration(hintText: 'Enter note'),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            notesController.addNote(_discriptionController.text);
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
class EditNoteDialog extends StatelessWidget {
  final NotesController notesController = Get.find<NotesController>();
  final String id;

  EditNoteDialog({required this.id});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _discriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('Edit Note'),
      content: TextField(
        controller: _discriptionController,
        decoration: const InputDecoration(hintText: 'Enter note'),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            notesController.updateNote(id,_discriptionController.text);
            Get.toNamed('/edit-note');        },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}


