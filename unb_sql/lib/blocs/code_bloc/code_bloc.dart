import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/widgets/code_area.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  CodeBloc() : super(CodeState()) {
    on<ChangeSelectedLineEvent>(
      (event, emit) => emit(state.copyWith(selectedLine: event.selectedLine)),
    );

    on<SaveCodeWritten>(
      (event, emit) {
        print('-------------------------------------------------------');
        print('Saving code: \n${event.code}');
        emit(state.copyWith(
          currentCodeSaved: event.code,
          needToSaveCode: false,
        ));
      },
    );

    on<NeedToSaveCode>(
      (event, emit) => emit(state.copyWith(needToSaveCode: true)),
    );

    on<OutDatedCode>(
      (event, emit) {
        emit(state.copyWith(needToSaveCode: false));
      },
    );
  }
}
