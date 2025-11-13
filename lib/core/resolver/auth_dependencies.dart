
import 'package:get_it/get_it.dart';

import 'init_dependencies.dart';

// GetIt getAuthDependencies() {
  // return serviceLocator
  //   ..registerFactory<AuthRemoteDataSource>(
  //     () => AuthRemoteDataSourceImpl(  apiClient: serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory<AuthRepository>(
  //     () => AuthRepositoryImpl(
  //       remote: serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //     () => GetUserProfileUseCase(
  //        serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => ContactUsUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => GetMarketplaceEligibilityUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => GetVisitorSourceUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => LoginUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => LogoutUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => RefreshTokenUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => RequestPasswordResetUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => ResendOtpUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => SignupUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => ValidateResetOtpUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => ValidateSignupOtpUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => DeleteUserProfileUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => DeleteUserProfilePicUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => GetUserRentDueDateUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => UpdateUserRentDueDateUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => UpdateUserProfileUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => UpdateUserProfilePicUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //   ..registerFactory(
  //         () => GetUserMarketPlaceCreditsUseCase(
  //       serviceLocator(),
  //     ),
  //   )
  //
  //
  //   ..registerLazySingleton(
  //     () => AuthBloc(getMarketplaceEligibilityUseCase: serviceLocator(),
  //       getUserProfileUseCase: serviceLocator(),
  //       contactUsUseCase: serviceLocator(),
  //       refreshTokenUseCase: serviceLocator(),
  //       requestPasswordResetUseCase: serviceLocator(),
  //       resendOtpUseCase: serviceLocator(),
  //       signupUseCase: serviceLocator(),
  //       getVisitorSourceUseCase: serviceLocator(),
  //       loginUseCase: serviceLocator(),
  //       logoutUseCase: serviceLocator(),
  //       validateResetOtpUseCase: serviceLocator(),
  //       validateSignupOtpUseCase: serviceLocator(),
  //       deleteUserProfilePicUseCase: serviceLocator(),
  //       deleteUserProfileUseCase: serviceLocator(),
  //       getUserRentDueDateUseCase: serviceLocator(),
  //       updateUserProfilePicUseCase: serviceLocator(),
  //       updateUserProfileUseCase: serviceLocator(),
  //       updateUserRentDueDateUseCase: serviceLocator(),
  //       getUserMarketPlaceCreditsUseCase: serviceLocator()
  //     ),
  //   );
// }