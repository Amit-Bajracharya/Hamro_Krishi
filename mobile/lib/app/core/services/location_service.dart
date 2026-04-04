import 'dart:async';
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
  ///   3. Fetch fresh position with LOW accuracy / network-based (<10s)
  Future<Position> getCurrentPosition() async {
    // ── Tier 1: In-memory cache (instant) ──
    if (_cachedPosition != null) {
      final age = DateTime.now().difference(_cachedPosition!.timestamp);
      if (age < _cacheMaxAge) {
        return _cachedPosition!;
      }
    }

    try {
      // ── Permission check (cached after first success) ──
      await _ensurePermission();

      // ── Tier 3: Fresh position — LOW accuracy for speed ──
      // We try this FIRST now if we want fresh data, but with a shortcut
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low, // network-based, <1s usually
          timeLimit: Duration(seconds: 10), // Increased from 5 to 10
        ),
      );
      _cachedPosition = position;
      return position;
    } on TimeoutException {
      // ── Tier 2: Fallback to Platform last-known position ──
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        _cachedPosition = lastKnown;
        return lastKnown;
      }
      return Future.error('Location timeout. Please ensure GPS is on and you are not indoors.');
    } catch (e) {
      // If fresh failed for other reasons, try last known as a last resort
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        _cachedPosition = lastKnown;
        return lastKnown;
      }
      rethrow;
    }
  }

  /// Checks service + permission only once per session.
  /// Subsequent calls skip entirely (~0ms vs ~500ms).
  Future<void> _ensurePermission() async {
    if (_permissionVerified) return;

    // Check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('GPS is disabled. Please enable location services in settings.');
    }

    // Check & request permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied. We need this to verify your farm/shop location.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied. Please enable them in app settings.',
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
