import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';
import 'package:flutter_tdd/infrastructures/firestore/player_repository_impl.dart';
import 'package:hooks_riverpod/all.dart';

final playerRepositoryProvider = Provider<PlayerRepository>((_) {
  final firestore = FirebaseFirestore.instance;
  final dataSource = DocumentDataSourceImpl(firestore);
  return PlayerRepositoryImpl(dataSource, firestore);
});

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
