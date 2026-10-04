import 'package:equatable/equatable.dart';
import '../../core/models/memory_item.dart';

abstract class MemoriesEvent extends Equatable {
  const MemoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMemoriesEvent extends MemoriesEvent {
  const LoadMemoriesEvent();
}

class AddMemoryEvent extends MemoriesEvent {
  final MemoryItem memory;

  const AddMemoryEvent(this.memory);

  @override
  List<Object?> get props => [memory];
}

class ToggleFavoriteMemoryEvent extends MemoriesEvent {
  final String memoryId;

  const ToggleFavoriteMemoryEvent(this.memoryId);

  @override
  List<Object?> get props => [memoryId];
}

class DeleteMemoryEvent extends MemoriesEvent {
  final String memoryId;

  const DeleteMemoryEvent(this.memoryId);

  @override
  List<Object?> get props => [memoryId];
}

class FilterMemoriesByCategoryEvent extends MemoriesEvent {
  final MemoryCategory? category;

  const FilterMemoriesByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
