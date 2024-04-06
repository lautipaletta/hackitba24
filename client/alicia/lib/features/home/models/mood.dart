import 'dart:ui';

enum Mood {
  HAPPY("Feliz", Color (0xFFECA927)),
  ANGRY("Enojado", Color(0xFFFF1F11)),
  ANXIOUS("Ansioso", Color(0xFF3686FF)),
  SAD("Triste", Color(0xFFFF5C00)),
  CALM("Calmo", Color(0xFF2411FF));

  final String label;
  final Color color;
  const Mood(this.label, this.color);
}
