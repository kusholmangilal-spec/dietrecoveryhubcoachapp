import '../models/models.dart';

class MockRepository {
  static CoachProfile demoCoach() {
    return const CoachProfile(
      fullName: 'Dr. Maya Ellison',
      email: 'coach@dietrecoveryhub.com',
      phone: '+1 (415) 555-0148',
      credentials: 'RD, CDN',
      specialization: 'Diet recovery & metabolic restoration',
      yearsExperience: 8,
      licenseId: 'RD-88421',
      bio:
          'Registered dietitian helping clients rebuild a peaceful relationship with food after restriction, yo-yo dieting, and burnout.',
      verificationStatus: VerificationStatus.approved,
    );
  }

  static List<Client> clients() {
    final now = DateTime.now();
    return [
      Client(
        id: 'c1',
        name: 'Avery Chen',
        goal: 'Restore regular meals',
        plan: 'Foundation Reset',
        adherence: 86,
        status: 'On track',
        lastCheckIn: now.subtract(const Duration(hours: 5)),
        energyScore: 8,
        mealsLogged: 18,
        notes: 'Fear foods expanding. Breakfast still skipped twice this week.',
      ),
      Client(
        id: 'c2',
        name: 'Jordan Blake',
        goal: 'Stabilize energy',
        plan: 'Metabolic Rebuild',
        adherence: 72,
        status: 'Needs support',
        lastCheckIn: now.subtract(const Duration(days: 1)),
        energyScore: 5,
        mealsLogged: 12,
        notes: 'Afternoon crashes. Requested extra snack ideas for work days.',
      ),
      Client(
        id: 'c3',
        name: 'Sam Rivera',
        goal: 'Reduce all-or-nothing eating',
        plan: 'Flexible Fueling',
        adherence: 91,
        status: 'Thriving',
        lastCheckIn: now.subtract(const Duration(hours: 2)),
        energyScore: 9,
        mealsLogged: 21,
        notes: 'Weekend social meals going well. Keep celebrating wins.',
      ),
      Client(
        id: 'c4',
        name: 'Priya Nair',
        goal: 'Rebuild hunger cues',
        plan: 'Foundation Reset',
        adherence: 64,
        status: 'Watch',
        lastCheckIn: now.subtract(const Duration(days: 3)),
        energyScore: 4,
        mealsLogged: 9,
        notes: 'Travel week. Needs a simplified 3-meal template.',
      ),
    ];
  }

  static List<MealReview> meals() {
    final now = DateTime.now();
    return [
      MealReview(
        id: 'm1',
        clientName: 'Avery Chen',
        mealName: 'Breakfast — oats, yogurt, berries',
        loggedAt: now.subtract(const Duration(hours: 3)),
        notes: 'Ate at desk. Felt rushed but finished the bowl.',
        status: MealReviewStatus.pending,
        calories: 420,
      ),
      MealReview(
        id: 'm2',
        clientName: 'Jordan Blake',
        mealName: 'Lunch — rice bowl with chicken',
        loggedAt: now.subtract(const Duration(hours: 6)),
        notes: 'Skipped sauce from fear of oil. Still hungry after.',
        status: MealReviewStatus.pending,
        calories: 510,
      ),
      MealReview(
        id: 'm3',
        clientName: 'Priya Nair',
        mealName: 'Snack — apple only',
        loggedAt: now.subtract(const Duration(hours: 8)),
        notes: 'Intended as a full snack; protein missing.',
        status: MealReviewStatus.pending,
        calories: 95,
      ),
      MealReview(
        id: 'm4',
        clientName: 'Sam Rivera',
        mealName: 'Dinner — pasta with friends',
        loggedAt: now.subtract(const Duration(days: 1)),
        notes: 'Enjoyed the meal without compensation. Great recovery win.',
        status: MealReviewStatus.approved,
        calories: 780,
      ),
    ];
  }

