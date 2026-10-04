import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/memory_item.dart';
import 'memories_event.dart';
import 'memories_state.dart';

class MemoriesBloc extends Bloc<MemoriesEvent, MemoriesState> {
  MemoriesBloc() : super(MemoriesState.initial()) {
    on<LoadMemoriesEvent>(_onLoadMemories);
    on<AddMemoryEvent>(_onAddMemory);
    on<ToggleFavoriteMemoryEvent>(_onToggleFavorite);
    on<DeleteMemoryEvent>(_onDeleteMemory);
    on<FilterMemoriesByCategoryEvent>(_onFilterByCategory);
  }

  void _onLoadMemories(
    LoadMemoriesEvent event,
    Emitter<MemoriesState> emit,
  ) {
    emit(state.copyWith(status: MemoriesStatus.loaded));
  }

  void _onAddMemory(
    AddMemoryEvent event,
    Emitter<MemoriesState> emit,
  ) {
    final updatedList = List<MemoryItem>.from(state.allMemories)
      ..add(event.memory);
    emit(state.copyWith(allMemories: updatedList));
  }

  void _onToggleFavorite(
    ToggleFavoriteMemoryEvent event,
    Emitter<MemoriesState> emit,
  ) {
    final updatedList = state.allMemories.map((m) {
      if (m.id == event.memoryId) {
        return m.copyWith(isFavorite: !m.isFavorite);
      }
      return m;
    }).toList();
    emit(state.copyWith(allMemories: updatedList));
  }

  void _onDeleteMemory(
    DeleteMemoryEvent event,
    Emitter<MemoriesState> emit,
  ) {
    final updatedList =
        state.allMemories.where((m) => m.id != event.memoryId).toList();
    emit(state.copyWith(allMemories: updatedList));
  }

  void _onFilterByCategory(
    FilterMemoriesByCategoryEvent event,
    Emitter<MemoriesState> emit,
  ) {
    emit(state.copyWith(selectedCategory: () => event.category));
  }
}
