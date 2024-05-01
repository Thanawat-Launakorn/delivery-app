import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_application_1/domain/model/lang/lang.model.dart';
import 'package:flutter_application_1/l10n/translations.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  void onChangeLang(LanguageModel selectedLanguage) {
    emit(LanguageInitial(selectedLanguage: selectedLanguage));
  }
}
