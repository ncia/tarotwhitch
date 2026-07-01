import 'package:flutter/material.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_container.dart';
import '../services/deck_manager.dart';

class DeckSelectionScreen extends StatelessWidget {
  const DeckSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, localizations),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildDeckItem(
                      context,
                      deckId: 'rider_waite',
                      title: '라이더 웨이트 덱 (기본)',
                      description: '가장 널리 쓰이는 기본 타로카드입니다.',
                      imagePath: 'assets/images/00-TheFool.jpg',
                      isAvailable: true,
                    ),
                    const SizedBox(height: 16),
                    _buildDeckItem(
                      context,
                      deckId: 'marseille',
                      title: '마르세유 덱 (준비중)',
                      description: '고전적인 형태의 마르세유 덱입니다.',
                      imagePath: 'assets/images/temp/ic_meanings.png', // placeholder
                      isAvailable: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0, bottom: 12.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
            '타로 덱 설정',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeckItem(
    BuildContext context, {
    required String deckId,
    required String title,
    required String description,
    required String imagePath,
    required bool isAvailable,
  }) {
    return ValueListenableBuilder<String>(
      valueListenable: DeckManager.instance.currentDeckNotifier,
      builder: (context, currentDeck, child) {
        final isSelected = currentDeck == deckId;

        return GestureDetector(
          onTap: () {
            if (isAvailable && !isSelected) {
              DeckManager.instance.setDeck(deckId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title(으)로 변경되었습니다.')),
              );
            }
          },
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            borderRadius: 16,
            border: Border.all(
              color: isSelected ? Colors.amberAccent : Colors.white24,
              width: isSelected ? 2 : 1,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    width: 60,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 100,
                      color: Colors.white12,
                      child: const Icon(Icons.broken_image, color: Colors.white54),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isAvailable ? Colors.white : Colors.white54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          color: isAvailable ? Colors.white70 : Colors.white38,
                          fontSize: 14,
                        ),
                      ),
                      if (!isAvailable)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '업데이트 예정',
                            style: TextStyle(color: Colors.redAccent.shade100, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.amberAccent, size: 28),
              ],
            ),
          ),
        );
      },
    );
  }
}
