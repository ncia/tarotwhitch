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
import '../widgets/sliver_tab_bar_delegate.dart';

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
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
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
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverTabBarDelegate(
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
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: const [
                    _CrystalBallTab(),
                    _MagicBookTab(),
                  ],
                ),
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
        final level = (exp / 100).floor() + 1;
        final progress = (exp % 100) / 100.0;

        final phaseIndex = ((level - 1) / 100).floor();
        final phases = [
          '견습생의 필기구',
          '기초 마법 입문서',
          '고대 룬 문법',
          '원소술의 이해',
          '별빛의 조화',
          '아티팩트 해독',
          '현자의 금서',
          '정령과의 교감',
          '진리의 마도서',
          '전지전능한 기록'
        ];
        final currentPhaseName = phaseIndex < phases.length ? phases[phaseIndex] : '초월';
        final phaseNumber = phaseIndex + 1;

        final double hue = (40.0 + (exp * 3.0)) % 360.0;
        final double lightness = (0.5 + (exp / 100000.0) * 0.5).clamp(0.5, 1.0);
        final titleColor = HSLColor.fromAHSL(1.0, hue, 0.8, lightness).toColor();


        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('[$phaseNumber단계: $currentPhaseName]', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: titleColor, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('마법책 레벨 $level', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white24,
                              color: Colors.amberAccent,
                              minHeight: 12,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            const SizedBox(height: 8),
                            Text('지식: ${exp % 100} / 100', style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/magic_book.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
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
                            style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: _isEnhancing ? null : _enhanceBook,
                        icon: const Icon(Icons.auto_awesome),
                        label: const Text('마법책 강화 (가루 10개)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[800],
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
        final displayLevel = (exp / 100).floor() + 1;
        final progress = (exp % 100) / 100.0;
        
        final phaseIndex = ((displayLevel - 1) / 100).floor();
        final phases = [
          '심연의 마력',
          '영안의 개방',
          '대자연의 지혜',
          '태양의 정수',
          '천공의 오로라',
          '신의 경지',
          '창조의 마력',
          '우주의 숨결',
          '영원의 빛',
          '순백의 각성'
        ];
        final currentPhaseName = phaseIndex < phases.length ? phases[phaseIndex] : '초월';
        final phaseNumber = phaseIndex + 1;

        final double hue = (exp * 3.0) % 360.0;
        final double lightness = (0.1 + (exp / 100000.0) * 0.9).clamp(0.1, 1.0);
        final overlayColor = HSLColor.fromAHSL(1.0, hue, 1.0, lightness).toColor();

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('[$phaseNumber단계: $currentPhaseName]', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
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
                    Text('마력: ${exp % 100} / 100', style: const TextStyle(color: Colors.white70)),
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
                            color: overlayColor.withOpacity(0.8), // 그림자 렌더링으로 인해 삐져나오는 현상 방지를 위해 그림자 완전 제거
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
