import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/blocs/code_bloc/code_bloc.dart';
import 'package:unb_sql/functions.dart';

class CodeArea extends StatefulWidget {
  final Size codeAreaSize;
  const CodeArea({
    Key? key,
    required this.codeAreaSize,
  }) : super(key: key);

  @override
  _CodeAreaState createState() => _CodeAreaState();
}

class _CodeAreaState extends State<CodeArea> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _listViewScrollController = ScrollController();
  final ScrollController _textFieldScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _textFieldScrollController.addListener(() {
      if (_listViewScrollController.hasClients) {
        _listViewScrollController.jumpTo(_textFieldScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textFieldScrollController.dispose();
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CodeBloc, CodeState>(
      listener: (context, state) {
        if (state.needToSaveCode) {
          BlocProvider.of<CodeBloc>(context)
              .add(SaveCodeWritten(_controller.text));
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: widget.codeAreaSize.height,
          width: widget.codeAreaSize.width,
          child: Row(
            children: [
              Container(
                width: 30,
                color: Colors.grey[200],
                // not visible scrollbar
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    itemCount: getLineCount(_controller),
                    controller: _listViewScrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        color: state.selectedLine == index
                            ? Colors.blue[100]
                            : Colors.transparent,
                        padding:
                            index == 0 ? const EdgeInsets.only(top: 5) : null,
                        child: Text(
                          '${index + 1}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: state.selectedLine == index
                                ? Colors.blue
                                : Colors.black,
                            fontSize: 14.7,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  onTap: () {
                    BlocProvider.of<CodeBloc>(context).add(
                      ChangeSelectedLineEvent(
                        getSelectedLine(_controller),
                      ),
                    );
                  },
                  scrollController: _textFieldScrollController,
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  onChanged: (text) {
                    BlocProvider.of<CodeBloc>(context).add(
                      ChangeSelectedLineEvent(
                        getSelectedLine(_controller),
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escreva seu código aqui...',
                  ),
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14.29,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
