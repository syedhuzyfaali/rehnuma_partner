import '../domain/job_model.dart';
import '../domain/media_item_model.dart';
import '../domain/bill_model.dart';
import '../../profile/domain/handyman_profile_model.dart';
import '../../communication/domain/chat_message_model.dart';

class MockJobRepository {
  static final HandymanProfile initialProfile = HandymanProfile(
    id: "H-8821",
    firstName: "Ali",
    middleName: null,
    lastName: "Raza",
    cnic: "35202-1234567-1",
    contactNumber: "+92 300 1234567",
    bio: "I repair taps, leaks and household wiring. 6 years of experience serving homes in Lahore.",
    skills: ["Plumbing", "Electrical"],
    avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=400",
    isVerified: true,
    isAvailableForWork: true,
    activeLocation: "DHA Phase 5, Karachi · within 5 km",
  );

  static final List<JobRequest> incomingRequests = [
    // 🌟 1. NEW REAL KARACHI JOB REQUEST
    JobRequest(
      id: "1055",
      title: "Main water line pipe burst",
      clientName: "Zainab Tariq",
      clientLocation: "Bungalow 42-B, Khayaban-e-Shamsheer, Phase 5, DHA, Karachi",
      distanceText: "1.1 km",
      timeAgoText: "Just now · 2 min ago",
      defaultOfferAmount: 2500,
      status: JobStatus.incoming,
      arrivalOtp: "5914",
      // Real Karachi GPS Coordinates
      clientLatitude: 24.8238,    // DHA Phase 5, Khayaban-e-Shamsheer
      clientLongitude: 67.0345,
      handymanLatitude: 24.8180,  // Badar Commercial area
      handymanLongitude: 67.0270,
      turnInstruction: "Turn right in 180 m onto Khayaban-e-Shamsheer",
      etaText: "5 min",
      mediaItems: [
        const MediaItem(
          id: "k-1",
          title: "Burst valve under sink",
          type: MediaType.photo,
          sizeText: "JPG · 2.1 MB",
          assetOrNetworkUrl: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=600",
        ),
      ],
      bill: const JobBill(
        invoiceNumber: "INV-1055",
        date: "24 Oct 2026",
        currency: "PKR",
        items: [
          BillItem(description: "Emergency labour", amount: 2000.0),
          BillItem(description: "Heavy PVC coupler & seal", amount: 500.0),
        ],
        totalAmount: 2500.0,
      ),
    ),

    // 2. Original Lahore Request #1042
    JobRequest(
      id: "1042",
      title: "Leaking kitchen tap",
      clientName: "Maryam Bibi",
      clientLocation: "House 24, Street 5, Gulberg III, Lahore",
      distanceText: "0.8 km",
      timeAgoText: "Today, 9:35 AM · 6 min ago",
      defaultOfferAmount: 1500,
      status: JobStatus.incoming,
      arrivalOtp: "4826",
      clientLatitude: 31.5204,    // Gulberg III, Lahore
      clientLongitude: 74.3587,
      handymanLatitude: 31.5150,
      handymanLongitude: 74.3520,
      turnInstruction: "Turn right in 200 m onto Street 5, Gulberg III",
      etaText: "4 min",
      mediaItems: [
        const MediaItem(
          id: "m-1",
          title: "Kitchen tap",
          type: MediaType.photo,
          sizeText: "JPG · 1.8 MB",
          assetOrNetworkUrl: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=600",
        ),
        const MediaItem(
          id: "m-2",
          title: "Leak close-up",
          type: MediaType.photo,
          sizeText: "JPG · 1.2 MB",
          assetOrNetworkUrl: "https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&q=80&w=600",
        ),
      ],
      bill: const JobBill(
        invoiceNumber: "INV-1042",
        date: "20 Oct 2026",
        currency: "£",
        items: [
          BillItem(description: "Labour fee", amount: 60.0),
          BillItem(description: "Equipment fee", amount: 20.0),
          BillItem(description: "Platform fee", amount: 5.0),
        ],
        totalAmount: 85.0,
      ),
    ),

    // 3. Model Town Lahore Request
    const JobRequest(
      id: "1043",
      title: "Bedroom light not working",
      clientName: "Bilal Ahmed",
      clientLocation: "House 18, Block C, Model Town, Lahore",
      distanceText: "2.1 km",
      timeAgoText: "Today, 9:30 AM · 11 min ago",
      defaultOfferAmount: 1200,
      status: JobStatus.incoming,
      arrivalOtp: "1940",
      clientLatitude: 31.4820,
      clientLongitude: 74.3180,
      handymanLatitude: 31.4750,
      handymanLongitude: 74.3100,
      mediaItems: [],
    ),
  ];

