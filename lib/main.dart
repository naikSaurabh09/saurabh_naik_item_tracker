import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saurabh_naik_item_tracker/providers/item_listing_provider.dart';
import 'package:saurabh_naik_item_tracker/screen/item_listing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsListingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Item tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ItemListingScreen(),
      ),
    );
  }
}
