import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/features/user_management/data/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/booking.dart';

part 'booking_repository.g.dart';

class BookingRepository {
  BookingRepository(this._db);
  final FirebaseFirestore _db;

  Future<void> saveBooking({required Booking booking}) async {
    final ref = _db.collection('bookings').doc();
    await ref.set({...booking.toMap(), 'id': ref.id});
  }

  Stream<List<Booking>> loadUserBookings(String userId) {
    return _db
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Booking.fromMap(doc.data());
          }).toList();
        });
  }

  Stream<List<Booking>> loadDoctorBookings(String doctorId) {
    return _db
        .collection('bookings')
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Booking.fromMap(doc.data());
          }).toList();
        });
  }
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  final db = ref.watch(firebaseFirestoreProvider);
  return BookingRepository(db);
}

@Riverpod(keepAlive: true)
Stream<List<Booking>> loadUserBookings(Ref ref, String userId) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.loadUserBookings(userId);
}

@Riverpod(keepAlive: true)
Stream<List<Booking>> loadDoctorBookings(Ref ref, String doctorId) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.loadDoctorBookings(doctorId);
}
