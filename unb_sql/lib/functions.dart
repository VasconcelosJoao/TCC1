import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/show_terminal_cubit.dart';

Size getHeaderSize(context) {
  return Size(
    MediaQuery.of(context).size.width,
    MediaQuery.of(context).size.height / 20,
  );
}

Size getLeftBarSize(context) {
  final headerUsedHeight = getHeaderSize(context).height;
  return Size(
    MediaQuery.of(context).size.width / 10,
    MediaQuery.of(context).size.height - headerUsedHeight,
  );
}

Size getRightBarSize(context) {
  final headerUsedHeight = getHeaderSize(context).height;

  return Size(
    MediaQuery.of(context).size.width / 10,
    MediaQuery.of(context).size.height - headerUsedHeight,
  );
}

Size getTerminalSize(context) {
  final leftBarUsedWidth = getLeftBarSize(context).width;
  final rightBarUsedWidth = getRightBarSize(context).width;
  return Size(
    MediaQuery.of(context).size.width - leftBarUsedWidth - rightBarUsedWidth,
    100,
  );
}

Size getCodeAreaSize(context) {
  final headerUsedHeight = getHeaderSize(context).height;
  final leftBarUsedWidth = getLeftBarSize(context).width;
  final rightBarUsedWidth = getRightBarSize(context).width;
  final terminalUsedHeight = getTerminalSize(context).height;

  final bool isTerminalVisible =
      BlocProvider.of<ShowTerminalCubit>(context).state;

  if (isTerminalVisible) {
    return Size(
      MediaQuery.of(context).size.width - leftBarUsedWidth - rightBarUsedWidth,
      MediaQuery.of(context).size.height -
          headerUsedHeight -
          terminalUsedHeight,
    );
  }
  // terminal nao esta visivel
  return Size(
    MediaQuery.of(context).size.width - leftBarUsedWidth - rightBarUsedWidth,
    MediaQuery.of(context).size.height - headerUsedHeight,
  );
}

int getSelectedLine(TextEditingController controller) {
  int cursorPosition = controller.selection.baseOffset;
  if (cursorPosition == -1) {
    return -1; // Se não houver cursor, retorna -1
  }
  String text = controller.text.substring(0, cursorPosition);
  return '\n'
      .allMatches(text)
      .length; // Conta as quebras de linha antes do cursor
}

int getLineCount(TextEditingController controller) {
  return '\n'.allMatches(controller.text).length + 1;
}

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}
