import 'package:flutter/material.dart';
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
  int _selectedLine = -1;

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
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: getLineCount(_controller),
                controller: _listViewScrollController,
                itemBuilder: (context, index) {
                  return Container(
                    color: _selectedLine == index
                        ? Colors.blue[100]
                        : Colors.transparent,
                    padding: index == 0 ? const EdgeInsets.only(top: 5) : null,
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:
                            _selectedLine == index ? Colors.blue : Colors.black,
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
                setState(() {
                  _selectedLine = getSelectedLine(_controller);
                });
              },
              scrollController: _textFieldScrollController,
              controller: _controller,
              maxLines: null,
              expands: true,
              onChanged: (text) {
                setState(() {
                  _selectedLine = getSelectedLine(_controller);
                });
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
  }
}
