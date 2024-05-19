import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/lang/lang.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/domain/cubit/lang/language_cubit.dart';

class ChangeLangModal extends StatelessWidget {
  const ChangeLangModal({super.key});

  void onSelectedLanguage(BuildContext context, LanguageModel languages) {
    context.read<LanguageCubit>().onChangeLang(languages);
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(translations(context)!.changeLang, style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                if (state is LanguageInitial) {
                  final languages = LanguageInitial.languages;
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final selectedLanguage = languages[index].local ==
                            state.selectedLanguage.local;

                        return ListTile(
                          onTap: () {
                            onSelectedLanguage(context, languages[index]);
                          },
                          leading: languages[index].flag,
                          title: Text(languages[index].text),
                          trailing: selectedLanguage
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: selectedLanguage
                                  ? const BorderSide(color: Colors.green)
                                  : BorderSide(color: Colors.grey[300]!)),
                          tileColor: selectedLanguage
                              ? Colors.green.withOpacity(.05)
                              : null,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                      itemCount: languages.length);
                } else {
                  return const Placeholder();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
