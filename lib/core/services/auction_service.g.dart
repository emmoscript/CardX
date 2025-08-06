// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$auctionServiceHash() => r'0b8e1391cc05ee2fd8f28c64089cedaced879e76';

/// See also [auctionService].
@ProviderFor(auctionService)
final auctionServiceProvider = AutoDisposeProvider<AuctionService>.internal(
  auctionService,
  name: r'auctionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$auctionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuctionServiceRef = AutoDisposeProviderRef<AuctionService>;
String _$activeAuctionsHash() => r'f18d18ae4c97f320d81021a8e3087953c71b2c9b';

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

/// See also [activeAuctions].
@ProviderFor(activeAuctions)
const activeAuctionsProvider = ActiveAuctionsFamily();

/// See also [activeAuctions].
class ActiveAuctionsFamily extends Family<AsyncValue<List<Auction>>> {
  /// See also [activeAuctions].
  const ActiveAuctionsFamily();

  /// See also [activeAuctions].
  ActiveAuctionsProvider call({
    AuctionFilter? filter,
  }) {
    return ActiveAuctionsProvider(
      filter: filter,
    );
  }

  @override
  ActiveAuctionsProvider getProviderOverride(
    covariant ActiveAuctionsProvider provider,
  ) {
    return call(
      filter: provider.filter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activeAuctionsProvider';
}

/// See also [activeAuctions].
class ActiveAuctionsProvider extends AutoDisposeFutureProvider<List<Auction>> {
  /// See also [activeAuctions].
  ActiveAuctionsProvider({
    AuctionFilter? filter,
  }) : this._internal(
          (ref) => activeAuctions(
            ref as ActiveAuctionsRef,
            filter: filter,
          ),
          from: activeAuctionsProvider,
          name: r'activeAuctionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activeAuctionsHash,
          dependencies: ActiveAuctionsFamily._dependencies,
          allTransitiveDependencies:
              ActiveAuctionsFamily._allTransitiveDependencies,
          filter: filter,
        );

  ActiveAuctionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final AuctionFilter? filter;

  @override
  Override overrideWith(
    FutureOr<List<Auction>> Function(ActiveAuctionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActiveAuctionsProvider._internal(
        (ref) => create(ref as ActiveAuctionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Auction>> createElement() {
    return _ActiveAuctionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveAuctionsProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActiveAuctionsRef on AutoDisposeFutureProviderRef<List<Auction>> {
  /// The parameter `filter` of this provider.
  AuctionFilter? get filter;
}

class _ActiveAuctionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Auction>>
    with ActiveAuctionsRef {
  _ActiveAuctionsProviderElement(super.provider);

  @override
  AuctionFilter? get filter => (origin as ActiveAuctionsProvider).filter;
}

String _$auctionByIdHash() => r'fb4c090e89f2c97b6ecd694e9e77d0c232d54d08';

/// See also [auctionById].
@ProviderFor(auctionById)
const auctionByIdProvider = AuctionByIdFamily();

/// See also [auctionById].
class AuctionByIdFamily extends Family<AsyncValue<Auction?>> {
  /// See also [auctionById].
  const AuctionByIdFamily();

  /// See also [auctionById].
  AuctionByIdProvider call(
    String id,
  ) {
    return AuctionByIdProvider(
      id,
    );
  }

  @override
  AuctionByIdProvider getProviderOverride(
    covariant AuctionByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'auctionByIdProvider';
}

/// See also [auctionById].
class AuctionByIdProvider extends AutoDisposeFutureProvider<Auction?> {
  /// See also [auctionById].
  AuctionByIdProvider(
    String id,
  ) : this._internal(
          (ref) => auctionById(
            ref as AuctionByIdRef,
            id,
          ),
          from: auctionByIdProvider,
          name: r'auctionByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$auctionByIdHash,
          dependencies: AuctionByIdFamily._dependencies,
          allTransitiveDependencies:
              AuctionByIdFamily._allTransitiveDependencies,
          id: id,
        );

  AuctionByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Auction?> Function(AuctionByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuctionByIdProvider._internal(
        (ref) => create(ref as AuctionByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Auction?> createElement() {
    return _AuctionByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuctionByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuctionByIdRef on AutoDisposeFutureProviderRef<Auction?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AuctionByIdProviderElement
    extends AutoDisposeFutureProviderElement<Auction?> with AuctionByIdRef {
  _AuctionByIdProviderElement(super.provider);

  @override
  String get id => (origin as AuctionByIdProvider).id;
}

String _$watchedAuctionsHash() => r'ca9012f9eca9f81007488802d24c3fd5bb230224';

/// See also [watchedAuctions].
@ProviderFor(watchedAuctions)
const watchedAuctionsProvider = WatchedAuctionsFamily();

/// See also [watchedAuctions].
class WatchedAuctionsFamily extends Family<AsyncValue<List<Auction>>> {
  /// See also [watchedAuctions].
  const WatchedAuctionsFamily();

  /// See also [watchedAuctions].
  WatchedAuctionsProvider call(
    String userId,
  ) {
    return WatchedAuctionsProvider(
      userId,
    );
  }

  @override
  WatchedAuctionsProvider getProviderOverride(
    covariant WatchedAuctionsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchedAuctionsProvider';
}

/// See also [watchedAuctions].
class WatchedAuctionsProvider extends AutoDisposeFutureProvider<List<Auction>> {
  /// See also [watchedAuctions].
  WatchedAuctionsProvider(
    String userId,
  ) : this._internal(
          (ref) => watchedAuctions(
            ref as WatchedAuctionsRef,
            userId,
          ),
          from: watchedAuctionsProvider,
          name: r'watchedAuctionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchedAuctionsHash,
          dependencies: WatchedAuctionsFamily._dependencies,
          allTransitiveDependencies:
              WatchedAuctionsFamily._allTransitiveDependencies,
          userId: userId,
        );

  WatchedAuctionsProvider._internal(
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
    FutureOr<List<Auction>> Function(WatchedAuctionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchedAuctionsProvider._internal(
        (ref) => create(ref as WatchedAuctionsRef),
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
  AutoDisposeFutureProviderElement<List<Auction>> createElement() {
    return _WatchedAuctionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchedAuctionsProvider && other.userId == userId;
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
mixin WatchedAuctionsRef on AutoDisposeFutureProviderRef<List<Auction>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _WatchedAuctionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Auction>>
    with WatchedAuctionsRef {
  _WatchedAuctionsProviderElement(super.provider);

  @override
  String get userId => (origin as WatchedAuctionsProvider).userId;
}

String _$userAuctionsHash() => r'572481e9e346762ef2f059b0ebe5efd3b92ca88f';

/// See also [userAuctions].
@ProviderFor(userAuctions)
const userAuctionsProvider = UserAuctionsFamily();

/// See also [userAuctions].
class UserAuctionsFamily extends Family<AsyncValue<List<Auction>>> {
  /// See also [userAuctions].
  const UserAuctionsFamily();

  /// See also [userAuctions].
  UserAuctionsProvider call(
    String userId,
  ) {
    return UserAuctionsProvider(
      userId,
    );
  }

  @override
  UserAuctionsProvider getProviderOverride(
    covariant UserAuctionsProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAuctionsProvider';
}

/// See also [userAuctions].
class UserAuctionsProvider extends AutoDisposeFutureProvider<List<Auction>> {
  /// See also [userAuctions].
  UserAuctionsProvider(
    String userId,
  ) : this._internal(
          (ref) => userAuctions(
            ref as UserAuctionsRef,
            userId,
          ),
          from: userAuctionsProvider,
          name: r'userAuctionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userAuctionsHash,
          dependencies: UserAuctionsFamily._dependencies,
          allTransitiveDependencies:
              UserAuctionsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserAuctionsProvider._internal(
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
    FutureOr<List<Auction>> Function(UserAuctionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserAuctionsProvider._internal(
        (ref) => create(ref as UserAuctionsRef),
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
  AutoDisposeFutureProviderElement<List<Auction>> createElement() {
    return _UserAuctionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAuctionsProvider && other.userId == userId;
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
mixin UserAuctionsRef on AutoDisposeFutureProviderRef<List<Auction>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserAuctionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Auction>>
    with UserAuctionsRef {
  _UserAuctionsProviderElement(super.provider);

  @override
  String get userId => (origin as UserAuctionsProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
