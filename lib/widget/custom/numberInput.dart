import 'package:flutter/material.dart';

class NumberInputWidget extends StatefulWidget {
  const NumberInputWidget({super.key});

  @override
  _NumberInputWidgetState createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  final TextEditingController _controller = TextEditingController();
  int _value = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = _value.toString();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  void _increment() {
    setState(() {
      _value++;
      _controller.text = _value.toString();
    });
  }

  void _decrement() {
    setState(() {
      if (_value > 0) {
        _value--;
        _controller.text = _value.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              // enabled: false,
              focusNode: _focusNode,
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Handle text input if needed
                // For simplicity, this example doesn't handle invalid input
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: _increment,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: _decrement,
              ),
            ],
          )
        ],
      ),
    );
  }
}
