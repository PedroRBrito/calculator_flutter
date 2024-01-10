import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'memory.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _memory = Memory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Calculadora'),
            Row(
              children: [
                IconButton.filledTonal(
                  iconSize: 28,
                  icon: Icon(Icons.history),
                  color: Colors.deepOrange,
                  onPressed: () async {
                    await Share.share('O resultado é: ${_memory.result}',
                        subject: '');
                  },
                ),
                IconButton.filledTonal(
                  icon: Icon(Icons.share),
                  color: Colors.deepOrange,
                  onPressed: () async {
                    await Share.share('Link do app na loja aqui', subject: '');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildDisplay(),
          Divider(height: 0.1),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildDisplay() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _memory.history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _memory.history[index],
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: AutoSizeText(
                _memory.result,
                minFontSize: 20.0,
                maxFontSize: 80.0,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontFamily: 'Tektur',
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none,
                  fontSize: 80.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardButton(String label,
      {int flex = 1,
      Color backgroundColor = Colors.black,
      Color foregroundColor = Colors.white}) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: () {
          setState(() {
            _memory.applyCommand(label);
            print('Botão pressionado: $label');
          });
        },
        child: Text(
          label,
          style: TextStyle(fontSize: 24, fontFamily: 'Tektur'),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      color: Colors.black,
      height: 400,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildKeyboardButton('AC', foregroundColor: Colors.deepOrange),
                _buildKeyboardButton('DEL', foregroundColor: Colors.deepOrange),
                _buildKeyboardButton('%', foregroundColor: Colors.deepOrange),
                _buildKeyboardButton('/', foregroundColor: Colors.deepOrange)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildKeyboardButton(
                  '7',
                ),
                _buildKeyboardButton('8'),
                _buildKeyboardButton('9'),
                _buildKeyboardButton('*', foregroundColor: Colors.deepOrange)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildKeyboardButton('4'),
                _buildKeyboardButton('5'),
                _buildKeyboardButton('6'),
                _buildKeyboardButton('+', foregroundColor: Colors.deepOrange)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildKeyboardButton('1'),
                _buildKeyboardButton('2'),
                _buildKeyboardButton('3'),
                _buildKeyboardButton('-', foregroundColor: Colors.deepOrange)
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildKeyboardButton('0', flex: 2),
                _buildKeyboardButton('.'),
                _buildKeyboardButton('=', foregroundColor: Colors.deepOrange)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
