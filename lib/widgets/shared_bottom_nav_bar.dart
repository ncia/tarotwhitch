import 'package:flutter/material.dart';
import '../widgets/custom_image_icon.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';

class SharedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SharedBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const CustomImageIcon('assets/images/ic_meanings.png'),
          label: AppLocalizations.of(context)!.navReading,
        ),
        BottomNavigationBarItem(
          icon: const CustomImageIcon('assets/images/ic_chat.png'),
          label: AppLocalizations.of(context)!.navChat,
        ),
        BottomNavigationBarItem(
          icon: const CustomImageIcon('assets/images/ic_diary.png'),
          label: AppLocalizations.of(context)!.navDiary,
        ),
        BottomNavigationBarItem(
          icon: const CustomImageIcon('assets/images/ic_reading.png'),
          label: AppLocalizations.of(context)!.navMeanings,
        ),
        BottomNavigationBarItem(
          icon: const CustomImageIcon('assets/images/ic_account.png'),
          label: AppLocalizations.of(context)!.navMyMenu,
        ),
      ],
    );
  }
}
