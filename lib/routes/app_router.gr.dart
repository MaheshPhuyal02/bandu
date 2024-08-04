// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:bandu/screens/add_task/add_task_view.dart' as _i1;
import 'package:bandu/screens/complete_profile/complete_profile_view.dart'
    as _i2;
import 'package:bandu/screens/get_started/get_started_view.dart' as _i3;
import 'package:bandu/screens/guide/guide_screen.dart' as _i4;
import 'package:bandu/screens/home/home_main.dart' as _i5;
import 'package:bandu/screens/login/login_view.dart' as _i6;
import 'package:bandu/screens/register/register_view.dart' as _i7;
import 'package:bandu/screens/select_project/select_project_view.dart' as _i8;
import 'package:bandu/screens/splash/splash_view.dart' as _i9;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AddTaskRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddTaskPage(),
      );
    },
    Complete_profileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.Complete_profilePage(),
      );
    },
    Get_startedRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.Get_startedPage(),
      );
    },
    GuideRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GuidePage(),
      );
    },
    HomeMainRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.HomeMainPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.RegisterPage(),
      );
    },
    SelectProjectRoute.name: (routeData) {
      final args = routeData.argsAs<SelectProjectRouteArgs>(
          orElse: () => const SelectProjectRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SelectProjectPage(
          key: args.key,
          canGoBack: args.canGoBack,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddTaskPage]
class AddTaskRoute extends _i10.PageRouteInfo<void> {
  const AddTaskRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AddTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Complete_profilePage]
class Complete_profileRoute extends _i10.PageRouteInfo<void> {
  const Complete_profileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          Complete_profileRoute.name,
          initialChildren: children,
        );

  static const String name = 'Complete_profileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Get_startedPage]
class Get_startedRoute extends _i10.PageRouteInfo<void> {
  const Get_startedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          Get_startedRoute.name,
          initialChildren: children,
        );

  static const String name = 'Get_startedRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.GuidePage]
class GuideRoute extends _i10.PageRouteInfo<void> {
  const GuideRoute({List<_i10.PageRouteInfo>? children})
      : super(
          GuideRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuideRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeMainPage]
class HomeMainRoute extends _i10.PageRouteInfo<void> {
  const HomeMainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeMainRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SelectProjectPage]
class SelectProjectRoute extends _i10.PageRouteInfo<SelectProjectRouteArgs> {
  SelectProjectRoute({
    _i11.Key? key,
    bool canGoBack = true,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SelectProjectRoute.name,
          args: SelectProjectRouteArgs(
            key: key,
            canGoBack: canGoBack,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectProjectRoute';

  static const _i10.PageInfo<SelectProjectRouteArgs> page =
      _i10.PageInfo<SelectProjectRouteArgs>(name);
}

class SelectProjectRouteArgs {
  const SelectProjectRouteArgs({
    this.key,
    this.canGoBack = true,
  });

  final _i11.Key? key;

  final bool canGoBack;

  @override
  String toString() {
    return 'SelectProjectRouteArgs{key: $key, canGoBack: $canGoBack}';
  }
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
