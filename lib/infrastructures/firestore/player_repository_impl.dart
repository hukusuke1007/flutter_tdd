import 'package:flamingo/flamingo.dart';
import 'package:flutter_tdd/domain/repositories/player_repository.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  PlayerRepositoryImpl(this._documentDataSource, this._firestore);

  final DocumentDataSource _documentDataSource;
  final FirebaseFirestore _firestore;

  @override
  Future<void> save(Player player) => _documentDataSource.save(
        Player.collectionPath,
        data: player.toJson(),
      );

  @override
  Future<Player> get(String id) async {
    final snapshot = await _documentDataSource.get(Player.collectionPath, id);
    if (!snapshot.exists) {
      return null;
    }
    return Player.fromJson(<String, dynamic>{
      id: snapshot.id,
      ...snapshot.data(),
    });
  }

  @override
  Future<void> remove(String id) =>
      _documentDataSource.remove(Player.collectionPath, id);

  @override
  Future<void> saveAll(List<Player> players) async {
    final batch = _firestore.batch();
    for (final item in players) {
      batch.set(
        _firestore.doc(item.documentPath),
        item.toJson(),
        SetOptions(merge: true),
      );
    }
    await batch.commit();
  }
}
