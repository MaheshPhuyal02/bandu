import 'package:auto_route/auto_route.dart';
import 'package:bandu/screens/task/subtask_details/subtask_details_view.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: Get_startedRoute.page),
        AutoRoute(page: Complete_profileRoute.page),
        AutoRoute(page: HomeMainRoute.page),
        AutoRoute(page: GuideRoute.page),
        AutoRoute(page: SelectProjectRoute.page),
        AutoRoute(page: AddTaskRoute.page),
        AutoRoute(page: TaskDetailsRoute.page),
        AutoRoute(page: Subtask_detailsRoute.page),
      ];
}
