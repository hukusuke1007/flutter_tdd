import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tdd/domain/repositories/player_repository.dart';
import 'package:flutter_tdd/infrastructures/firestore/document_data_source.dart';
import 'package:flutter_tdd/infrastructures/firestore/entities/index.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  PlayerRepositoryImpl(this._documentDataSource, this._firestore);

  final DocumentDataSource _documentDataSource;
  final FirebaseFirestore _firestore;

  @override
  Future<String> save(Player player) => _documentDataSource.save(
        Player.collectionPath,
        data: <String, dynamic>{
          ...player.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

  @override
  Future<void> update(Player player) async {
    await _documentDataSource
        .save(Player.collectionPath, data: <String, dynamic>{
      ...player.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<Player> load(String id) async {
    final snapshot = await _documentDataSource.load(Player.collectionPath, id);
    if (!snapshot.exists) {
      return null;
    }
    return Player.fromJson(<String, dynamic>{
      ...snapshot.data(),
      'id': snapshot.id,
    });
  }

  @override
  Future<void> remove(String id) =>
      _documentDataSource.remove(Player.collectionPath, id);

  @override
  Future<void> saveAll(List<Player> players) async {
    final batch = _firestore.batch();
    for (final item in players) {
      final doc = _firestore.collection(Player.collectionPath).doc(item.id);
      batch.set(
        doc,
        <String, dynamic>{
          ...item.toJson(),
          'id': doc.id,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Player>> loadAll({
    int limit = 20,
    String order = 'createdAt',
    bool desc = true,
    Source source = Source.serverAndCache,
    DocumentSnapshot startAfterDocument,
  }) async {
    var query = _firestore
        .collection(Player.collectionPath)
        .limit(limit)
        .orderBy(order, descending: desc);
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }
    final snapshot = await query.get(GetOptions(source: source));
    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs
        .map((e) => Player.fromJson(<String, dynamic>{...e.data(), 'id': e.id}))
        .toList();
  }
}
