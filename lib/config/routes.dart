import 'package:flutter/material.dart';
import 'package:jitrcs_assignment/models/transaction.dart';
import 'package:jitrcs_assignment/presentation/pages/home/home_screen.dart';
import 'package:jitrcs_assignment/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:jitrcs_assignment/presentation/pages/splash_screen.dart';
import 'package:jitrcs_assignment/presentation/pages/transaction_detail_screen.dart';

class ScreenRoutes {
  static const String toSplashScreen = "toSplashScreen";
  static const String toHomeScreen = "toHomeScreen";
  static const String toSignInScreen = "toSignInScreen";
  static const String toTransactionDetailScreen = "toTransactionDetailScreen";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case ScreenRoutes.toSplashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case ScreenRoutes.toSignInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case ScreenRoutes.toHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case ScreenRoutes.toTransactionDetailScreen:
        var data = (settings.arguments ?? {}) as Map;
        Transaction transaction = data['transaction'];
        return MaterialPageRoute(
          builder: (_) => TransactionDetailScreen(
            transaction: transaction,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
