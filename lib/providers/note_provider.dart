import 'package:flutter/material.dart';
import 'package:app/models/note.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;
  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(int id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
