import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flamingo/flamingo.dart';
import 'package:meta/meta.dart';

abstract class DocumentDataSource {
  Future<void> save(
    String collectionPath, {
    String id,
    @required Map<String, dynamic> data,
  });
  Future<DocumentSnapshot> get(
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
  Future<void> save(
    String collectionPath, {
    String id,
    @required Map<String, dynamic> data,
  }) =>
      _firestore.collection(collectionPath).doc(id).set(
            data,
            SetOptions(merge: true),
          );

  @override
  Future<DocumentSnapshot> get(
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
