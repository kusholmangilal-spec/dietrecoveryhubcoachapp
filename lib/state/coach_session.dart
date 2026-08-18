import 'package:flutter/foundation.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';

class CoachSession extends ChangeNotifier {
  CoachProfile? coach;
  bool isLoggedIn = false;
  String? password;

  List<Client> clients = MockRepository.clients();
  List<MealReview> meals = MockRepository.meals();
  List<DietPlan> plans = MockRepository.plans();
  List<ClientProgress> progress = MockRepository.progress();
  List<Consultation> consultations = MockRepository.consultations();
  List<AppNotification> notifications = MockRepository.notifications();
  List<ReportSummary> reports = MockRepository.reports();

  static const demoEmail = 'coach@dietrecoveryhub.com';
  static const demoPassword = 'Coach@123';

  int get pendingMealCount =>
      meals.where((m) => m.status == MealReviewStatus.pending).length;

  int get unreadCount => notifications.where((n) => !n.read).length;

  int get upcomingConsults =>
      consultations.where((c) => c.status == ConsultationStatus.upcoming).length;

  void register(CoachProfile profile, String newPassword) {
    coach = profile.copyWith(verificationStatus: VerificationStatus.pending);
    password = newPassword;
    isLoggedIn = false;
    notifyListeners();
  }

  void markUnderReview() {
    if (coach == null) return;
    coach = coach!.copyWith(verificationStatus: VerificationStatus.underReview);
    notifyListeners();
  }

  void approveCoach() {
    if (coach == null) return;
    coach = coach!.copyWith(verificationStatus: VerificationStatus.approved);
    notifyListeners();
  }

  String? login(String email, String pass) {
    final demoCoach = MockRepository.demoCoach();
    final isDemo = email.trim().toLowerCase() == demoEmail && pass == demoPassword;
    final isRegistered = coach != null &&
        email.trim().toLowerCase() == coach!.email.toLowerCase() &&
        pass == password;

    if (isDemo) {
      coach ??= demoCoach;
      if (coach!.verificationStatus != VerificationStatus.approved) {
        coach = coach!.copyWith(verificationStatus: VerificationStatus.approved);
      }
      isLoggedIn = true;
      notifyListeners();
      return null;
    }

    if (!isRegistered) {
      return 'Email or password is incorrect.';
    }
    if (coach!.verificationStatus != VerificationStatus.approved) {
      return 'Your account is still awaiting admin verification.';
    }
    isLoggedIn = true;
    notifyListeners();
    return null;
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  void updateMeal(String id, MealReviewStatus status) {
    meals = [
      for (final meal in meals)
        if (meal.id == id) meal.copyWith(status: status) else meal,
    ];
    notifyListeners();
  }

  void markAllNotificationsRead() {
    notifications = [for (final n in notifications) n.copyWith(read: true)];
    notifyListeners();
  }

  void updateProfile({
    required String phone,
    required String bio,
    required String specialization,
  }) {
    if (coach == null) return;
    coach = CoachProfile(
      fullName: coach!.fullName,
      email: coach!.email,
      phone: phone,
      credentials: coach!.credentials,
      specialization: specialization,
      yearsExperience: coach!.yearsExperience,
      licenseId: coach!.licenseId,
      bio: bio,
      verificationStatus: coach!.verificationStatus,
    );
    notifyListeners();
  }
}
