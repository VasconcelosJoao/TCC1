import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/blocs/code_bloc/code_bloc.dart';
import 'package:unb_sql/functions.dart';
import 'package:unb_sql/show_terminal_cubit.dart';
import 'package:unb_sql/theme_cubit.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Size headerSize = getHeaderSize(context);

    return SizedBox(
      height: headerSize.height,
      width: headerSize.width,
      child: Row(
        children: [
          HeaderButton(
            onPressed: () {},
            iconData: Icons.file_open_outlined,
            title: "Arquivo",
          ),
          HeaderButton(
            onPressed: () {},
            iconData: Icons.edit,
            title: "Editar",
          ),
          HeaderButton(
            onPressed: () {},
            iconData: Icons.reorder,
            title: "Seleção",
          ),
          HeaderButton(
            onPressed: () {},
            iconData: Icons.remove_red_eye_outlined,
            title: "Ver",
          ),
          HeaderButton(
            onPressed: () {},
            iconData: Icons.arrow_forward,
            title: "Acessar",
          ),
          HeaderButton(
            onPressed: () {
              BlocProvider.of<CodeBloc>(context).add(NeedToSaveCode());
              BlocProvider.of<CodeBloc>(context).add(ExecuteCode());
            },
            iconData: Icons.play_arrow,
            title: "Executar",
          ),
          HeaderButton(
            onPressed: () {
              BlocProvider.of<ShowTerminalCubit>(context).toggleTerminal();
            },
            iconData: Icons.terminal,
            title: "Terminal",
          ),
          const Spacer(),
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              return theme.brightness == Brightness.dark
                  ? IconButton(
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      },
                      icon: const Icon(
                        Icons.nightlight_round_sharp,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      },
                      icon: const Icon(
                        Icons.wb_sunny_outlined,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  final String title;

  const HeaderButton({
    super.key,
    this.onPressed,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Define bordas retas
        ),
      ),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}
