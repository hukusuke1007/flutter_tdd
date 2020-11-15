import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';

abstract class PlayerRepository {
  Future<void> save(Player player);
  Future<Player> get(String id);
  Future<void> remove(String id);
  Future<void> saveAll(List<Player> players);
}
