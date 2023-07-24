// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listEventControllerHash() =>
    r'2f71cf1bf0d036973d3bad2ab75e15cd3cd2886f';

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

abstract class _$ListEventController
    extends BuildlessAsyncNotifier<List<EventEntity>> {
  late final String eventDate;

  FutureOr<List<EventEntity>> build(
    String eventDate,
  );
}

/// See also [ListEventController].
@ProviderFor(ListEventController)
const listEventControllerProvider = ListEventControllerFamily();

/// See also [ListEventController].
class ListEventControllerFamily extends Family<AsyncValue<List<EventEntity>>> {
  /// See also [ListEventController].
  const ListEventControllerFamily();

  /// See also [ListEventController].
  ListEventControllerProvider call(
    String eventDate,
  ) {
    return ListEventControllerProvider(
      eventDate,
    );
  }

  @override
  ListEventControllerProvider getProviderOverride(
    covariant ListEventControllerProvider provider,
  ) {
    return call(
      provider.eventDate,
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
  String? get name => r'listEventControllerProvider';
}

/// See also [ListEventController].
class ListEventControllerProvider
    extends AsyncNotifierProviderImpl<ListEventController, List<EventEntity>> {
  /// See also [ListEventController].
  ListEventControllerProvider(
    this.eventDate,
  ) : super.internal(
          () => ListEventController()..eventDate = eventDate,
          from: listEventControllerProvider,
          name: r'listEventControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listEventControllerHash,
          dependencies: ListEventControllerFamily._dependencies,
          allTransitiveDependencies:
              ListEventControllerFamily._allTransitiveDependencies,
        );

  final String eventDate;

  @override
  bool operator ==(Object other) {
    return other is ListEventControllerProvider && other.eventDate == eventDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventDate.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<EventEntity>> runNotifierBuild(
    covariant ListEventController notifier,
  ) {
    return notifier.build(
      eventDate,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
