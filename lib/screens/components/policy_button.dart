import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyButton extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.google.com.br');

  PolicyButton({
    Key? key,
  }) : super(key: key);

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não possível abrir: $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await _launchUrl();
      },
      child: const Text(
        'Política de Privacidade',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
