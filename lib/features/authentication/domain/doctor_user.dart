import 'app_user.dart';

class DoctorUser extends AppUser {
  final String? specialization;
  final String? description;
  final int? yearsOfExperience;
  final int rating;
  final int numberOfReviews;
  final int numberOfPatients;

  const DoctorUser({
    required super.email,
    required super.name,
    required super.phoneNumber,
    super.imageUrl,
    required super.location,
    required super.latitude,
    required super.longitude,
    required super.userId,
    required super.type,
    this.specialization,
    this.description,
    this.yearsOfExperience,
    required this.rating,
    required this.numberOfReviews,
    required this.numberOfPatients,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorUser &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          imageUrl == other.imageUrl &&
          location == other.location &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          userId == other.userId &&
          type == other.type &&
          specialization == other.specialization &&
          description == other.description &&
          yearsOfExperience == other.yearsOfExperience &&
          rating == other.rating &&
          numberOfReviews == other.numberOfReviews &&
          numberOfPatients == other.numberOfPatients);

  @override
  int get hashCode =>
      email.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      imageUrl.hashCode ^
      location.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      userId.hashCode ^
      type.hashCode ^
      specialization.hashCode ^
      description.hashCode ^
      yearsOfExperience.hashCode ^
      rating.hashCode ^
      numberOfReviews.hashCode ^
      numberOfPatients.hashCode;

  @override
  String toString() {
    return 'DoctorUser{'
        ' email: $email,'
        ' name: $name,'
        ' phoneNumber: $phoneNumber,'
        ' imageUrl: $imageUrl,'
        ' location: $location,'
        ' latitude: $latitude,'
        ' longitude: $longitude,'
        ' userId: $userId,'
        ' type: $type,'
        ' specialization: $specialization,'
        ' description: $description,'
        ' yearsOfExperience: $yearsOfExperience,'
        ' rating: $rating,'
        ' numberOfReviews: $numberOfReviews,'
        ' numberOfPatients: $numberOfPatients,'
        '}';
  }

  @override
  DoctorUser copyWith({
    String? email,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    String? location,
    double? latitude,
    double? longitude,
    String? userId,
    String? type,
    String? specialization,
    String? description,
    int? yearsOfExperience,
    int? rating,
    int? numberOfReviews,
    int? numberOfPatients,
  }) {
    return DoctorUser(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      specialization: specialization ?? this.specialization,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      rating: rating ?? this.rating,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
      numberOfPatients: numberOfPatients ?? this.numberOfPatients,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'type': type,
      'specialization': specialization,
      'description': description,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'numberOfReviews': numberOfReviews,
      'numberOfPatients': numberOfPatients,
    };
  }

  factory DoctorUser.fromMap(Map<String, dynamic> map) {
    return DoctorUser(
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      imageUrl: map['imageUrl'],
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userId: map['userId'],
      type: map['type'],
      specialization: map['specialization'],
      description: map['description'],
      yearsOfExperience: map['yearsOfExperience'],
      rating: map['rating'],
      numberOfReviews: map['numberOfReviews'],
      numberOfPatients: map['numberOfPatients'] ?? 0,
    );
  }
}
