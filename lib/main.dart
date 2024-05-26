import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathernews_app/pages/login_page.dart';
import 'package:weathernews_app/services/bigdata_cloud_services.dart';

void main() {
  runApp(Provider(
    create: (context) => BigDataCloudService.create(),
    dispose: (context, BigDataCloudService service) => service.client.dispose() ,
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     home: LoginPage(),
      
    );
  }
}

