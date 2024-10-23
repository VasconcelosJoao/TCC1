import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/interpreter/interpreter.dart';
import 'package:unb_sql/widgets/code_area.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  final Interpreter interpreter;
  CodeBloc(this.interpreter) : super(CodeState()) {
    on<ChangeSelectedLineEvent>(
      (event, emit) => emit(state.copyWith(selectedLine: event.selectedLine)),
    );

    on<SaveCodeWritten>(
      (event, emit) {
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

    on<ExecuteCode>(
      (event, emit) {
        print('-------------------------------------------------------');
        print('Executing code: \n${state.currentCodeSaved}');
        interpreter.interpret(state.currentCodeSaved);
      },
    );
  }
}

/*

SELECIONAR * DE TABELA Aluno
DERRUBAR TABELA Aluno
DELETAR DE TABELA Aluno ONDE id = 1
CHAVE PRIMARIA
*/
