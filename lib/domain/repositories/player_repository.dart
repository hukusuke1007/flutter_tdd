import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';

abstract class PlayerRepository {
  Future<String> save(Player player);
  Future<void> update(Player player);
  Future<Player> get(String id);
  Future<void> remove(String id);
  Future<void> saveAll(List<Player> players);
  Future<List<Player>> getAll({
    int limit = 20,
    String order = 'createdAt',
    bool desc = true,
    Source source = Source.serverAndCache,
  });
}
