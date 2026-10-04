import 'package:equatable/equatable.dart';
import '../../core/models/memory_item.dart';

enum MemoriesStatus { initial, loading, loaded }

class MemoriesState extends Equatable {
  final MemoriesStatus status;
  final List<MemoryItem> allMemories;
  final MemoryCategory? selectedCategory;

  const MemoriesState({
    required this.status,
    required this.allMemories,
    this.selectedCategory,
  });

  factory MemoriesState.initial() {
    return MemoriesState(
      status: MemoriesStatus.initial,
      allMemories: MemoryItem.defaultMemories(),
      selectedCategory: null,
    );
  }

  List<MemoryItem> get filteredMemories {
    final sorted = List<MemoryItem>.from(allMemories)
      ..sort((a, b) => a.date.compareTo(b.date));
    if (selectedCategory == null) {
      return sorted;
    }
    return sorted.where((m) => m.category == selectedCategory).toList();
  }

  List<MemoryItem> get favoriteMemories {
    return allMemories.where((m) => m.isFavorite).toList();
  }

  MemoriesState copyWith({
    MemoriesStatus? status,
    List<MemoryItem>? allMemories,
    MemoryCategory? Function()? selectedCategory,
  }) {
    return MemoriesState(
      status: status ?? this.status,
      allMemories: allMemories ?? this.allMemories,
      selectedCategory:
          selectedCategory != null ? selectedCategory() : this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [status, allMemories, selectedCategory];
}
