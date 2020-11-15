import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';

abstract class PlayerRepository {
  Future<String> save(Player player);
  Future<void> update(String id, Player player);
  Future<Player> load(String id);
  Future<void> remove(String id);
  Future<void> saveAll(List<Player> players);
  Future<List<Player>> loadAll({
    int limit = 20,
    String order = 'createdAt',
    bool desc = true,
    Source source = Source.serverAndCache,
    DocumentSnapshot startAfterDocument,
  });
  Future<void> removeAll();
}
