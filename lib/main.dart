// main.dart
import 'package:black_bull/core/di/core_providers.dart';
import 'package:black_bull/core/network/dio_client.dart';
import 'package:black_bull/core/router/router.dart';
import 'package:black_bull/data/repositories/movies_repository_imp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "secrets/.env");
  final apiKey = dotenv.env['TMB_API'];
  print("API KEY: $apiKey");
  runApp(const MovieExplorer());
}

class MovieExplorer extends StatelessWidget {
  const MovieExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: coreProviders,
      child: RepositoryProvider(
        create: (context) => MovieRepositoryImpl(
          context.read<DioClient>().dio,
        ), // Provide Dio instance here
        child: MaterialApp.router(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(brightness: Brightness.dark),
          routerConfig: router,
          title: 'Movie Explorer App',
        ),
      ),
    );
  }
}
