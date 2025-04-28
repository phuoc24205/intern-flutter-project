import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteStorage {
  static const _key = 'notes';
  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final noteJson = notes.map((note) => json.encode(note.toMap())).toList();
    await prefs.setStringList(_key, noteJson);
  }

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final noteJson = prefs.getStringList(_key);
    if (noteJson == null) return [];
    return noteJson.map((s) => Note.fromMap(jsonDecode(s))).toList();
  }
}
