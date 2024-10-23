part of 'code_bloc.dart';

/// Event being processed by [CodeBloc].
sealed class CodeEvent extends Equatable {}

/// ChangeLine of [CodeArea] widget
class ChangeSelectedLineEvent extends CodeEvent {
  final int selectedLine;

  ChangeSelectedLineEvent(this.selectedLine);

  @override
  List<Object> get props => [selectedLine];
}

class NeedToSaveCode extends CodeEvent {
  @override
  List<Object?> get props => [];
}

class OutDatedCode extends CodeEvent {
  @override
  List<Object?> get props => [];
}

class SaveCodeWritten extends CodeEvent {
  final String code;

  SaveCodeWritten(this.code);
  @override
  List<Object?> get props => [code];
}

class ExecuteCode extends CodeEvent {
  @override
  List<Object?> get props => [];
}
