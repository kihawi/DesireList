import 'package:flutter_projects/models/desire.dart';
import 'package:hive_ce/hive.dart';

class DesireRepository {
  static const String boxName = 'desiresBox';

  Future<Box> _openBox() async {
    return await Hive.openBox<Desire>(boxName);
  }

  Future<List<Desire>> getAllDesires() async {
    final box = await _openBox();
    return box.values.cast<Desire>().toList();
  }

  Future<void> addDesire(Desire desire) async {
    final box = await _openBox();
    final key = await box.add(desire);
    box.put(key, desire);
  }

  Future<void> deleteDesire(int key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  Future<void> updateDesire(int key, Desire desire) async {
    final box = await _openBox();
    await box.put(key, desire);
  }
}
