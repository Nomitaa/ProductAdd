import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/core/constants/firebaseconstants.dart';
import 'package:newpro/model/product_model.dart';

import '../../../core/providers/firebase_provider.dart';


final ProductdisplayRepositoryProvider = StateProvider(
        (ref) => ProductDisplayRepository(firestore: ref.read(firestoreProvider)));

class ProductDisplayRepository{
  final FirebaseFirestore _firestore;
  ProductDisplayRepository ({
    required FirebaseFirestore firestore,

}): _firestore=firestore;

  CollectionReference get _products=>
      _firestore.collection(Firebaseconstants.productCollections);


  Stream<List<Productmodel>>view(){
    final snapshots=_products.where('delete',isEqualTo: false).
    snapshots().map((event) =>event.docs.
    map((e) => Productmodel.fromJson(e.data()as Map<String,dynamic>)).toList());
    return snapshots;
  }

void delete(String productId) {
_products.doc(productId).update({"delete":true});
 }
}