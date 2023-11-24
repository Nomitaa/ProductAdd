import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/core/constants/firebaseconstants.dart';
import '../../../core/providers/firebase_provider.dart';
import '../../../model/product_model.dart';

final editRepositoryProvider = StateProvider(
        (ref) => EditRepository(firestore: ref.read(firestoreProvider)));

class EditRepository {
  final FirebaseFirestore _firestore;
  EditRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(Firebaseconstants.productCollections);

  Future<void> updateData(Productmodel product) async {
    await _products.doc(product.id).update(product.toJson());
  }
}