import 'dart:async';

import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) {
        notifyListeners();
      },
      onError: (error) {
        if (kDebugMode) {
          print('Error in GoRouterRefreshStream: $error');
        }
      },
    );
  }
  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
