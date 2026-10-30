enum MediaType { photo, video }

class MediaItem {
  final String id;
  final String title;
  final MediaType type;
  final String sizeText;
  final String? duration;
  final String assetOrNetworkUrl;

  const MediaItem({
    required this.id,
    required this.title,
    required this.type,
    required this.sizeText,
    this.duration,
    required this.assetOrNetworkUrl,
  });
}