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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  int nextId = 0;
  bool _showForm = false;
  String? _message;
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
                if (_showForm)
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tiêu đề';
                            }
                            return null;
                          },
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Tiêu đề',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập nội dung';
                            }
                            return null;
                          },
                          controller: _contentController,
                          maxLines: 5,
                          decoration: InputDecoration(
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
                                id: nextId + 1,
                                title: _titleController.text,
                                content: _contentController.text,
                              );
                              noteProvider.addNote(newNote);
                              _titleController.clear();
                              _contentController.clear();
                              _showMessage("Thêm ghi chú thành công");
                              nextId++;
                              setState(() {
                                _showForm = false; // ẩn lại form
                              });
                            }
                          },
                          child: const Text("Lưu"),
                        ),
                      ],
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
