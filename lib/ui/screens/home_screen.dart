import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/couple/couple_bloc.dart';
import '../../blocs/couple/couple_state.dart';
import '../../blocs/memories/memories_bloc.dart';
import '../../blocs/memories/memories_state.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/time_together_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToTimeline;
  final VoidCallback onNavigateToSurprise;

  const HomeScreen({
    super.key,
    required this.onNavigateToTimeline,
    required this.onNavigateToSurprise,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoupleBloc, CoupleState>(
      builder: (context, coupleState) {
        final couple = coupleState.coupleInfo;
        final daysUntilBday = couple.daysUntilBirthday;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Couple Title Banner with Photos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: PinkTheme.primaryPink.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Partner 1 Avatar
                        _buildAvatar(
                          photoPath: couple.myPhotoUrl,
                          defaultEmoji: '👨',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('❤️', style: TextStyle(fontSize: 22)),
                        ),
                        // Partner 2 Avatar
                        _buildAvatar(
                          photoPath: couple.partnerPhotoUrl,
                          defaultEmoji: '👩',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${couple.myName} ❤️ ${couple.partnerName}',
                      style: const TextStyle(
                        color: PinkTheme.darkMagenta,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      couple.relationshipNickname,
                      style: const TextStyle(
                        color: PinkTheme.primaryPink,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Time Together Card
              TimeTogetherCard(
                initialMeetDate: couple.initialMeetDate,
                partnerName: couple.partnerName,
              ),

              const SizedBox(height: 20),

              // Birthday Surprise Banner
              GestureDetector(
                onTap: onNavigateToSurprise,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: PinkTheme.goldGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: PinkTheme.warmAmber.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '🎂',
                        style: TextStyle(fontSize: 36),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              daysUntilBday == 0
                                  ? "🎉 IT'S ${couple.partnerName.toUpperCase()}'S BIRTHDAY TODAY! 🎉"
                                  : "$daysUntilBday Days Until ${couple.partnerName}'s Birthday!",
                              style: const TextStyle(
                                color: Color(0xFF5D4037),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Tap to unwrap birthday gifts & virtual cake! 🎁',
                              style: TextStyle(
                                color: Color(0xFF6D4C41),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF5D4037),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Recent Memory Highlight section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Memory Lane Highlights 📖',
                    style: TextStyle(
                      color: PinkTheme.darkMagenta,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: onNavigateToTimeline,
                    child: const Text(
                      'View All ❤️',
                      style: TextStyle(
                        color: PinkTheme.primaryPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              BlocBuilder<MemoriesBloc, MemoriesState>(
                builder: (context, memoriesState) {
                  final favorites = memoriesState.favoriteMemories;
                  if (favorites.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final memory = favorites[index];
                        return Container(
                          width: 240,
                          margin: const EdgeInsets.only(right: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: PinkTheme.primaryPink
                                  .withValues(alpha: 0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: PinkTheme.primaryPink
                                    .withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    memory.heartEmoji,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      memory.title,
                                      style: const TextStyle(
                                        color: PinkTheme.darkMagenta,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                memory.description,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                '📍 ${memory.location}',
                                style: const TextStyle(
                                  color: PinkTheme.primaryPink,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Sweet Love Note Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: PinkTheme.softCardPink,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      '💌 Note From My Heart',
                      style: TextStyle(
                        color: PinkTheme.darkMagenta,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '"${couple.customLoveNote}"',
                      style: const TextStyle(
                        color: PinkTheme.deepPassion,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar({required String? photoPath, required String defaultEmoji}) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: PinkTheme.softCardPink,
        shape: BoxShape.circle,
        border: Border.all(color: PinkTheme.primaryPink, width: 2),
        image: photoPath != null && photoPath.isNotEmpty
            ? DecorationImage(
                image: FileImage(File(photoPath)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: (photoPath == null || photoPath.isEmpty)
          ? Center(
              child: Text(defaultEmoji, style: const TextStyle(fontSize: 28)),
            )
          : null,
    );
  }
}
