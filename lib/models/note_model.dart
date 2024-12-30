class NoteModel{
  final String titel;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel ({
    required this.titel,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });
}