import 'package:elemental/core/services/api_service.dart';
import 'package:elemental/features/home/data/repo/home_repo.dart';
import 'package:elemental/features/home/data/repo/home_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepoImpl(getIt.get<ApiService>()));
}
