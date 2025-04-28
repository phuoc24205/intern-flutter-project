import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_form.dart';
import '../widgets/note_list.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({Key? key}) : super(key: key);

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  int nextId = 0;
  bool _showForm = false;
  String? _message;

  void _showMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<NoteProvider>(context, listen: false).loadNotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_showForm)
                  NoteForm(
                    nextId: nextId,
                    onSave: (newNote) {
                      noteProvider.addNote(newNote);
                      setState(() {
                        nextId++;
                        _showForm = false;
                      });
                      _showMessage("Thêm ghi chú thành công");
                    },
                  ),
                const SizedBox(height: 16),
                if (_message != null)
                  Container(
                    width: double.infinity,
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _message!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showForm = !_showForm;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      elevation: 4,
                    ),
                    child: Text(
                      _showForm ? "Đóng form" : "Thêm ghi chú",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                NoteList(
                  onDelete: (id) {
                    noteProvider.removeNote(id);
                    _showMessage("Xóa ghi chú thành công");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
