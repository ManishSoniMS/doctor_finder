import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _specialization = ['Eyes', "Ears", "Nose", "Limbs", "Teeth"];

final specializationListProvider = Provider<List<String>>((ref) {
  return _specialization;
});
