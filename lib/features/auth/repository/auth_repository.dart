import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newpro/core/constants/firebaseconstants.dart';
import 'package:newpro/core/providers/firebase_provider.dart';
import 'package:newpro/model/usermodel.dart';
import '../../../core/failure.dart';
import '../../../core/typedef.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseFirestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(authProvider),
    googleSignIn: ref.read(googlesigninProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firestore = firebaseFirestore,
        _auth = firebaseAuth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(Firebaseconstants.userCollection);


  FutureEither<UserModel> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );


      userCredential =
      await _auth.signInWithCredential(credential);


      UserModel usermodel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        usermodel = UserModel(
            name: userCredential.user!.displayName ?? 'No Name',
            createdtime: DateTime.now(),
            id: userCredential.user!.uid);
        await _users.doc(userCredential.user!.uid).set(usermodel.tojson());
      } else {
        usermodel = await getUserData(userCredential.user!.uid).first;
        _users
            .doc(userCredential.user!.uid)
            .update({'logintime': DateTime.now()});
      }
      return right(usermodel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }


  // Future<UserModel> sigInwithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final googleAuth = await googleUser?.authentication;
  //     final Credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(Credential);
  //     late UserModel userModel;
  //     if (userCredential.additionalUserInfo!.isNewUser) {
  //       userModel = UserModel(
  //           name: userCredential.user!.displayName ?? 'No Name',
  //           createdtime: DateTime.now(),
  //           id: userCredential.user!.uid);
  //       await _users.doc(userCredential.user!.uid).set(userModel.tojson());
  //     } else {
  //       _users
  //           .doc(userCredential.user!.uid)
  //           .update({'logintime': DateTime.now()});
  //     }
  //     return userModel;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }


  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.fromjson(event.data() as Map<String, dynamic>));
  }
}
