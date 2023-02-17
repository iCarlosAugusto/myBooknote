import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/pages/subject_page/subject_page.dart';
import 'package:mybooknote/routes/global_context.dart';

import '../pages/home.dart';

final GoRouter router = GoRouter(
  navigatorKey: GlobalContext.navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
    ),
    GoRoute(
      path: '/subject/:subjectID',
      name: '/subject',
      builder: (BuildContext context, GoRouterState state) {
        return SubjectPage(
          subjectID: state.params["subjectID"]!
        );
      },
    ),
  ],
);
