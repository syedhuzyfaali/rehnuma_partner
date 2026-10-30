import 'package:go_router/go_router.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/review_pending_screen.dart';
import '../features/jobs/presentation/screens/dashboard_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/jobs/presentation/screens/past_request_detail_screen.dart';
import '../features/jobs/presentation/screens/job_media_screen.dart';
import '../features/jobs/presentation/screens/on_way_screen.dart';
import '../features/communication/presentation/screens/chat_screen.dart';
import '../features/communication/presentation/screens/call_screen.dart';
import '../features/jobs/presentation/screens/job_in_progress_screen.dart';
import '../features/jobs/presentation/screens/bill_upload_screen.dart';
import '../features/jobs/presentation/screens/bill_payment_screen.dart';
import '../features/jobs/presentation/screens/payment_success_screen.dart';
import '../features/jobs/presentation/screens/job_rating_screen.dart';


class AppRoutes {
  static const splash = '/';
  static const register = '/register';
  static const reviewPending = '/review-pending';
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const pastRequests = '/past-requests';
  static const pastRequestDetail = '/past-requests/:id';
  static const jobMedia = '/jobs/:id/media';
  static const onWay = '/jobs/:id/on-way';
  static const chat = '/jobs/:id/chat';
  static const call = '/jobs/:id/call';
  static const jobInProgress = '/jobs/:id/in-progress';
  static const billUpload = '/jobs/:id/bill-upload';
  static const billPayment = '/jobs/:id/bill-payment';
  static const paymentSuccess = '/jobs/:id/payment-success';
  static const jobCompleteRating = '/jobs/:id/rating';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.reviewPending,
      builder: (context, state) => const ReviewPendingScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.pastRequestDetail,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1031';
        return PastRequestDetailScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.jobMedia,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return JobMediaScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.onWay,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return OnWayScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return ChatScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.call,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return CallScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.jobInProgress,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return JobInProgressScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.billUpload,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return BillUploadScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.billPayment,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return BillPaymentScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.paymentSuccess,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return PaymentSuccessScreen(jobId: jobId);
      },
    ),
    GoRoute(
      path: AppRoutes.jobCompleteRating,
      builder: (context, state) {
        final jobId = state.pathParameters['id'] ?? '1042';
        return JobRatingScreen(jobId: jobId);
      },
    ),
  ],
);