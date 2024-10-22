import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/functions.dart';
import 'package:unb_sql/show_terminal_cubit.dart';
import 'package:unb_sql/widgets/code_area.dart';
import 'package:unb_sql/widgets/terminal_area.dart';

class MiddleContent extends StatelessWidget {
  const MiddleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowTerminalCubit, bool>(
      builder: (context, state) {
        return Column(
          children: [
            CodeArea(
              codeAreaSize: getCodeAreaSize(context),
            ),
            if (state) const TerminalArea(),
          ],
        );
      },
    );
  }
}
