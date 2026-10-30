class HandymanProfile {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String cnic;
  final String contactNumber;
  final String bio;
  final List<String> skills;
  final String avatarUrl;
  final bool isVerified;
  final bool isAvailableForWork;
  final String activeLocation;

  const HandymanProfile({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.cnic,
    required this.contactNumber,
    required this.bio,
    required this.skills,
    required this.avatarUrl,
    this.isVerified = true,
    this.isAvailableForWork = true,
    this.activeLocation = "Gulberg, Lahore · within 5 km",
  });

  String get fullName => middleName != null && middleName!.isNotEmpty
      ? "$firstName $middleName $lastName"
      : "$firstName $lastName";

  HandymanProfile copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? cnic,
    String? contactNumber,
    String? bio,
    List<String>? skills,
    String? avatarUrl,
    bool? isVerified,
    bool? isAvailableForWork,
    String? activeLocation,
  }) {
    return HandymanProfile(
      id: id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      cnic: cnic ?? this.cnic,
      contactNumber: contactNumber ?? this.contactNumber,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      isAvailableForWork: isAvailableForWork ?? this.isAvailableForWork,
      activeLocation: activeLocation ?? this.activeLocation,
    );
  }
}