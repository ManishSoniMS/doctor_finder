class AppUser {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String? imageUrl;
  final String location;
  final double latitude;
  final double longitude;
  final String userId;
  final String type;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    this.imageUrl,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          imageUrl == other.imageUrl &&
          location == other.location &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          userId == other.userId &&
          type == other.type);

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      imageUrl.hashCode ^
      location.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      userId.hashCode ^
      type.hashCode;

  @override
  String toString() {
    return 'AppUser{'
        ' id: $id,'
        ' email: $email,'
        ' name: $name,'
        ' phoneNumber: $phoneNumber,'
        ' imageUrl: $imageUrl,'
        ' location: $location,'
        ' latitude: $latitude,'
        ' longitude: $longitude,'
        ' userId: $userId,'
        ' type: $type,'
        '}';
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    String? location,
    double? latitude,
    double? longitude,
    String? userId,
    String? type,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'type': type,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      imageUrl: map['imageUrl'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      userId: map['userId'] as String,
      type: map['type'] as String,
    );
  }
}