  // static final List<JobRequest> incomingRequests = [
  //   JobRequest(
  //     id: "1042",
  //     title: "Leaking kitchen tap",
  //     clientName: "Maryam Bibi",
  //     clientLocation: "House 24, Street 5, Gulberg III, Lahore",
  //     distanceText: "0.8 km",
  //     timeAgoText: "Today, 9:35 AM · 6 min ago",
  //     defaultOfferAmount: 1500,
  //     status: JobStatus.incoming,
  //     arrivalOtp: "4826",
  //     mediaItems: [
  //       const MediaItem(
  //         id: "m-1",
  //         title: "Kitchen tap",
  //         type: MediaType.photo,
  //         sizeText: "JPG · 1.8 MB",
  //         assetOrNetworkUrl: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=600",
  //       ),
  //       const MediaItem(
  //         id: "m-2",
  //         title: "Leak close-up",
  //         type: MediaType.photo,
  //         sizeText: "JPG · 1.2 MB",
  //         assetOrNetworkUrl: "https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&q=80&w=600",
  //       ),
  //       const MediaItem(
  //         id: "m-3",
  //         title: "Tap dripping while turned off",
  //         type: MediaType.video,
  //         duration: "00:24",
  //         sizeText: "MP4 · 00:24 · 8.4 MB",
  //         assetOrNetworkUrl: "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=600",
  //       ),
  //     ],
  //     bill: const JobBill(
  //       invoiceNumber: "INV-1042",
  //       date: "20 Oct 2026",
  //       currency: "£",
  //       items: [
  //         BillItem(description: "Labour fee", amount: 60.0),
  //         BillItem(description: "Equipment fee", amount: 20.0),
  //         BillItem(description: "Platform fee", amount: 5.0),
  //       ],
  //       totalAmount: 85.0,
  //     ),
  //   ),
  //   const JobRequest(
  //     id: "1043",
  //     title: "Bedroom light not working",
  //     clientName: "Bilal Ahmed",
  //     clientLocation: "House 18, Block C, Model Town, Lahore",
  //     distanceText: "2.1 km",
  //     timeAgoText: "Today, 9:30 AM · 11 min ago",
  //     defaultOfferAmount: 1200,
  //     status: JobStatus.incoming,
  //     arrivalOtp: "1940",
  //     mediaItems: [],
  //   ),
  // ];

  static final List<JobRequest> pastRequests = [
    const JobRequest(
      id: "1031",
      title: "Bathroom tap replacement",
      clientName: "Hassan Ahmed",
      clientLocation: "House 12, Street 8, Garden Town, Lahore",
      distanceText: "1.4 km",
      timeAgoText: "18 Oct 2026 · 10:30 AM",
      defaultOfferAmount: 1500,
      status: JobStatus.completed,
      arrivalOtp: "7721",
      rating: 5.0,
      clientFeedback: "Ali arrived on time, replaced the tap neatly and checked for leaks. Very polite and professional.",
      mediaItems: [],
      bill: JobBill(
        invoiceNumber: "INV-1031",
        date: "18 Oct 2026",
        currency: "PKR",
        items: [
          BillItem(description: "Labour · tap replacement", amount: 1500),
          BillItem(description: "Basin mixer tap x 1", amount: 2200),
          BillItem(description: "Seal tape & washers", amount: 300),
        ],
        totalAmount: 4000,
        isConfirmed: true,
      ),
    ),
    const JobRequest(
      id: "1028",
      title: "Ceiling fan wiring",
      clientName: "Sana Malik",
      clientLocation: "House 4, Sector B, DHA Lahore",
      distanceText: "3.2 km",
      timeAgoText: "16 Oct 2026 · 2:15 PM",
      defaultOfferAmount: 2000,
      status: JobStatus.completed,
      arrivalOtp: "3310",
      mediaItems: [],
    ),
    const JobRequest(
      id: "1025",
      title: "Blocked kitchen drain",
      clientName: "Omar Farooq",
      clientLocation: "Flat 302, Cavalry Ground, Lahore",
      distanceText: "4.0 km",
      timeAgoText: "12 Oct 2026 · 11:00 AM",
      defaultOfferAmount: 1800,
      status: JobStatus.completed,
      arrivalOtp: "9041",
      mediaItems: [],
    ),
    const JobRequest(
      id: "1022",
      title: "Loose switchboard",
      clientName: "Fatima Noor",
      clientLocation: "House 77, Iqbal Town, Lahore",
      distanceText: "2.8 km",
      timeAgoText: "09 Oct 2026 · 4:45 PM",
      defaultOfferAmount: 800,
      status: JobStatus.completed,
      arrivalOtp: "5512",
      mediaItems: [],
    ),
  ];

  static final List<ChatMessage> initialChatMessages = [
    const ChatMessage(
      id: "c1",
      senderId: "handyman",
      text: "Assalamualaikum Ayesha, I've accepted the tap repair. I'll arrive in about 4 minutes.",
      timestamp: "9:45 AM",
      isFromHandyman: true,
    ),
    const ChatMessage(
      id: "c2",
      senderId: "client",
      text: "Wa alaikum assalam. We're at House 24, Street 5. Please use the blue gate.",
      timestamp: "9:45 AM",
      isFromHandyman: false,
    ),
    const ChatMessage(
      id: "c3",
      senderId: "handyman",
      text: "Thank you! Is the water supply valve accessible under the sink?",
      timestamp: "9:46 AM",
      isFromHandyman: true,
    ),
    const ChatMessage(
      id: "c4",
      senderId: "client",
      text: "Yes, I've cleared the cabinet. I'll share the arrival OTP when you get here.",
      timestamp: "9:46 AM",
      isFromHandyman: false,
    ),
  ];
}