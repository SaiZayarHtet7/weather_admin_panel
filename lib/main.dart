import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_admin_panel/api/api.dart';
import 'package:weather_admin_panel/bloc/noti_bloc.dart';
import 'package:weather_admin_panel/presentation/app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotiBloc>(
      create: (context) => NotiBloc(Api()),
      child: const MaterialApp(
        title: "Admin dashboard",
        debugShowCheckedModeBanner: false,
        home: AppPage(),
      ),
    );
  }
}
