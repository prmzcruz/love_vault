import 'package:flutter/material.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/floating_hearts_overlay.dart';
import 'home_screen.dart';
import 'memory_timeline_screen.dart';
import 'birthday_surprise_screen.dart';
import 'love_gallery_screen.dart';
import 'couple_settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onNavigateToTimeline: () {
          setState(() => _currentIndex = 1);
        },
        onNavigateToSurprise: () {
          setState(() => _currentIndex = 2);
        },
      ),
      const MemoryTimelineScreen(),
      const BirthdaySurpriseScreen(),
      const LoveGalleryScreen(),
      const CoupleSettingsScreen(),
    ];

    const titles = [
      'LoveVault 🔐💕',
      'Memory Lane Timeline 📖',
      'Special Days Vault 🎂',
      'Memories Gallery 📸',
      'Couple Profile ⚙️',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '💖 ',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              titles[_currentIndex],
              style: const TextStyle(
                color: PinkTheme.darkMagenta,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: FloatingHeartsOverlay(
        heartCount: 10,
        child: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: PinkTheme.primaryPink.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite, color: PinkTheme.primaryPink),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline_outlined),
                activeIcon: Icon(Icons.timeline, color: PinkTheme.primaryPink),
                label: 'Timeline',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cake_outlined),
                activeIcon: Icon(Icons.cake, color: PinkTheme.primaryPink),
                label: 'Surprise',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_library_outlined),
                activeIcon: Icon(Icons.photo_library, color: PinkTheme.primaryPink),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person, color: PinkTheme.primaryPink),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
