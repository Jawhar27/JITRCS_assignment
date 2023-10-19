import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/routes.dart' as router;
import 'package:jitrcs_assignment/presentation/providers/data_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value: DataProvider(),
          child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
      title: 'jitrcs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       debugShowCheckedModeBanner: false,
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: router.ScreenRoutes.toSplashScreen,
    ),
          ),
    );
  }
}


