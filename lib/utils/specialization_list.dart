import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _specialization = ['Eyes', "Ears", "Nose", "Limbs", "Teeth"];

final specialityIcon = {
  'Eyes': Icons.remove_red_eye,
  'Ears': Icons.hearing,
  'Nose': Icons.face,
  'Limbs': Icons.accessibility_new,
  'Teeth': Icons.mood_outlined,
};

final specializationListProvider = Provider<List<String>>((ref) {
  return _specialization;
});
