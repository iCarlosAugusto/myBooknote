import 'package:flutter/material.dart';
import 'package:mybooknote/database/db.dart';
import 'package:mybooknote/database/repositories/subjects/implemtations/subject_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:mybooknote/routes/routes.dart';

final getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<DB>(DB(), signalsReady: true);
  getIt.registerSingleton<SubjectRepository>(SubjectRepository(), signalsReady: true);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
