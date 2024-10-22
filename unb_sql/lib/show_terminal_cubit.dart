import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTerminalCubit extends Cubit<bool> {
  ShowTerminalCubit() : super(true);
  void toggleTerminal() {
    emit(state == true ? false : true);
  }
}
