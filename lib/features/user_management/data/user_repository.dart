import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/authentication/domain/doctor_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authentication/domain/app_user.dart';

part 'user_repository.g.dart';

class UserRepository {
  UserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<AppUser> loadUserInformation(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (!snapshot.exists) {
        throw Exception('User not found');
      }

      final data = snapshot.data()!;
      if (data['type'] == 'doctor') {
        return DoctorUser.fromMap(data);
      } else {
        return AppUser.fromMap(data);
      }
    });
  }

  Stream<List<DoctorUser>> loadDoctor(String speciality) {
    Query query = _firestore
        .collection('users')
        .where('type', isEqualTo: 'doctor');

    if (speciality.isNotEmpty) {
      query = query.where('speciality', isEqualTo: speciality);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DoctorUser.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
UserRepository userRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return UserRepository(firestore);
}

@riverpod
Stream<AppUser> loadUserInformation(Ref ref, String userId) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.loadUserInformation(userId);
}

@riverpod
Stream<List<DoctorUser>> loadDoctor(Ref ref, String speciality) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.loadDoctor(speciality);
}
