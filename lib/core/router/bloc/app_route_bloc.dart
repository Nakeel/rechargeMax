import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_route_event.dart';
part 'app_route_state.dart';

/// BLoC responsible for managing the root application routing state.
/// It switches between GoRouter-based navigation and legacy Navigator-based
/// navigation based on incoming events.
class AppRouteBloc extends Bloc<AppRouteEvent, AppRouteState> {
  /// Initializes the AppRouteBloc with an initial state of using GoRouter.
  AppRouteBloc() : super(const AppRouteState(useGoRouter: true)) {
    // Register the event handler for ChangeAppRouteEvent
    on<ChangeAppRouteEvent>(_onChangeAppRoute);
    // Register the event handler for GoRouterPathNavigatedEvent
    on<GoRouterPathNavigatedEvent>(_onGoRouterPathNavigated);
  }

  /// Event handler for [ChangeAppRouteEvent].
  /// Emits a new [AppRouteState] with the updated [useGoRouter] flag
  /// and potentially a [pendingGoRouterPath].
  void _onChangeAppRoute(
      ChangeAppRouteEvent event,
      Emitter<AppRouteState> emit,
      ) {
    emit(state.copyWith(
      useGoRouter: event.useGoRouter,
      goToLogin: event.goToLogin,
      extras: event.extras,
      pendingGoRouterPath: event.useGoRouter ? event.targetGoRouterPath : null,
    ));
  }

  /// Event handler for [GoRouterPathNavigatedEvent].
  /// Clears the [pendingGoRouterPath] in the state after navigation has occurred.
  void _onGoRouterPathNavigated(
      GoRouterPathNavigatedEvent event,
      Emitter<AppRouteState> emit,
      ) {
    emit(state.copyWith(pendingGoRouterPath: null, extras: Map())); // Clear the path
  }
}