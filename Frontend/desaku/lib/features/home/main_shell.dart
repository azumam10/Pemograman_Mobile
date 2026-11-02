import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/app_theme.dart';
import '../activities/activities_page.dart';
import '../aid/aid_page.dart';
import '../news/news_page.dart';
import '../profile/profile_page.dart';
import 'home_page.dart';

/// Kerangka navigasi utama (hanya untuk warga terverifikasi, AB-01).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onNavigate: _go),
      const ActivitiesPage(),
      const AidPage(),
      const NewsPage(),
      const ProfilePage(),
    ];
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _go(0);
      },
      child: Scaffold(
        body: IndexedStack(index: _index, children: pages),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith(
              (s) => TextStyle(
                fontSize: 16,
                fontWeight: s.contains(WidgetState.selected)
                    ? FontWeight.w800
                    : FontWeight.w500,
                color: s.contains(WidgetState.selected)
                    ? AppColors.purple
                    : AppColors.textMuted,
              ),
            ),
            labelPadding: EdgeInsets.zero,
          ),
          child: ListenableBuilder(
            listenable: appState,
            builder: (context, _) => NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _go,
              backgroundColor: Colors.white,
              indicatorColor: AppColors.purpleSoft,
              height: 76,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: AppColors.purple,
                  ),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.event_outlined),
                  selectedIcon: Icon(
                    Icons.event_rounded,
                    color: AppColors.purple,
                  ),
                  label: 'Kegiatan',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.volunteer_activism_outlined),
                  selectedIcon: Icon(
                    Icons.volunteer_activism_rounded,
                    color: AppColors.purple,
                  ),
                  label: 'Bantuan',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.newspaper_outlined),
                  selectedIcon: Icon(
                    Icons.newspaper_rounded,
                    color: AppColors.purple,
                  ),
                  label: 'Berita',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: appState.unreadCount > 0,
                    child: const Icon(Icons.person_outline_rounded),
                  ),
                  selectedIcon: const Icon(
                    Icons.person_rounded,
                    color: AppColors.purple,
                  ),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
