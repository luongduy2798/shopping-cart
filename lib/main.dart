import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart';
import 'package:shoppingcart/data/database_helper.dart';
import 'package:shoppingcart/pages/splash/splash_screen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  await DatabaseHelper.instant.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes().themData(context),
          home: const SplashScreen(),
          builder: (context, child) {
            return child ?? const SizedBox();
          },
        ),
      ),
    );
  }
}
