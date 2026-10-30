import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class OsrmRouteData {
  final List<LatLng> polylinePoints;
  final double distanceMeters;
  final double durationSeconds;
  final String nextManeuverInstruction;

  const OsrmRouteData({
    required this.polylinePoints,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.nextManeuverInstruction,
  });
}

class OsrmRoutingService {
  OsrmRoutingService._();

  /// Fetches real road turn coordinates between start and destination
  static Future<OsrmRouteData?> fetchRealRoute({
    required LatLng start,
    required LatLng destination,
  }) async {
    try {
      // OSRM Public Driving API: coordinates format is {lng},{lat};{lng},{lat}
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
            '${start.longitude},${start.latitude};'
            '${destination.longitude},${destination.latitude}'
            '?overview=full&geometries=geojson&steps=true',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final routes = data['routes'] as List<dynamic>?;

        if (routes != null && routes.isNotEmpty) {
          final primaryRoute = routes.first;
          final geometry = primaryRoute['geometry'] as Map<String, dynamic>;
          final rawCoords = geometry['coordinates'] as List<dynamic>;

          // Convert GeoJSON [lon, lat] pairs into LatLng(lat, lon)
          final List<LatLng> latLngs = rawCoords.map<LatLng>((coord) {
            final double lon = (coord[0] as num).toDouble();
            final double lat = (coord[1] as num).toDouble();
            return LatLng(lat, lon);
          }).toList();

          final double distance = (primaryRoute['distance'] as num?)?.toDouble() ?? 0.0;
          final double duration = (primaryRoute['duration'] as num?)?.toDouble() ?? 0.0;

          // Parse the very first step maneuver instruction if present
          String nextInstruction = "Continue along route";
          try {
            final legs = primaryRoute['legs'] as List<dynamic>?;
            if (legs != null && legs.isNotEmpty) {
              final steps = legs.first['steps'] as List<dynamic>?;
              if (steps != null && steps.length > 1) {
                final step = steps[1];
                final maneuver = step['maneuver'];
                final type = maneuver['type'] ?? '';
                final modifier = maneuver['modifier'] ?? '';
                final name = step['name'] ?? '';
                nextInstruction = _formatInstruction(type, modifier, name);
              }
            }
          } catch (_) {}

          return OsrmRouteData(
            polylinePoints: latLngs,
            distanceMeters: distance,
            durationSeconds: duration,
            nextManeuverInstruction: nextInstruction,
          );
        }
      }
    } catch (_) {
      // Network fallback handles timeouts gracefully
    }
    return null;
  }

  static String _formatInstruction(String type, String modifier, String street) {
    final streetPart = street.isNotEmpty ? " onto $street" : "";
    if (modifier.contains('right')) return "Turn right$streetPart";
    if (modifier.contains('left')) return "Turn left$streetPart";
    if (type.contains('roundabout')) return "Enter roundabout$streetPart";
    if (type.contains('depart')) return "Head straight$streetPart";
    return "Continue straight$streetPart";
  }
}