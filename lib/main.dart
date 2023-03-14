import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/products_provider.dart';
import 'package:store_app/screens/product_details.dart';
import 'package:store_app/screens/product_overview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => Products()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen()
        },
      ),
    );
  }
}
