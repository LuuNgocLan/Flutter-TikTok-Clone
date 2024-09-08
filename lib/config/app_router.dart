import 'package:auto_route/auto_route.dart';
import 'package:tiktok_clone/config/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ProfileRoute.page, initial: true),
      ];
}
