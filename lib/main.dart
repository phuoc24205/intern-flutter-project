import 'package:app/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Note {
  final int id;
  final String title;
  final String content;
  Note({required this.id, required this.title, required this.content});
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: NoteApp(),
    ),
  );
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Note App', home: const NoteHome());
  }
}

class NoteHome extends StatefulWidget {
  const NoteHome({Key? key}) : super(key: key);

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  final TextEditingController _controller = TextEditingController();
  String? _message;
  int nextId = 0;
  void _showMessage(String msg) {
    setState(() {
      _message = msg;
    });
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
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Nhập ghi chú',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_message != null)
                  Container(
                    width: double.infinity,
                    color: Colors.greenAccent,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _message!,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final newNote = Note(
                        id: nextId + 1,
                        title: _controller.text,
                        content: '',
                      );
                      noteProvider.addNote(newNote);
                      nextId++;
                      _controller.clear();
                      _showMessage("Thêm ghi chú thành công");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      elevation: 4,
                    ),
                    child: const Text(
                      "Thêm ghi chú",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(notes[index].title),
                        trailing: IconButton(
                          onPressed: () {
                            noteProvider.removeNote(notes[index].id);
                            _showMessage("Xóa ghi chú thành công");
                          },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
