import 'package:geolocator/geolocator.dart';

class LocationService {
  // Cache permission state so we don't re-check every call
  bool _permissionVerified = false;

  // Cache the last successful position (survives across BLoC re-creations)
  Position? _cachedPosition;

  /// How long a cached position stays valid before we re-fetch
  static const _cacheMaxAge = Duration(minutes: 5);

  /// Determine the current position of the device.
  ///
  /// Uses a 3-tier strategy for speed:
  ///   1. Return in-memory cached position if fresh (instant)
  ///   2. Return platform's last-known position (instant)
  ///   3. Fetch fresh position with LOW accuracy / network-based (<1s)
  Future<Position> getCurrentPosition() async {
    // ── Tier 1: In-memory cache (instant) ──
    if (_cachedPosition != null) {
      final age = DateTime.now().difference(_cachedPosition!.timestamp);
      if (age < _cacheMaxAge) {
        return _cachedPosition!;
      }
    }

    // ── Permission check (cached after first success) ──
    await _ensurePermission();

    // ── Tier 2: Platform last-known position (instant) ──
    final lastKnown = await Geolocator.getLastKnownPosition();
    if (lastKnown != null) {
      _cachedPosition = lastKnown;
      return lastKnown;
    }

    // ── Tier 3: Fresh position — LOW accuracy for speed ──
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low, // network-based, <1s
        timeLimit: Duration(seconds: 5),
      ),
    );
    _cachedPosition = position;
    return position;
  }

  /// Checks service + permission only once per session.
  /// Subsequent calls skip entirely (~0ms vs ~500ms).
  Future<void> _ensurePermission() async {
    if (_permissionVerified) return;

    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check & request permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Cache the successful permission check
    _permissionVerified = true;
  }

  /// Call this if the user disables location from system settings
  /// so the next call re-checks permissions.
  void invalidateCache() {
    _permissionVerified = false;
    _cachedPosition = null;
  }
}
