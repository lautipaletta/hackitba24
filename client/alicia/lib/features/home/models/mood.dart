import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

enum Mood {
  @JsonEnum(valueField: 'label')
  HAPPY("feliz", Color (0xFFECA927)),
  ANGRY("enojado", Color(0xFFFF1F11)),
  ANXIOUS("ansioso", Color(0xFF3686FF)),
  SAD("triste", Color(0xFFFF5C00)),
  CALM("calmo", Color(0xFF2411FF));

  final String label;
  final Color color;
  const Mood(this.label, this.color);
}
