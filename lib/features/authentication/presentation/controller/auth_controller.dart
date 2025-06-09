import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = AsyncError("Ensure all details are filled.", StackTrace.current);
    }
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(email, password);
    });
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File? imageUrl,
    required String location,
    required double? latitude,
    required double? longitude,
    required String type,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        location.trim().isEmpty ||
        latitude == null ||
        longitude == null ||
        type.trim().isEmpty) {
      state = AsyncError("Ensure all details are filled.", StackTrace.current);
    }

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        location: location,
        latitude: latitude!,
        longitude: longitude!,
        type: type,
      );
    });
  }

  Future<void> createDoctorUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File? imageUrl,
    required String location,
    required double? latitude,
    required double? longitude,
    required String type,
    required String specialization,
    required String description,
    int yearsOfExperience = 1,
    int rating = 1,
    int numberOfReviews = 0,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        location.trim().isEmpty ||
        specialization.isEmpty ||
        description.trim().isEmpty ||
        latitude == null ||
        longitude == null ||
        type.trim().isEmpty) {
      state = AsyncError("Ensure all details are filled.", StackTrace.current);
    }

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.createDoctorUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        location: location,
        latitude: latitude!,
        longitude: longitude!,
        type: type,
        specialization: specialization,
        description: description,
        yearsOfExperience: yearsOfExperience,
        rating: rating,
        numberOfReviews: numberOfReviews,
      );
    });
  }
}
