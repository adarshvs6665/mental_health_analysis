class Question {
  final String id;
  final String question;
  final List<String> options;
  final List<int> score;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.score,
  });
}
