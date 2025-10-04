import 'package:black_bull/core/network/dio_client.dart';
import 'package:black_bull/core/services/local_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> coreProviders = [
  Provider<DioClient>(create: (_) => DioClient()),
  Provider<LocalStorageService>(create: (_) => LocalStorageService()),
];
