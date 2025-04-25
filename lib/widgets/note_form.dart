import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteForm extends StatefulWidget {
  final int nextId;
  final Function(Note) onSave;

  const NoteForm({Key? key, required this.nextId, required this.onSave})
    : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Vui lòng nhập tiêu đề'
                        : null,
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Tiêu đề',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Vui lòng nhập nội dung'
                        : null,
            controller: _contentController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Nội dung',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newNote = Note(
                  id: widget.nextId + 1,
                  title: _titleController.text,
                  content: _contentController.text,
                );
                widget.onSave(newNote);
                _titleController.clear();
                _contentController.clear();
              }
            },
            child: const Text("Lưu"),
          ),
        ],
      ),
    );
  }
}
