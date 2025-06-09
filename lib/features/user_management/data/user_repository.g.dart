// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'963402713bf9b7cc1fb259d619d9b0184d4dcec1';

/// See also [firebaseFirestore].
@ProviderFor(firebaseFirestore)
final firebaseFirestoreProvider =
    AutoDisposeProvider<FirebaseFirestore>.internal(
      firebaseFirestore,
      name: r'firebaseFirestoreProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$firebaseFirestoreHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseFirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$userRepositoryHash() => r'3e800392fca7674e90661cce096108eb87ea4a52';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$loadUserInformationHash() =>
    r'0633ba1dc035e3983d516114c31edbfa231a6c32';

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

/// See also [loadUserInformation].
@ProviderFor(loadUserInformation)
const loadUserInformationProvider = LoadUserInformationFamily();

/// See also [loadUserInformation].
class LoadUserInformationFamily extends Family<AsyncValue<AppUser>> {
  /// See also [loadUserInformation].
  const LoadUserInformationFamily();

  /// See also [loadUserInformation].
  LoadUserInformationProvider call(String userId) {
    return LoadUserInformationProvider(userId);
  }

  @override
  LoadUserInformationProvider getProviderOverride(
    covariant LoadUserInformationProvider provider,
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
  String? get name => r'loadUserInformationProvider';
}

/// See also [loadUserInformation].
class LoadUserInformationProvider extends AutoDisposeStreamProvider<AppUser> {
  /// See also [loadUserInformation].
  LoadUserInformationProvider(String userId)
    : this._internal(
        (ref) => loadUserInformation(ref as LoadUserInformationRef, userId),
        from: loadUserInformationProvider,
        name: r'loadUserInformationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadUserInformationHash,
        dependencies: LoadUserInformationFamily._dependencies,
        allTransitiveDependencies:
            LoadUserInformationFamily._allTransitiveDependencies,
        userId: userId,
      );

  LoadUserInformationProvider._internal(
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
    Stream<AppUser> Function(LoadUserInformationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadUserInformationProvider._internal(
        (ref) => create(ref as LoadUserInformationRef),
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
  AutoDisposeStreamProviderElement<AppUser> createElement() {
    return _LoadUserInformationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadUserInformationProvider && other.userId == userId;
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
mixin LoadUserInformationRef on AutoDisposeStreamProviderRef<AppUser> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _LoadUserInformationProviderElement
    extends AutoDisposeStreamProviderElement<AppUser>
    with LoadUserInformationRef {
  _LoadUserInformationProviderElement(super.provider);

  @override
  String get userId => (origin as LoadUserInformationProvider).userId;
}

String _$loadDoctorHash() => r'40c7e6e2f04e5e2221968e45f3d1a0a8df66fcfc';

/// See also [loadDoctor].
@ProviderFor(loadDoctor)
const loadDoctorProvider = LoadDoctorFamily();

/// See also [loadDoctor].
class LoadDoctorFamily extends Family<AsyncValue<List<DoctorUser>>> {
  /// See also [loadDoctor].
  const LoadDoctorFamily();

  /// See also [loadDoctor].
  LoadDoctorProvider call(String speciality) {
    return LoadDoctorProvider(speciality);
  }

  @override
  LoadDoctorProvider getProviderOverride(
    covariant LoadDoctorProvider provider,
  ) {
    return call(provider.speciality);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'loadDoctorProvider';
}

/// See also [loadDoctor].
class LoadDoctorProvider extends AutoDisposeStreamProvider<List<DoctorUser>> {
  /// See also [loadDoctor].
  LoadDoctorProvider(String speciality)
    : this._internal(
        (ref) => loadDoctor(ref as LoadDoctorRef, speciality),
        from: loadDoctorProvider,
        name: r'loadDoctorProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$loadDoctorHash,
        dependencies: LoadDoctorFamily._dependencies,
        allTransitiveDependencies: LoadDoctorFamily._allTransitiveDependencies,
        speciality: speciality,
      );

  LoadDoctorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.speciality,
  }) : super.internal();

  final String speciality;

  @override
  Override overrideWith(
    Stream<List<DoctorUser>> Function(LoadDoctorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoadDoctorProvider._internal(
        (ref) => create(ref as LoadDoctorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        speciality: speciality,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<DoctorUser>> createElement() {
    return _LoadDoctorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoadDoctorProvider && other.speciality == speciality;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, speciality.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LoadDoctorRef on AutoDisposeStreamProviderRef<List<DoctorUser>> {
  /// The parameter `speciality` of this provider.
  String get speciality;
}

class _LoadDoctorProviderElement
    extends AutoDisposeStreamProviderElement<List<DoctorUser>>
    with LoadDoctorRef {
  _LoadDoctorProviderElement(super.provider);

  @override
  String get speciality => (origin as LoadDoctorProvider).speciality;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
