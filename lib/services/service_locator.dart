import 'package:flutterprovider/business_logic/view_models/calculate_screen_view_model.dart';
import 'package:flutterprovider/business_logic/view_models/choose_favorites_view_model.dart';
import 'package:get_it/get_it.dart';

import 'currency/currency_service.dart';
import 'currency/currency_service_implementation.dart';
import 'storage/storage_service.dart';
import 'storage/storage_service_implementation.dart';
import 'web_api/web_api.dart';
import 'web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());

  serviceLocator
      .registerFactory<CalculateScreenViewModel>(() => CalculateScreenViewModel());
  serviceLocator
      .registerFactory<ChooseFavoritesViewModel>(() => ChooseFavoritesViewModel());
}
