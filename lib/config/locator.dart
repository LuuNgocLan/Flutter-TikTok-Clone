import 'package:get_it/get_it.dart';
import 'package:tiktok_clone/config/app_router.dart';

final getIt = GetIt.instance;
final appRouter = getIt<AppRouter>();

void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
