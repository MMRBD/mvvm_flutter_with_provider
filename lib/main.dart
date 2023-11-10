import 'package:flutter/material.dart';
import 'package:mvvm_provider_flutter/view/auth/auth_view_model.dart';
import 'package:mvvm_provider_flutter/view/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes.dart';
import '../utils/routes/routes_names.dart';
import '../viewModel/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: MaterialApp(
          title: 'MVVM Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.login,
          onGenerateRoute: Routes.generateRoutes,
        ),
      ),
    );
  }
}
