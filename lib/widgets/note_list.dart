import 'package:app/screens/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteList extends StatelessWidget {
  final Function(int id) onDelete;

  const NoteList({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(note.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(note: note),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () => onDelete(note.id),
              icon: const Icon(Icons.delete),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 6,
            ),
            tileColor: Colors.deepPurple.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
