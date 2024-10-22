part of 'code_bloc.dart';

class CodeState {
  final int selectedLine;
  final String currentCodeSaved;
  final bool needToSaveCode;

  CodeState({
    this.selectedLine = -1,
    this.currentCodeSaved = '',
    this.needToSaveCode = false,
  });

  CodeState copyWith({
    int? selectedLine,
    String? currentCodeSaved,
    bool? needToSaveCode,
  }) {
    return CodeState(
      selectedLine: selectedLine ?? this.selectedLine,
      currentCodeSaved: currentCodeSaved ?? this.currentCodeSaved,
      needToSaveCode: needToSaveCode ?? this.needToSaveCode,
    );
  }
}
