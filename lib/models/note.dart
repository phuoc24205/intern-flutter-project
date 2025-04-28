class Note {
  final int id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
  };

  factory Note.fromMap(Map<String, dynamic> map) =>
      Note(id: map["id"], title: map["title"], content: map["content"]);
}
