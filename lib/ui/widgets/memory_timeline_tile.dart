import 'package:flutter/material.dart';
import '../../core/models/memory_item.dart';
import '../../core/theme/pink_theme.dart';

class MemoryTimelineTile extends StatelessWidget {
  final MemoryItem memory;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;

  const MemoryTimelineTile({
    super.key,
    required this.memory,
    required this.isFirst,
    required this.isLast,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator line + heart node
          SizedBox(
            width: 48,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 3,
                      color: PinkTheme.primaryPink.withValues(alpha: 0.4),
                    ),
                  )
                else
                  const SizedBox(height: 16),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PinkTheme.primaryPink,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      memory.heartEmoji,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3,
                      color: PinkTheme.primaryPink.withValues(alpha: 0.4),
                    ),
                  )
                else
                  const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: PinkTheme.primaryPink.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PinkTheme.softCardPink,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          memory.category.label,
                          style: const TextStyle(
                            color: PinkTheme.darkMagenta,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              memory.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: PinkTheme.primaryPink,
                              size: 20,
                            ),
                            onPressed: onToggleFavorite,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(4),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.grey.shade400,
                              size: 18,
                            ),
                            onPressed: onDelete,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    memory.title,
                    style: const TextStyle(
                      color: PinkTheme.darkMagenta,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: PinkTheme.accentRose,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(memory.date),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: PinkTheme.accentRose,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          memory.location,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    memory.description,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
