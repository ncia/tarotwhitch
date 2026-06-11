import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';

class MyMenuScreen extends StatelessWidget {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.navMyMenu,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
