import 'package:flutter/material.dart';
import 'package:target_sistemas/routes/routes.dart';
import 'package:target_sistemas/screens/components/policy_button.dart';
import 'package:target_sistemas/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final Uri _url = Uri.parse('https://www.google.com.br');

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    final isLoginValid = await ApiService.login(username, password, context);

    if (isLoginValid) {
      if (!mounted) return;
      Navigator.pushNamed(context, Routes.texting);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Usuário ou senha inválidos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Não possível abrir: $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // dados para teste de login
            const Text('Usuário: kminchelle'),
            const Text('Senha: 0lelplR'),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _usernameController,
                onFieldSubmitted: (_) {
                  _login();
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Usuário',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _passwordController,
                onFieldSubmitted: (_) {
                  _login();
                },
                obscureText: !_isPasswordVisible,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: 'Senha',
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _login();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            PolicyButton()
          ],
        ),
      ),
    );
  }
}
