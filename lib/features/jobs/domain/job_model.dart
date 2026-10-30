import 'media_item_model.dart';
import 'bill_model.dart';

enum JobStatus {
  incoming,
  accepted,
  onTheWay,
  inProgress,
  billUploaded,
  completed,
  cancelled,
}

class JobRequest {
  final String id;
  final String title;
  final String clientName;
  final String clientLocation;
  final String distanceText;
  final String timeAgoText;
  final double defaultOfferAmount;
  final double? submittedOfferAmount;
  final JobStatus status;
  final String arrivalOtp;
  final List<MediaItem> mediaItems;
  final JobBill? bill;
  final double? rating;
  final String? clientFeedback;

  // Real GPS Coordinates for OpenStreetMap
  final double clientLatitude;
  final double clientLongitude;
  final double handymanLatitude;
  final double handymanLongitude;
  final String turnInstruction;
  final String etaText;


  const JobRequest({
    required this.id,
    required this.title,
    required this.clientName,
    required this.clientLocation,
    required this.distanceText,
    required this.timeAgoText,
    required this.defaultOfferAmount,
    this.submittedOfferAmount,
    required this.status,
    required this.arrivalOtp,
    required this.mediaItems,
    this.bill,
    this.rating,
    this.clientFeedback,

    this.clientLatitude = 24.8238,    // Default Karachi coordinates
    this.clientLongitude = 67.0345,
    this.handymanLatitude = 24.8190,
    this.handymanLongitude = 67.0280,
    this.turnInstruction = "Turn right in 200 m onto Khayaban-e-Shamsheer",
    this.etaText = "6 min",
  });

  JobRequest copyWith({
    JobStatus? status,
    double? submittedOfferAmount,
    JobBill? bill,
    double? rating,
    String? clientFeedback,
  }) {
    return JobRequest(
      id: id,
      title: title,
      clientName: clientName,
      clientLocation: clientLocation,
      distanceText: distanceText,
      timeAgoText: timeAgoText,
      defaultOfferAmount: defaultOfferAmount,
      submittedOfferAmount: submittedOfferAmount ?? this.submittedOfferAmount,
      status: status ?? this.status,
      arrivalOtp: arrivalOtp,
      mediaItems: mediaItems,
      bill: bill ?? this.bill,
      rating: rating ?? this.rating,
      clientFeedback: clientFeedback ?? this.clientFeedback,
      clientLatitude: clientLatitude,
      clientLongitude: clientLongitude,
      handymanLatitude: handymanLatitude,
      handymanLongitude: handymanLongitude,
      turnInstruction: turnInstruction,
      etaText: etaText,
    );
  }
}