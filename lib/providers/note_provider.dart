import 'package:app/services/note_storage.dart';
import 'package:flutter/material.dart';
import 'package:app/models/note.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;
  Future<void> loadNotes() async {
    final loadedNotes = await NoteStorage.loadNotes();
    _notes.clear();
    _notes.addAll(loadedNotes);
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    NoteStorage.saveNotes(_notes);
    notifyListeners();
  }

  void removeNote(int id) {
    _notes.removeWhere((note) => note.id == id);
    NoteStorage.saveNotes(_notes);
    notifyListeners();
  }
}
