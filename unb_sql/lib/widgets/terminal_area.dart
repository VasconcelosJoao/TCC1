import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:unb_sql/functions.dart';
import 'package:xterm/xterm.dart';

class TerminalArea extends StatefulWidget {
  const TerminalArea({
    super.key,
  });

  @override
  _TerminalAreaState createState() => _TerminalAreaState();
}

class _TerminalAreaState extends State<TerminalArea> {
  final terminalController = TerminalController();

  late final Pty pty;

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _startPty();
      },
    );
    super.initState();
  }

  final terminal = Terminal(
    maxLines: 10000,
  );

  void _startPty() {
    pty = Pty.start(
      shell,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  String get shell {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }

    if (Platform.isWindows) {
      return 'cmd.exe';
    }

    return 'sh';
  }

  @override
  Widget build(BuildContext context) {
    final Size terminalSize = getTerminalSize(context);
    return Container(
      width: terminalSize.width,
      height: terminalSize.height,
      color: Colors.black,
      child: SafeArea(
        child: TerminalView(
          terminal,
          controller: terminalController,
          onSecondaryTapDown: (details, offset) async {
            final selection = terminalController.selection;
            if (selection != null) {
              final text = terminal.buffer.getText(selection);
              terminalController.clearSelection();
              await Clipboard.setData(ClipboardData(text: text));
            } else {
              final data = await Clipboard.getData('text/plain');
              final text = data?.text;
              if (text != null) {
                terminal.paste(text);
              }
            }
          },
        ),
      ),
    );
  }
}
