import 'package:hive_ce/hive.dart';

part 'desire.g.dart';

@HiveType(typeId: 0)
class Desire extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String status;

  @HiveField(4)
  List<String> category;

  @HiveField(5)
  String? imageUrl;

  @HiveField(6)
  DateTime createdAt;

  Desire({
    this.id, // при создании null
    required this.title,
    required this.description,
    this.status = 'идея',
    List<String>? category,
    this.imageUrl,
    DateTime? createdAt,
  }) : category = category ?? ['Общее'],
       createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'category': category,
    'imageUrl': imageUrl,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Desire.fromJson(Map<String, dynamic> json) => Desire(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    category: json['category'],
    imageUrl: json['imageUrl'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
