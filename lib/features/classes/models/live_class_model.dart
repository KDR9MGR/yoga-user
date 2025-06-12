/// Live class model
class LiveClassModel {
  final String id;
  final String title;
  final String description;
  final String trainerId;
  final String trainerName;
  final String? trainerImage;
  final DateTime scheduledTime;
  final Duration duration;
  final String yogaStyle;
  final String difficultyLevel;
  final double price;
  final int maxParticipants;
  final int currentParticipants;
  final List<String> participantIds;
  final ClassType classType;
  final ClassStatus status;
  final String? meetingLink;
  final String? meetingPassword;
  final List<String> requirements;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LiveClassModel({
    required this.id,
    required this.title,
    required this.description,
    required this.trainerId,
    required this.trainerName,
    this.trainerImage,
    required this.scheduledTime,
    required this.duration,
    required this.yogaStyle,
    required this.difficultyLevel,
    required this.price,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.participantIds,
    required this.classType,
    required this.status,
    this.meetingLink,
    this.meetingPassword,
    required this.requirements,
    this.imageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isFull => currentParticipants >= maxParticipants;
  bool get canJoin => status == ClassStatus.scheduled && !isFull;
  bool get isUpcoming => scheduledTime.isAfter(DateTime.now());
  bool get isLive => status == ClassStatus.live;
  bool get hasEnded => status == ClassStatus.completed;

  DateTime get endTime => scheduledTime.add(duration);

  LiveClassModel copyWith({
    String? id,
    String? title,
    String? description,
    String? trainerId,
    String? trainerName,
    String? trainerImage,
    DateTime? scheduledTime,
    Duration? duration,
    String? yogaStyle,
    String? difficultyLevel,
    double? price,
    int? maxParticipants,
    int? currentParticipants,
    List<String>? participantIds,
    ClassType? classType,
    ClassStatus? status,
    String? meetingLink,
    String? meetingPassword,
    List<String>? requirements,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LiveClassModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      trainerId: trainerId ?? this.trainerId,
      trainerName: trainerName ?? this.trainerName,
      trainerImage: trainerImage ?? this.trainerImage,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      duration: duration ?? this.duration,
      yogaStyle: yogaStyle ?? this.yogaStyle,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      price: price ?? this.price,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      participantIds: participantIds ?? this.participantIds,
      classType: classType ?? this.classType,
      status: status ?? this.status,
      meetingLink: meetingLink ?? this.meetingLink,
      meetingPassword: meetingPassword ?? this.meetingPassword,
      requirements: requirements ?? this.requirements,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'trainer_id': trainerId,
      'trainer_name': trainerName,
      'trainer_image': trainerImage,
      'scheduled_time': scheduledTime.toIso8601String(),
      'duration_minutes': duration.inMinutes,
      'yoga_style': yogaStyle,
      'difficulty_level': difficultyLevel,
      'price': price,
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'participant_ids': participantIds,
      'class_type': classType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'meeting_link': meetingLink,
      'meeting_password': meetingPassword,
      'requirements': requirements,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory LiveClassModel.fromJson(Map<String, dynamic> json) {
    return LiveClassModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      trainerId: json['trainer_id'] ?? '',
      trainerName: json['trainer_name'] ?? '',
      trainerImage: json['trainer_image'],
      scheduledTime: DateTime.parse(json['scheduled_time']),
      duration: Duration(minutes: json['duration_minutes'] ?? 60),
      yogaStyle: json['yoga_style'] ?? '',
      difficultyLevel: json['difficulty_level'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      maxParticipants: json['max_participants'] ?? 0,
      currentParticipants: json['current_participants'] ?? 0,
      participantIds: List<String>.from(json['participant_ids'] ?? []),
      classType: _parseClassType(json['class_type']),
      status: _parseClassStatus(json['status']),
      meetingLink: json['meeting_link'],
      meetingPassword: json['meeting_password'],
      requirements: List<String>.from(json['requirements'] ?? []),
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  static ClassType _parseClassType(String? type) {
    switch (type?.toLowerCase()) {
      case 'group':
        return ClassType.group;
      case 'personal':
        return ClassType.personal;
      case 'workshop':
        return ClassType.workshop;
      case 'meetup':
        return ClassType.meetup;
      default:
        return ClassType.group;
    }
  }

  static ClassStatus _parseClassStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'scheduled':
        return ClassStatus.scheduled;
      case 'live':
        return ClassStatus.live;
      case 'completed':
        return ClassStatus.completed;
      case 'cancelled':
        return ClassStatus.cancelled;
      default:
        return ClassStatus.scheduled;
    }
  }
}

enum ClassType {
  group,
  personal,
  workshop,
  meetup,
}

enum ClassStatus {
  scheduled,
  live,
  completed,
  cancelled,
}

extension ClassTypeExtension on ClassType {
  String get displayName {
    switch (this) {
      case ClassType.group:
        return 'Group Class';
      case ClassType.personal:
        return 'Personal Session';
      case ClassType.workshop:
        return 'Workshop';
      case ClassType.meetup:
        return 'Community Meetup';
    }
  }

  String get description {
    switch (this) {
      case ClassType.group:
        return 'Join with other practitioners';
      case ClassType.personal:
        return 'One-on-one session';
      case ClassType.workshop:
        return 'In-depth learning session';
      case ClassType.meetup:
        return 'Virtual community gathering';
    }
  }
}

extension ClassStatusExtension on ClassStatus {
  String get displayName {
    switch (this) {
      case ClassStatus.scheduled:
        return 'Scheduled';
      case ClassStatus.live:
        return 'Live Now';
      case ClassStatus.completed:
        return 'Completed';
      case ClassStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get canJoin {
    return this == ClassStatus.scheduled || this == ClassStatus.live;
  }
} 