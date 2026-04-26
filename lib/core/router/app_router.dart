import 'package:auto_route/auto_route.dart';

import '../../features/auth/presentation/auth_page.dart';
import '../../features/home/presentation/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino(); 

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];
}
