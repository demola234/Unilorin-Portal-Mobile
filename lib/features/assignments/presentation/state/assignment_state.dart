import '../../../../core/utils/states.dart';

class AssignmentState {
  final ViewState viewState;

  const AssignmentState._({required this.viewState});

  factory AssignmentState.initial() => const AssignmentState._(
        viewState: ViewState.idle,
      );

  AssignmentState copyWith({ViewState? viewState}) => AssignmentState._(
        viewState: viewState ?? this.viewState,
      );
}
