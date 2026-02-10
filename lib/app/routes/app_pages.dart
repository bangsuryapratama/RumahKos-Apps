import 'package:get/get.dart';
import 'package:rumahkosapps/app/modules/profile/bindings/profile_binding.dart';
import 'package:rumahkosapps/app/modules/profile/views/profile_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/main_nav/bindings/main_nav_binding.dart';
import '../modules/main_nav/views/main_nav_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.MAIN_NAV,
      page: () =>  MainNavView(),
      binding: MainNavBinding(),
    ),

    GetPage(
      name: Routes.PROFILE,
      page: () =>  ProfileView(),
      binding: ProfileBinding(),
    )
  ];
}
