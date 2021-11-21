import 'package:flutterprovider/business_logic/models/currency.dart';
import 'package:flutterprovider/business_logic/models/rate.dart';

abstract class CurrencyService {
  Future<List<Rate>> getAllExchangeRates({required String base});

  Future<List<Currency>> getFavoriteCurrencies();

  Future<void> saveFavoriteCurrencies(List<Currency> data);
}