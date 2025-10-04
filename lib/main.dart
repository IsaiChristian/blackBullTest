// main.dart
import 'package:black_bull/core/di/core_providers.dart';
import 'package:black_bull/core/error/logger_service.dart';
import 'package:black_bull/core/network/dio_client.dart';
import 'package:black_bull/core/router/router.dart';
import 'package:black_bull/data/repositories/movies_repository_imp.dart';
import 'package:black_bull/src/app/bloc/app_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "secrets/.env");
  FlutterError.onError = (details) {
    LoggerService.error("Global", details.exceptionAsString(), details.stack);
  };
  runApp(const MovieExplorer());
}

class MovieExplorer extends StatelessWidget {
  const MovieExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is! AppInitial) {
            return MaterialApp(
              themeMode: .dark,
              darkTheme: ThemeData(brightness: .dark),
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/BlackBull_w.svg',
                        height: 32,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Blocking Error: \n${state.runtimeType} - $state",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
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
        },
      ),
    );
  }
}
