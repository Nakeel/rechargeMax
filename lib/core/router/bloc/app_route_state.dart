part of 'app_route_bloc.dart';


/// Represents the current routing configuration state of the application.
/// It uses a single concrete class with a `copyWith` method for immutability.
class AppRouteState extends Equatable {
  final bool useGoRouter;
  // This path is set when switching to GoRouter and needs to be navigated to.
  // It should be cleared after navigation to prevent re-navigation on rebuilds.
  final String? pendingGoRouterPath;
  final bool goToLogin;
  final String message; // Added for potential state messages
  final String error;   // Added for potential state errors
  final Map<String, dynamic>? extras;

  const AppRouteState({
    this.useGoRouter = true,
    this.goToLogin = false,
    this.pendingGoRouterPath,
    this.message = '',
    this.error = '',
    this.extras
  });

  @override
  List<Object?> get props => [useGoRouter, pendingGoRouterPath, message, error, goToLogin, extras];

  /// Creates a copy of this state with potentially updated values.
  AppRouteState copyWith({
    bool? useGoRouter,
    String? pendingGoRouterPath,
    String? message,
    bool? goToLogin,
    String? error,
    Map<String, dynamic>? extras
  }) {
    return AppRouteState(
      useGoRouter: useGoRouter ?? this.useGoRouter,
      pendingGoRouterPath: pendingGoRouterPath, // Nullable, so no ?? for clearing
      message: message ?? this.message,
      error: error ?? this.error,
      goToLogin: goToLogin ?? this.goToLogin,
      extras: extras ?? this.extras
    );
  }
}
