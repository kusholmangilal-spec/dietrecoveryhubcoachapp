enum VerificationStatus { pending, underReview, approved, rejected }

enum MealReviewStatus { pending, approved, needsChanges }

enum ConsultationStatus { upcoming, completed, cancelled }

class CoachProfile {
  const CoachProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.credentials,
    required this.specialization,
    required this.yearsExperience,
    required this.licenseId,
    required this.bio,
    required this.verificationStatus,
  });

  final String fullName;
  final String email;
  final String phone;
  final String credentials;
  final String specialization;
  final int yearsExperience;
  final String licenseId;
  final String bio;
  final VerificationStatus verificationStatus;

  CoachProfile copyWith({VerificationStatus? verificationStatus}) {
    return CoachProfile(
      fullName: fullName,
      email: email,
      phone: phone,
      credentials: credentials,
      specialization: specialization,
      yearsExperience: yearsExperience,
      licenseId: licenseId,
      bio: bio,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}

class Client {
  const Client({
    required this.id,
    required this.name,
    required this.goal,
    required this.plan,
    required this.adherence,
    required this.status,
    required this.lastCheckIn,
    required this.energyScore,
    required this.mealsLogged,
    required this.notes,
  });

  final String id;
  final String name;
  final String goal;
  final String plan;
  final int adherence;
  final String status;
  final DateTime lastCheckIn;
  final int energyScore;
  final int mealsLogged;
  final String notes;
}

class MealReview {
  const MealReview({
    required this.id,
    required this.clientName,
    required this.mealName,
    required this.loggedAt,
    required this.notes,
    required this.status,
    required this.calories,
  });

  final String id;
  final String clientName;
  final String mealName;
  final DateTime loggedAt;
  final String notes;
  final MealReviewStatus status;
  final int calories;

  MealReview copyWith({MealReviewStatus? status}) {
    return MealReview(
      id: id,
      clientName: clientName,
      mealName: mealName,
      loggedAt: loggedAt,
      notes: notes,
      status: status ?? this.status,
      calories: calories,
    );
  }
}

class DietPlan {
  const DietPlan({
    required this.id,
    required this.title,
    required this.focus,
    required this.durationWeeks,
    required this.assignedClients,
    required this.dailyCalories,
    required this.highlights,
  });

  final String id;
  final String title;
  final String focus;
  final int durationWeeks;
  final int assignedClients;
  final int dailyCalories;
  final List<String> highlights;
}

class ProgressPoint {
  const ProgressPoint({required this.label, required this.value});

  final String label;
  final double value;
}

class ClientProgress {
  const ClientProgress({
    required this.clientName,
    required this.metric,
    required this.trend,
    required this.points,
  });

  final String clientName;
  final String metric;
  final String trend;
  final List<ProgressPoint> points;
}

class Consultation {
  const Consultation({
    required this.id,
    required this.clientName,
    required this.startsAt,
    required this.topic,
    required this.status,
    required this.mode,
  });

  final String id;
  final String clientName;
  final DateTime startsAt;
  final String topic;
  final ConsultationStatus status;
  final String mode;
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.read,
    required this.category,
  });

  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool read;
  final String category;

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      read: read ?? this.read,
      category: category,
    );
  }
}

class ReportSummary {
  const ReportSummary({
    required this.title,
    required this.value,
    required this.delta,
    required this.positive,
  });

  final String title;
  final String value;
  final String delta;
  final bool positive;
}
