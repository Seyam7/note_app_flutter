class NoteModel{
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel ({
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });
}