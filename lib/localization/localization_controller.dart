import 'package:motoboy/data/api_client.dart';
import 'package:motoboy/localization/language_model.dart';
import 'package:motoboy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

class LocalizationController extends GetxController  implements GetxService{
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale('pt', 'BR');
  bool _isLtr = true;
  int _selectIndex = 0;
  List<LanguageModel> _languages = [];
  bool isLoading = false;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int get selectIndex => _selectIndex;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    _isLtr = !intl.Bidi.isRtlLanguage(_locale.languageCode);
    saveLanguage(_locale);
    isLoading = true;
    update();
    Get.find<ApiClient>().updateHeader(sharedPreferences.getString(AppConstants.token)??'', sharedPreferences.getString(AppConstants.languageCode), 'latitude', 'longitude', sharedPreferences.getString(AppConstants.zoneId)??'');
    backendLanguageUpdate();
  }

  void loadCurrentLanguage() async {
    // Sempre definir português como idioma padrão
    _locale = Locale('pt', 'BR');
    _isLtr = !intl.Bidi.isRtlLanguage(_locale.languageCode);
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.countryCode, locale.countryCode!);
  }

  void setSelectIndex(int index) {
    _selectIndex = index;
    update();
  }

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
      update();
    } else {
      _selectIndex = -1;
      _languages = [];
      for (LanguageModel language in AppConstants.languages) {
        if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(language);
        }
      }
      update();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
    }
  }

  void setInitialIndex(){
    for(int i = 0; i < AppConstants.languages.length; i++){
      if(locale.languageCode == AppConstants.languages[i].languageCode){
        _selectIndex = i;
      }
    }
  }

  void backendLanguageUpdate(){
    Get.find<ApiClient>().postData(AppConstants.changeLanguage, {});
  }

  bool haveLocalLanguageCode() {
    // Sempre retornar true pois português está sempre configurado
    return true;
  }
}
