// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingRepositoryHash() => r'34436b6e1e639685922f8fd90d381abce3441093';

/// See also [bookingRepository].
@ProviderFor(bookingRepository)
final bookingRepositoryProvider =
    AutoDisposeProvider<BookingRepository>.internal(
      bookingRepository,
      name: r'bookingRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRepositoryRef = AutoDisposeProviderRef<BookingRepository>;
String _$loadUserBookingsHash() => r'81aac6d212c21fd6a9f13d7a83cb387239ec4b89';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [loadUserBookings].
@ProviderFor(loadUserBookings)
const loadUserBookingsProvider = LoadUserBookingsFamily();

/// See also [loadUserBookings].
class LoadUserBookingsFamily extends Family<AsyncValue<List<Booking>>> {
  /// See also [loadUserBookings].
  const LoadUserBookingsFamily();

  /// See also [loadUserBookings].
  LoadUserBookingsProvider call(String userId) {
    return LoadUserBookingsProvider(userId);
  }

  @override
  LoadUserBookingsProvider getProviderOverride(
    covariant LoadUserBookingsProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadUserBookingsProvider';
}

/// See also [loadUserBookings].
class LoadUserBookingsProvider extends StreamProvider<List<Booking>> {
  /// See also [loadUserBookings].
  LoadUserBookingsProvider(String userId)
    : this._internal(
        (ref) => loadUserBookings(ref as LoadUserBookingsRef, userId),
        from: loadUserBookingsProvider,
        name: r'loadUserBookingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadUserBookingsHash,
        dependencies: LoadUserBookingsFamily._dependencies,
        allTransitiveDependencies:
            LoadUserBookingsFamily._allTransitiveDependencies,
        userId: userId,
      );

  LoadUserBookingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Booking>> Function(LoadUserBookingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadUserBookingsProvider._internal(
        (ref) => create(ref as LoadUserBookingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  StreamProviderElement<List<Booking>> createElement() {
    return _LoadUserBookingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadUserBookingsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadUserBookingsRef on StreamProviderRef<List<Booking>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LoadUserBookingsProviderElement
    extends StreamProviderElement<List<Booking>>
    with LoadUserBookingsRef {
  _LoadUserBookingsProviderElement(super.provider);

  @override
  String get userId => (origin as LoadUserBookingsProvider).userId;
}

String _$loadDoctorBookingsHash() =>
    r'af634201740ffdc6bda55cf3fad7d8c73eba645e';

/// See also [loadDoctorBookings].
@ProviderFor(loadDoctorBookings)
const loadDoctorBookingsProvider = LoadDoctorBookingsFamily();

/// See also [loadDoctorBookings].
class LoadDoctorBookingsFamily extends Family<AsyncValue<List<Booking>>> {
  /// See also [loadDoctorBookings].
  const LoadDoctorBookingsFamily();

  /// See also [loadDoctorBookings].
  LoadDoctorBookingsProvider call(String doctorId) {
    return LoadDoctorBookingsProvider(doctorId);
  }

  @override
  LoadDoctorBookingsProvider getProviderOverride(
    covariant LoadDoctorBookingsProvider provider,
  ) {
    return call(provider.doctorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadDoctorBookingsProvider';
}

/// See also [loadDoctorBookings].
class LoadDoctorBookingsProvider extends StreamProvider<List<Booking>> {
  /// See also [loadDoctorBookings].
  LoadDoctorBookingsProvider(String doctorId)
    : this._internal(
        (ref) => loadDoctorBookings(ref as LoadDoctorBookingsRef, doctorId),
        from: loadDoctorBookingsProvider,
        name: r'loadDoctorBookingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadDoctorBookingsHash,
        dependencies: LoadDoctorBookingsFamily._dependencies,
        allTransitiveDependencies:
            LoadDoctorBookingsFamily._allTransitiveDependencies,
        doctorId: doctorId,
      );

  LoadDoctorBookingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.doctorId,
  }) : super.internal();

  final String doctorId;

  @override
  Override overrideWith(
    Stream<List<Booking>> Function(LoadDoctorBookingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadDoctorBookingsProvider._internal(
        (ref) => create(ref as LoadDoctorBookingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        doctorId: doctorId,
      ),
    );
  }

  @override
  StreamProviderElement<List<Booking>> createElement() {
    return _LoadDoctorBookingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadDoctorBookingsProvider && other.doctorId == doctorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, doctorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadDoctorBookingsRef on StreamProviderRef<List<Booking>> {
  /// The parameter `doctorId` of this provider.
  String get doctorId;
}

class _LoadDoctorBookingsProviderElement
    extends StreamProviderElement<List<Booking>>
    with LoadDoctorBookingsRef {
  _LoadDoctorBookingsProviderElement(super.provider);

  @override
  String get doctorId => (origin as LoadDoctorBookingsProvider).doctorId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
