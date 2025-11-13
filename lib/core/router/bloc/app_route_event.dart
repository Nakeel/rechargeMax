part of 'app_route_bloc.dart';

/// Base class for all AppRoute events.
abstract class AppRouteEvent extends Equatable {
  const AppRouteEvent();

  @override
  List<Object> get props => [];
}

/// Event to change the root application type.
/// [useGoRouter] true if the app should use GoRouter, false for legacy Navigator.
/// [targetGoRouterPath] The specific path to navigate to in GoRouter once it's active.
/// Only relevant when [useGoRouter] is true.
class ChangeAppRouteEvent extends AppRouteEvent {
  final bool useGoRouter;
  final String? targetGoRouterPath;
  final bool goToLogin;
  final Map<String, dynamic>? extras;

  const ChangeAppRouteEvent(this.useGoRouter, {this.targetGoRouterPath, this.goToLogin = false, this.extras});

  @override
  List<Object> get props => [useGoRouter, targetGoRouterPath ?? '', goToLogin, extras??{}];
}

/// Event to signal that the GoRouter has navigated to the pending target path.
/// This is used internally to clear the pending path from the state.
class GoRouterPathNavigatedEvent extends AppRouteEvent {
  const GoRouterPathNavigatedEvent();
}
