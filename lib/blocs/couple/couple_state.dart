import 'package:equatable/equatable.dart';
import '../../core/models/couple_info.dart';

enum CoupleStatus { initial, loading, loaded }

class CoupleState extends Equatable {
  final CoupleStatus status;
  final CoupleInfo coupleInfo;

  const CoupleState({
    required this.status,
    required this.coupleInfo,
  });

  factory CoupleState.initial() {
    return CoupleState(
      status: CoupleStatus.initial,
      coupleInfo: CoupleInfo.defaultSetup(),
    );
  }

  CoupleState copyWith({
    CoupleStatus? status,
    CoupleInfo? coupleInfo,
  }) {
    return CoupleState(
      status: status ?? this.status,
      coupleInfo: coupleInfo ?? this.coupleInfo,
    );
  }

  @override
  List<Object?> get props => [status, coupleInfo];
}
