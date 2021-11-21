import 'package:flutterprovider/business_logic/models/currency.dart';
import 'package:flutterprovider/business_logic/models/rate.dart';
import 'package:flutterprovider/services/storage/storage_service.dart';
import 'package:flutterprovider/services/web_api/web_api.dart';

import '../service_locator.dart';
import 'currency_service.dart';

class CurrencyServiceImpl implements CurrencyService {
  final WebApi _webApi = serviceLocator<WebApi>();
  final StorageService _storageService = serviceLocator<StorageService>();

  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  @override
  Future<List<Rate>> getAllExchangeRates({String? base}) async {
    List<Rate> webData = await _webApi.fetchExchangeRates();
    if (base != null) {
      return _convertBaseCurrency(base, webData);
    }
    return webData;
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    final favorites = await _storageService.getFavoriteCurrencies();
    if (favorites.isEmpty || favorites.length <= 1) {
      return defaultFavorites;
    }
    return favorites;
  }

  List<Rate> _convertBaseCurrency(String base, List<Rate> remoteData) {
    if (remoteData[0].baseCurrency == base) {
      return remoteData;
    }
    double divisor =
        remoteData.firstWhere((rate) => rate.quoteCurrency == base).exchangeRate;
    return remoteData.map((rate) => Rate(
      baseCurrency: base,
      quoteCurrency: rate.quoteCurrency,
      exchangeRate: rate.exchangeRate / divisor,
    )).toList();
  }

  @override
  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    if (data.isEmpty) {
      return;
    }
    await _storageService.saveFavoriteCurrencies(data);
  }
}
