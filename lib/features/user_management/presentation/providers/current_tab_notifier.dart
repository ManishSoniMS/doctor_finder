import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentTabNotifier extends StateNotifier<int> {
  CurrentTabNotifier() : super(0);

  void setTab(int newValue) {
    state = newValue;
  }
}

final currentTabNotifierProvider =
    StateNotifierProvider<CurrentTabNotifier, int>(
      (ref) => CurrentTabNotifier(),
    );
