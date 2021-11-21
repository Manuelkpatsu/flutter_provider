import 'package:flutter/foundation.dart';
import 'package:flutterprovider/business_logic/models/currency.dart';
import 'package:flutterprovider/services/currency/currency_service.dart';
import 'package:flutterprovider/services/service_locator.dart';

class ChooseFavoritesViewModel extends ChangeNotifier {
  // 3
  final CurrencyService _currencyService = serviceLocator<CurrencyService>();

  final List<FavoritePresentation> _choices = [];
  final List<Currency> _favorites = [];

  // 4
  List<FavoritePresentation> get choices => _choices;

  void loadData() async {
    // ...

    // 5
    notifyListeners();
  }

  void toggleFavoriteStatus(int choiceIndex) {
    // ...

    // 5
    notifyListeners();
  }
}

class FavoritePresentation {
  final String flag;
  final String alphabeticCode;
  final String longName;
  bool isFavorite;

  FavoritePresentation({
    required this.flag,
    required this.alphabeticCode,
    required this.longName,
    required this.isFavorite,
  });
}
