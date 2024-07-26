// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:bandu/screens/complete_profile/complete_profile_view.dart'
    as _i1;
import 'package:bandu/screens/get_started/get_started_view.dart' as _i2;
import 'package:bandu/screens/home/home_main.dart' as _i3;
import 'package:bandu/screens/login/login_view.dart' as _i4;
import 'package:bandu/screens/register/register_view.dart' as _i5;
import 'package:bandu/screens/splash/splash_view.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    Complete_profileRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.Complete_profilePage(),
      );
    },
    Get_startedRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.Get_startedPage(),
      );
    },
    HomeMainRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomeMainPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.RegisterPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.Complete_profilePage]
class Complete_profileRoute extends _i7.PageRouteInfo<void> {
  const Complete_profileRoute({List<_i7.PageRouteInfo>? children})
      : super(
          Complete_profileRoute.name,
          initialChildren: children,
        );

  static const String name = 'Complete_profileRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Get_startedPage]
class Get_startedRoute extends _i7.PageRouteInfo<void> {
  const Get_startedRoute({List<_i7.PageRouteInfo>? children})
      : super(
          Get_startedRoute.name,
          initialChildren: children,
        );

  static const String name = 'Get_startedRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeMainPage]
class HomeMainRoute extends _i7.PageRouteInfo<void> {
  const HomeMainRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeMainRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
