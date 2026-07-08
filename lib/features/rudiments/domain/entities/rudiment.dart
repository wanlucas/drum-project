import 'rudiment_pattern.dart';

class Rudiment {
  const Rudiment({
    required this.number,
    required this.name,
    required this.description,
    required this.category,
    this.pattern,
  });

  final int number;
  final String name;
  final String description;
  final String category;
  final RudimentPattern? pattern;
}
