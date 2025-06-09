import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepository(firebaseAuth);
}

@Riverpod(keepAlive: true)
Stream<User?> authStatusChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStatusChanges();
}

@riverpod
User? currentUser(Ref ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}

@riverpod
void signOut(Ref ref) {
  ref.watch(authRepositoryProvider).signOut();
}

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File? imageUrl,
    required String location,
    required double latitude,
    required double longitude,

    required String type,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (imageUrl != null) {
      final extension = imageUrl.path.split('.').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${cred.user!.uid}-${DateTime.now()}.$extension');

      await storageRef.putFile(imageUrl);
      final imageUrlString = await storageRef.getDownloadURL();

      await cred.user!.updateProfile(
        displayName: name,
        photoURL: imageUrlString,
      );
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({
          'email': email,
          'name': name,
          'phoneNumber': phoneNumber,
          'imageUrl': cred.user?.photoURL,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          'userId': cred.user!.uid,
          'type': type,
        });
  }

  Future<void> createDoctorUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File? imageUrl,
    required String location,
    required double latitude,
    required double longitude,
    required String type,
    required String specialization,
    required String description,
    required int yearsOfExperience,
    required int rating,
    required int numberOfReviews,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (imageUrl != null) {
      final extension = imageUrl.path.split('.').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${cred.user!.uid}-${DateTime.now()}.$extension');

      await storageRef.putFile(imageUrl);
      final imageUrlString = await storageRef.getDownloadURL();

      await cred.user!.updateProfile(
        displayName: name,
        photoURL: imageUrlString,
      );
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({
          'email': email,
          'name': name,
          'phoneNumber': phoneNumber,
          'imageUrl': cred.user?.photoURL,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          'userId': cred.user!.uid,
          'type': type,
          'specialization': specialization,
          'description': description,
          'yearsOfExperience': yearsOfExperience,
          'rating': rating,
          'numberOfReviews': numberOfReviews,
        });
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  Stream<User?> authStatusChanges() {
    return _auth.authStateChanges();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
