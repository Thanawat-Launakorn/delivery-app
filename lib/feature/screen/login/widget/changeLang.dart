import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/l10n/translations.dart';
import 'package:flutter_application_1/cubit/lang/language_cubit.dart';

class ChangeLangModal extends StatelessWidget {
  const ChangeLangModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(translations(context)!.changeLang),
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
                            context
                                .read<LanguageCubit>()
                                .onChangeLang(languages[index]);
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) => Navigator.of(context).pop());
                          },
                          leading: languages[index].flag,
                          title: Text(languages[index].text),
                          trailing: selectedLanguage
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.blue,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: selectedLanguage
                                  ? BorderSide(color: Colors.blue)
                                  : BorderSide(color: Colors.grey[300]!)),

                          tileColor: selectedLanguage ? Colors.yellow.withOpacity(.05) : null,
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
