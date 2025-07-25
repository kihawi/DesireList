import 'package:auto_route/auto_route.dart';
import 'package:flutter_projects/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: AddDesireRoute.page, path: 'add'),
        AutoRoute(page: StatsRoute.page, path: 'stats'),
      ],
    ),
  ];
}
