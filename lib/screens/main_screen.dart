import 'package:flutter/material.dart';
import 'spread_selection_screen.dart';
import 'chat_screen.dart';
import 'meanings_screen.dart';
import 'my_menu_screen.dart';
import '../widgets/custom_image_icon.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SpreadSelectionScreen(),
    const ChatScreen(),
    const MeaningsScreen(),
    const MyMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const CustomImageIcon('assets/images/ic_reading.png'),
            label: AppLocalizations.of(context)!.navReading,
          ),
          BottomNavigationBarItem(
            icon: const CustomImageIcon('assets/images/ic_chat.png'),
            label: AppLocalizations.of(context)!.navChat,
          ),
          BottomNavigationBarItem(
            icon: const CustomImageIcon('assets/images/ic_meanings.png'),
            label: AppLocalizations.of(context)!.navMeanings,
          ),
          BottomNavigationBarItem(
            icon: const CustomImageIcon('assets/images/ic_account.png'),
            label: AppLocalizations.of(context)!.navMyMenu,
          ),
        ],
      ),
    );
  }
}
