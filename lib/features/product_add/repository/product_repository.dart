import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/core/constants/firebaseconstants.dart';
import '../../../core/providers/firebase_provider.dart';
import '../../../model/product_model.dart';

final streamProvider = StreamProvider((ref) {
  return FirebaseFirestore.instance.collection(Firebaseconstants.productCollections).snapshots();
});


final productRepositoryProvider = StateProvider(
        (ref) => ProductAddRepository(firestore: ref.read(firestoreProvider)));

class ProductAddRepository {
  final FirebaseFirestore _firestore;
  ProductAddRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  void add(Productmodel data) {
    _firestore
        .collection(Firebaseconstants.productCollections)
        .add(data.toJson())
        .then((value) => value.update({'id': value.id}));
  }

  // void delete({required Productmodel deleteItem}){
  //   _firestore.doc(deleteItem.id).delete();
  // }



}