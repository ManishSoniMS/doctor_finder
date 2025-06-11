import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/booking_repository.dart';
import '../../domain/booking.dart';

part 'booking_controller.g.dart';

@riverpod
class BookingController extends _$BookingController {
  @override
  FutureOr<void> build() async {
    return null;
  }

  Future<bool> saveBooking({required Booking booking}) async {
    state = AsyncLoading();
    final bookingRepository = ref.watch(bookingRepositoryProvider);
    state = await AsyncValue.guard(() async {
      return await bookingRepository.saveBooking(booking: booking);
    });

    return !state.hasError;
  }
}
