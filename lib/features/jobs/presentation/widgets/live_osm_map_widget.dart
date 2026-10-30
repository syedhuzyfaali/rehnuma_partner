import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/osrm_routing_service.dart';

class LiveOsmMapWidget extends StatefulWidget {
  final LatLng startPoint;
  final LatLng destinationPoint;
  final String etaText;
  final String distanceText;
  final ValueChanged<String>? onInstructionUpdated;

  const LiveOsmMapWidget({
    super.key,
    required this.startPoint,
    required this.destinationPoint,
    this.etaText = "5 min",
    this.distanceText = "1.1 km",
    this.onInstructionUpdated,
  });

  @override
  State<LiveOsmMapWidget> createState() => _LiveOsmMapWidgetState();
}

class _LiveOsmMapWidgetState extends State<LiveOsmMapWidget> {
  late final MapController _mapController;
  List<LatLng> _actualRoadPoints = [];
  bool _isLoadingRoute = true;
  String _liveEta = "";
  String _liveDistance = "";

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _liveEta = widget.etaText;
    _liveDistance = widget.distanceText;
    _fetchRealRoadGeometry();
  }

  @override
  void didUpdateWidget(covariant LiveOsmMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.destinationPoint != widget.destinationPoint ||
        oldWidget.startPoint != widget.startPoint) {
      _fetchRealRoadGeometry();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _fetchRealRoadGeometry() async {
    setState(() => _isLoadingRoute = true);

    final routeData = await OsrmRoutingService.fetchRealRoute(
      start: widget.startPoint,
      destination: widget.destinationPoint,
    );

    if (mounted) {
      if (routeData != null && routeData.polylinePoints.isNotEmpty) {
        setState(() {
          _actualRoadPoints = routeData.polylinePoints;
          _isLoadingRoute = false;

          // Format real ETA from calculated duration
          final int mins = (routeData.durationSeconds / 60).round();
          _liveEta = mins <= 1 ? "1 min" : "$mins min";

          // Format real distance from calculated meters
          final double km = routeData.distanceMeters / 1000;
          _liveDistance = "${km.toStringAsFixed(1)} km";
        });

        if (widget.onInstructionUpdated != null) {
          widget.onInstructionUpdated!(routeData.nextManeuverInstruction);
        }

        // Fit map bounds to show full route comfortably
        _fitBoundsToRoute(_actualRoadPoints);
      } else {
        // Fallback: If offline, calculate realistic grid street curves
        setState(() {
          _actualRoadPoints = _generateFallbackGridWaypoints(
            widget.startPoint,
            widget.destinationPoint,
          );
          _isLoadingRoute = false;
        });
        _fitBoundsToRoute(_actualRoadPoints);
      }
    }
  }

  void _fitBoundsToRoute(List<LatLng> points) {
    if (points.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bounds = LatLngBounds.fromPoints(points);
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 40),
        ),
      );
    });
  }

  List<LatLng> _generateFallbackGridWaypoints(LatLng start, LatLng end) {
    final midLat = start.latitude + (end.latitude - start.latitude) * 0.55;
    final midLng = start.longitude + (end.longitude - start.longitude) * 0.45;
    return [
      start,
      LatLng(midLat, start.longitude),
      LatLng(midLat, midLng),
      LatLng(end.latitude, midLng),
      end,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final center = LatLng(
      (widget.startPoint.latitude + widget.destinationPoint.latitude) / 2,
      (widget.startPoint.longitude + widget.destinationPoint.longitude) / 2,
    );

    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: 15.0,
                minZoom: 11.0,
                maxZoom: 18.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
              ),
              children: [
                // OpenStreetMap Tile Layer
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'pk.rehnuma.partner',
                  tileProvider: NetworkTileProvider(),
                ),

                // 🛣️ Actual Road Polyline Layer
                if (_actualRoadPoints.isNotEmpty) ...[
                  // Background casing line for high contrast
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _actualRoadPoints,
                        color: const Color(0xFF005DB3),
                        strokeWidth: 7.5,
                        strokeCap: StrokeCap.round,
                        strokeJoin: StrokeJoin.round,
                      ),
                    ],
                  ),
                  // Foreground bright blue road polyline
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _actualRoadPoints,
                        color: AppColors.primaryBlue,
                        strokeWidth: 5.0,
                        strokeCap: StrokeCap.round,
                        strokeJoin: StrokeJoin.round,
                      ),
                    ],
                  ),
                ],

                // Markers Layer (Handyman + Customer)
                MarkerLayer(
                  markers: [
                    // Start marker (Handyman pulsating node)
                    Marker(
                      point: widget.startPoint,
                      width: 48,
                      height: 48,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBlue.withOpacity(0.24),
                            ),
                          ),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Destination marker (Client house icon)
                    Marker(
                      point: widget.destinationPoint,
                      width: 46,
                      height: 46,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0072C6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.home, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Loading Route overlay
            if (_isLoadingRoute)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 6),
                      Text("Finding best road route...", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

            // Recenter & Refocus Button
            Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                onTap: () => _fitBoundsToRoute(_actualRoadPoints),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.my_location, size: 20, color: AppColors.primaryBlue),
                ),
              ),
            ),

            // Floating live ETA and Distance Badge
            Positioned(
              bottom: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "$_liveEta · $_liveDistance",
                  style: AppTextStyles.labelSemibold.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontSize: 13,
                  ),
                ),
              ),
            ),

            // OSRM & OpenStreetMap Source Tag
            Positioned(
              bottom: 6,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "OSRM · © OpenStreetMap",
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 9, color: AppColors.textSecondaryGrey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}