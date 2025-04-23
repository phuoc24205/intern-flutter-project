import 'package:flutter/material.dart';

class Note {
  final int id;
  final String title;
  final String content;
  Note({required this.id, required this.title, required this.content});
}

void main() {
  runApp(const NoteApp());
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
  int _nextId = 0;
  final List<Note> notes = [
    Note(id: 1, title: 'Note 1', content: 'Nội dung của note 1'),
    Note(id: 2, title: 'Note 2', content: 'Nội dung của note 2'),
    Note(id: 3, title: 'Note 3', content: 'Nội dung của note 3'),
    Note(id: 4, title: 'Note 4', content: 'Nội dung của note 4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            // Bọc toàn bộ widget để cuộn
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
                          onPressed: null,
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
