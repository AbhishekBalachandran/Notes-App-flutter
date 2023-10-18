import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  Color color;
  NoteModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.color});
}


