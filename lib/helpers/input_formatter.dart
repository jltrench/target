import 'package:flutter/material.dart';

class InputFormatter {
  static bool isLoginValid(String login, BuildContext context) {
    if (login.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Usuário inválido'),
          content: Text('O usuário não pode ser vazio.'),
        ),
      );
      return false;
    }

    if (login.length > 20) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Usuário inválido'),
          content: Text('O usuário deve ter no máximo 20 caracteres.'),
        ),
      );
      return false;
    }

    if (login.endsWith(' ')) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Usuário inválido'),
          content: Text('O usuário não pode terminar com espaço.'),
        ),
      );
      return false;
    }

    return true;
  }

  static bool isPasswordValid(String password, BuildContext context) {
    if (password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senha inválida'),
          content: Text('A senha não pode ser vazia.'),
        ),
      );
      return false;
    }

    if (password.length > 20) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senha inválida'),
          content: Text('A senha deve ter no máximo 20 caracteres.'),
        ),
      );
      return false;
    }

    if (password.endsWith(' ')) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senha inválida'),
          content: Text('A senha não pode terminar com espaço.'),
        ),
      );
      return false;
    }

    if (password.length < 2) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senha inválida'),
          content: Text('A senha deve ter no mínimo 2 caracteres.'),
        ),
      );
      return false;
    }

    final RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');

    if (!regex.hasMatch(password)) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Senha inválida'),
          content: Text('A senha não pode ter caracteres especiais.'),
        ),
      );
      return false;
    }

    return true;
  }
}
