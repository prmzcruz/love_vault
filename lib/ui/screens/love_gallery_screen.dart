import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/memories/memories_bloc.dart';
import '../../blocs/memories/memories_state.dart';
import '../../core/models/memory_item.dart';
import '../../core/theme/pink_theme.dart';

class LoveGalleryScreen extends StatelessWidget {
  const LoveGalleryScreen({super.key});

  static const List<String> loveQuotes = [
    '"I saw that you were perfect, and so I loved you. Then I saw that you were not perfect and I loved you even more." 💕',
    '"You are my sun, my moon, and all my stars." 🌟',
    '"In all the world, there is no heart for me like yours. In all the world, there is no love for you like mine." ❤️',
    '"I love you not only for what you are, but for what I am when I am with you." 💖',
    '"Every love story is beautiful, but ours is my favorite." 📖✨',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoriesBloc, MemoriesState>(
      builder: (context, memoriesState) {
        final memories = memoriesState.allMemories;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Our Precious Moments Gallery 📸',
                style: TextStyle(
                  color: PinkTheme.darkMagenta,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Snapshots of love, smiles, and unforgettable milestones',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              // Grid of Memory Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.82,
                ),
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  final mem = memories[index];

                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: PinkTheme.primaryPink.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: PinkTheme.softHeaderGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              mem.heartEmoji,
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mem.title,
                          style: const TextStyle(
                            color: PinkTheme.darkMagenta,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mem.category.label,
                          style: const TextStyle(
                            color: PinkTheme.primaryPink,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '📍 ${mem.location}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // Love Quotes Carousel / List
              const Text(
                'Sweet Love Letters & Quotes 💌',
                style: TextStyle(
                  color: PinkTheme.darkMagenta,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              ...loveQuotes.map((q) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PinkTheme.softCardPink,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: PinkTheme.primaryPink.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    q,
                    style: const TextStyle(
                      color: PinkTheme.deepPassion,
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
