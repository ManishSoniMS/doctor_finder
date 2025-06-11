import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecializationProvider extends StateNotifier<String> {
  SpecializationProvider() : super('');

  void setSpecialization(String specialization) {
    state = specialization;
  }
}

final specializationNotifierProvider =
    StateNotifierProvider<SpecializationProvider, String>(
      (ref) => SpecializationProvider(),
    );
