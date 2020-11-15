import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo/flamingo.dart';
import 'package:meta/meta.dart';

abstract class DocumentDataSource {
  Future<String> save(
    String collectionPath, {
    String id,
    @required Map<String, dynamic> data,
  });
  Future<DocumentSnapshot> load(
    String collectionPath,
    String id, {
    Source source = Source.serverAndCache,
  });
  Future<void> remove(
    String collectionPath,
    String id,
  );
}

class DocumentDataSourceImpl implements DocumentDataSource {
  DocumentDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<String> save(
    String collectionPath, {
    String id,
    @required Map<String, dynamic> data,
  }) async {
    final doc = _firestore.collection(collectionPath).doc(id);
    await doc.set(
      <String, dynamic>{...data, 'id': doc.id},
      SetOptions(merge: true),
    );
    return doc.id;
  }

  @override
  Future<DocumentSnapshot> load(
    String collectionPath,
    String id, {
    Source source = Source.serverAndCache,
  }) =>
      _firestore
          .collection(collectionPath)
          .doc(id)
          .get(GetOptions(source: source));

  @override
  Future<void> remove(
    String collectionPath,
    String id,
  ) =>
      _firestore.collection(collectionPath).doc(id).delete();
}
