import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_container.dart';
import '../services/economy_service.dart';
import '../widgets/shared_bottom_nav_bar.dart';
import '../widgets/top_floating_icons.dart';
import 'main_screen.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GrowthScreen extends StatefulWidget {
  const GrowthScreen({super.key});

  @override
  State<GrowthScreen> createState() => _GrowthScreenState();
}

class _GrowthScreenState extends State<GrowthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 10),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.growthTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.growthSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 24),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.amberAccent,
                          labelColor: Colors.amberAccent,
                          unselectedLabelColor: Colors.white54,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.lens_blur),
                                  const SizedBox(width: 8),
                                  Text(AppLocalizations.of(context)!.growthTabCrystalBall),
                                  const SizedBox(width: 32),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.menu_book),
                                  const SizedBox(width: 8),
                                  const Text('마법책 강화'), // AppLocalizations.of(context)!.growthTabWorldTree 대신 하드코딩
                                  const SizedBox(width: 32),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        _CrystalBallTab(),
                        _MagicBookTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: TopFloatingIcons(
                onGrowth: () {}, // 이미 성장 화면이므로 동작 안 함
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SharedBottomNavBar(
        currentIndex: mainScreenKey.currentState?.currentIndex ?? 0,
        onTap: (index) {
          mainScreenKey.currentState?.switchTab(index);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}

class _MagicBookTab extends StatefulWidget {
  const _MagicBookTab();

  @override
  State<_MagicBookTab> createState() => _MagicBookTabState();
}

class _MagicBookTabState extends State<_MagicBookTab> {
  bool _isEnhancing = false;

  void _enhanceBook() async {
    setState(() {
      _isEnhancing = true;
    });
    await EconomyService().addWorldTreeExp(10); // 임시로 worldTreeExp를 사용합니다.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('마법책의 지식이 깊어졌습니다! Exp +10')),
      );
      setState(() {
        _isEnhancing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: EconomyService(),
      builder: (context, _) {
        final exp = EconomyService().worldTreeExp;
        final level = (exp / 50).floor() + 1;
        final progress = (exp % 50) / 50.0;

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('마법책 레벨 $level', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/magic_book.png',
                        width: 150 + (level * 5).clamp(0, 100).toDouble(),
                        height: 150 + (level * 5).clamp(0, 100).toDouble(),
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white24,
                              color: Colors.blueAccent,
                              minHeight: 12,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            const SizedBox(height: 8),
                            Text('지식: ${exp % 50} / 50', style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: _isEnhancing ? null : _enhanceBook,
                        icon: const Icon(Icons.auto_awesome),
                        label: const Text('마법책 읽기 (무료)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CrystalBallTab extends StatefulWidget {
  const _CrystalBallTab();

  @override
  State<_CrystalBallTab> createState() => _CrystalBallTabState();
}

class _CrystalBallTabState extends State<_CrystalBallTab> {
  bool _isUpgrading = false;

  void _upgradeBall() async {
    final success = await EconomyService().upgradeCrystalBall(10);
    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.growthUpgradeSuccess)),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.growthUpgradeNotEnough)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: EconomyService(),
      builder: (context, _) {
        final exp = EconomyService().crystalBallExp;
        final dust = EconomyService().magicDust;
        final displayLevel = (exp / 50).floor() + 1;
        final progress = (exp % 50) / 50.0;
        final hexColor = Color(0xFF000000 + exp);
        final hexString = '#${exp.toRadixString(16).padLeft(6, '0').toUpperCase()}';

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.growthCrystalBallLevel(displayLevel), style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white24,
                      color: Colors.purpleAccent,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 8),
                    Text('마력: ${exp % 50} / 50', style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _isUpgrading ? null : _upgradeBall,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 색상 오버레이를 이미지 뒤에 배치하여 유리 반사 효과를 살림
                    Positioned(
                      top: 44, // 윗부분 1픽셀 추가 축소를 위해 내림
                      child: IgnorePointer(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 122, // 1픽셀 추가 축소
                          height: 122,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hexColor.withOpacity(0.8), // 그림자 렌더링으로 인해 삐져나오는 현상 방지를 위해 그림자 완전 제거
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/crystal_ball.png',
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  // 개발 테스트용: 마력의 가루 1000개 충전
                  EconomyService().addMagicDust(1000);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('개발용: 마력의 가루 1000개 충전 완료!')));
                },
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  borderRadius: 20,
                  child: Text(
                    AppLocalizations.of(context)!.growthDustOwned(exp * 10),
                    style: const TextStyle(color: Colors.purpleAccent, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _isUpgrading ? null : _upgradeBall,
                icon: const Icon(Icons.auto_awesome),
                label: Text(AppLocalizations.of(context)!.growthUpgradeButton),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
