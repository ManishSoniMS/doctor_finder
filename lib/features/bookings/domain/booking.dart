class Booking {
  final String id;
  final String userId;
  final String doctorId;
  final String date;
  final String time;
  final String service;

  const Booking({
    this.id = '',
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.service,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Booking &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          doctorId == other.doctorId &&
          date == other.date &&
          time == other.time &&
          service == other.service);

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      doctorId.hashCode ^
      date.hashCode ^
      time.hashCode ^
      service.hashCode;

  @override
  String toString() =>
      'Booking{'
      ' id: $id,'
      ' userId: $userId,'
      ' doctorId: $doctorId,'
      ' date: $date,'
      ' time: $time,'
      ' service: $service,'
      '}';

  Booking copyWith({
    String? id,
    String? userId,
    String? doctorId,
    String? date,
    String? time,
    String? service,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      time: time ?? this.time,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
      'service': service,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      userId: map['userId'],
      doctorId: map['doctorId'],
      date: map['date'],
      time: map['time'],
      service: map['service'],
    );
  }
}
