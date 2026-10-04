import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/memories/memories_bloc.dart';
import '../../blocs/memories/memories_event.dart';
import '../../blocs/memories/memories_state.dart';
import '../../core/models/memory_item.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/memory_timeline_tile.dart';

class MemoryTimelineScreen extends StatelessWidget {
  const MemoryTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoriesBloc, MemoriesState>(
      builder: (context, memoriesState) {
        final filteredList = memoriesState.filteredMemories;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              // Category filter chip bar
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip(
                      context: context,
                      label: 'All Memories 💕',
                      isSelected: memoriesState.selectedCategory == null,
                      onTap: () {
                        context.read<MemoriesBloc>().add(
                              const FilterMemoriesByCategoryEvent(null),
                            );
                      },
                    ),
                    ...MemoryCategory.values.map((cat) {
                      return _buildFilterChip(
                        context: context,
                        label: cat.label,
                        isSelected: memoriesState.selectedCategory == cat,
                        onTap: () {
                          context.read<MemoriesBloc>().add(
                                FilterMemoriesByCategoryEvent(cat),
                              );
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Timeline List
              Expanded(
                child: filteredList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '💌',
                              style: TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No memories found in this category yet!',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final memory = filteredList[index];
                          return MemoryTimelineTile(
                            memory: memory,
                            isFirst: index == 0,
                            isLast: index == filteredList.length - 1,
                            onToggleFavorite: () {
                              context.read<MemoriesBloc>().add(
                                    ToggleFavoriteMemoryEvent(memory.id),
                                  );
                            },
                            onDelete: () {
                              context.read<MemoriesBloc>().add(
                                    DeleteMemoryEvent(memory.id),
                                  );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddMemoryDialog(context),
            backgroundColor: PinkTheme.primaryPink,
            icon: const Icon(Icons.add_reaction_outlined, color: Colors.white),
            label: const Text(
              'Add Memory ❤️',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : PinkTheme.darkMagenta,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
        selected: isSelected,
        selectedColor: PinkTheme.primaryPink,
        backgroundColor: Colors.white,
        showCheckmark: false,
        onSelected: (_) => onTap(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? PinkTheme.primaryPink
                : PinkTheme.primaryPink.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }

  void _showAddMemoryDialog(BuildContext context) {
    final titleController = TextEditingController();
    final locationController = TextEditingController();
    final descController = TextEditingController();
    MemoryCategory selectedCat = MemoryCategory.milestone;
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (stfContext, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(stfContext).viewInsets.bottom + 20,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Add New Relationship Memory 💖',
                      style: TextStyle(
                        color: PinkTheme.darkMagenta,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Memory Title (e.g. Candlelight Dinner)',
                        prefixIcon: Icon(Icons.favorite, color: PinkTheme.primaryPink),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location / Spot',
                        prefixIcon: Icon(Icons.location_on, color: PinkTheme.primaryPink),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Romantic Story / Details...',
                        prefixIcon: Icon(Icons.notes, color: PinkTheme.primaryPink),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<MemoryCategory>(
                      initialValue: selectedCat,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category, color: PinkTheme.primaryPink),
                      ),
                      items: MemoryCategory.values.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat.label),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setModalState(() => selectedCat = val);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) return;
                          final newMem = MemoryItem(
                            id: 'mem_${DateTime.now().millisecondsSinceEpoch}',
                            title: titleController.text.trim(),
                            date: selectedDate,
                            location: locationController.text.trim().isEmpty
                                ? 'Sweet Memories'
                                : locationController.text.trim(),
                            description: descController.text.trim().isEmpty
                                ? 'A precious day spent together!'
                                : descController.text.trim(),
                            category: selectedCat,
                            heartEmoji: selectedCat.defaultEmoji,
                            isFavorite: true,
                          );

                          context.read<MemoriesBloc>().add(AddMemoryEvent(newMem));
                          Navigator.pop(modalContext);
                        },
                        child: const Text('Save Memory ❤️'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
