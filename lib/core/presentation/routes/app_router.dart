import 'package:auto_route/auto_route.dart';
import 'package:split_helper/features/auth/presentantion/auth_page.dart';
import 'package:split_helper/features/auth/presentantion/signin_page.dart';
import 'package:split_helper/features/settings/presentation/settings_page.dart';
import 'package:split_helper/features/splash/presentation/splash_page.dart';
import 'package:split_helper/features/split_list/presentation/splits_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: SplitsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
