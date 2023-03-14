
import 'dart:ui';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final Color backgroundColor;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    this.isAllDay= false,
    required this.to,
    required this.backgroundColor,
  });
}