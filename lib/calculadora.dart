import 'dart:math';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Clear';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == '⌫') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else if (valor == '+/-') {
        if (_expressao.isNotEmpty && !_expressao.contains(RegExp(r'[\+\-\*/]'))) {
          if (_expressao.startsWith('-')) {
            _expressao = _expressao.substring(1);
          } else {
            _expressao = '-$_expressao';
          }
        }
      } else if (valor == '%') {
        if (_expressao.isNotEmpty) {
          _expressao = (double.parse(_expressao) / 100).toString();
        }
      } else if (valor == 'sin') {
        _expressao = sin(double.parse(_expressao) * pi / 180).toString();
      } else if (valor == 'cos') {
        _expressao = cos(double.parse(_expressao) * pi / 180).toString();
      } else if (valor == 'tan') {
        _expressao = tan(double.parse(_expressao) * pi / 180).toString();
      } else if (valor == '√') {
        _expressao = sqrt(double.parse(_expressao)).toString();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
      debugPrint('Erro: $e');
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*').replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          child: Text(
            _resultado,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              _botao('('),
              _botao(')'),
              _botao('%'),
              _botao('⌫'),
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao('+/-'),
              _botao('='),
              _botao('+'),
              _botao('sin'),
              _botao('cos'),
              _botao('tan'),
              _botao('√'),
            ],
          ),
        ),
        Expanded(
          child: _botao(_limpar),
        )
     ],
);
}
}
