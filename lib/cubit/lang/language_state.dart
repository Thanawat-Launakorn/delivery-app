part of 'language_cubit.dart';

sealed class LanguageState {}

class LanguageInitial extends LanguageState {
  final LanguageModel selectedLanguage;
  static final List<LanguageModel> languages = [
    LanguageModel(
        local: const Locale('th'),
        flag: CountryFlag.fromCountryCode(
          'TH',
          width: 18,
          height: 18,
        ),
        text: 'th'),
    LanguageModel(
        local: const Locale('en'),
        flag: CountryFlag.fromCountryCode(
          'US',
          width: 18,
          height: 18,
        ),
        text: 'th')
  ];
  LanguageInitial({LanguageModel? selectedLanguage})
      : selectedLanguage = selectedLanguage ?? languages[1];
}

class LoadingLangState extends LanguageState {
  bool isLoading;
  LoadingLangState({required this.isLoading});
}