  static List<DietPlan> plans() {
    return const [
      DietPlan(
        id: 'p1',
        title: 'Foundation Reset',
        focus: '3 meals + 1 snack, no skipping',
        durationWeeks: 6,
        assignedClients: 2,
        dailyCalories: 2200,
        highlights: ['Regular eating', 'Fear-food exposure', 'Hydration cues'],
      ),
      DietPlan(
        id: 'p2',
        title: 'Metabolic Rebuild',
        focus: 'Restore energy and training fuel',
        durationWeeks: 8,
        assignedClients: 1,
        dailyCalories: 2500,
        highlights: ['Pre/post workout fuel', 'Carbs at each meal', 'Sleep support'],
      ),
      DietPlan(
        id: 'p3',
        title: 'Flexible Fueling',
        focus: 'Social eating and permission',
        durationWeeks: 4,
        assignedClients: 1,
        dailyCalories: 2300,
        highlights: ['Restaurant scripts', 'Satisfaction check-ins', 'Weekend structure'],
      ),
    ];
  }

  static List<ClientProgress> progress() {
    return const [
      ClientProgress(
        clientName: 'Avery Chen',
        metric: 'Meals completed / week',
        trend: '+3 vs last week',
        points: [
          ProgressPoint(label: 'W1', value: 12),
          ProgressPoint(label: 'W2', value: 14),
          ProgressPoint(label: 'W3', value: 16),
          ProgressPoint(label: 'W4', value: 18),
        ],
      ),
      ClientProgress(
        clientName: 'Jordan Blake',
        metric: 'Energy score',
        trend: 'Stable, low afternoons',
        points: [
          ProgressPoint(label: 'W1', value: 4),
          ProgressPoint(label: 'W2', value: 5),
          ProgressPoint(label: 'W3', value: 5),
          ProgressPoint(label: 'W4', value: 6),
        ],
      ),
      ClientProgress(
        clientName: 'Sam Rivera',
        metric: 'Fear-food exposures',
        trend: '+2 this week',
        points: [
          ProgressPoint(label: 'W1', value: 1),
          ProgressPoint(label: 'W2', value: 2),
          ProgressPoint(label: 'W3', value: 3),
          ProgressPoint(label: 'W4', value: 4),
        ],
      ),
    ];
  }

  static List<Consultation> consultations() {
    final now = DateTime.now();
    return [
      Consultation(
        id: 's1',
        clientName: 'Avery Chen',
        startsAt: now.add(const Duration(hours: 4)),
        topic: 'Breakfast consistency',
        status: ConsultationStatus.upcoming,
        mode: 'Video',
      ),
      Consultation(
        id: 's2',
        clientName: 'Jordan Blake',
        startsAt: now.add(const Duration(days: 1, hours: 2)),
        topic: 'Workday snacks',
        status: ConsultationStatus.upcoming,
        mode: 'Phone',
      ),
      Consultation(
        id: 's3',
        clientName: 'Sam Rivera',
        startsAt: now.subtract(const Duration(days: 2)),
        topic: 'Social meal debrief',
        status: ConsultationStatus.completed,
        mode: 'Video',
      ),
    ];
  }

  static List<AppNotification> notifications() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 'n1',
        title: 'Meal waiting for review',
        body: 'Jordan Blake logged lunch and asked for feedback on fats.',
        createdAt: now.subtract(const Duration(minutes: 40)),
        read: false,
        category: 'Meals',
      ),
      AppNotification(
        id: 'n2',
        title: 'Consultation in 4 hours',
        body: 'Avery Chen — Breakfast consistency (video).',
        createdAt: now.subtract(const Duration(hours: 1)),
        read: false,
        category: 'Sessions',
      ),
      AppNotification(
        id: 'n3',
        title: 'Weekly report ready',
        body: 'Adherence across your caseload improved 6% this week.',
        createdAt: now.subtract(const Duration(hours: 6)),
        read: true,
        category: 'Reports',
      ),
    ];
  }

  static List<ReportSummary> reports() {
    return const [
      ReportSummary(title: 'Active clients', value: '4', delta: '+1 this month', positive: true),
      ReportSummary(title: 'Avg. meal adherence', value: '78%', delta: '+6% vs last week', positive: true),
      ReportSummary(title: 'Pending reviews', value: '3', delta: 'Respond within 12h', positive: false),
      ReportSummary(title: 'Session completion', value: '96%', delta: 'On time this month', positive: true),
    ];
  }
}
