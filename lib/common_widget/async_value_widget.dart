import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) onData;
  final Widget Function(Object error)? onError;
  final Widget? onLoading;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.onData,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: onData,
      error: (error, stackTrace) =>
          onError?.call(error) ?? Text('Error: $error'),
      loading: () => onLoading ?? const CircularProgressIndicator(),
    );
  }
}
