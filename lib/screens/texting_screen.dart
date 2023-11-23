import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_sistemas/screens/components/policy_button.dart';
import 'package:target_sistemas/services/user_service.dart';
import 'package:target_sistemas/stores/texting_store.dart';

class TextingScreen extends StatefulWidget {
  const TextingScreen({Key? key}) : super(key: key);

  @override
  TextingScreenState createState() => TextingScreenState();
}

class TextingScreenState extends State<TextingScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final TextingStore textingStore = TextingStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();
    initText();
  }

  void initText() async {
    String? savedText = await UserService.getText();
    if (savedText != null) {
      setState(() {
        textEditingController.text = savedText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Texting Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Observer(
                          builder: (_) => Text(
                            textingStore.savedText.isNotEmpty
                                ? textingStore.savedText
                                : 'O texto digitado aparecerá aqui',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: focusNode,
                controller: textEditingController,
                onFieldSubmitted: (text) {
                  if (textEditingController.text.isNotEmpty) {
                    saveText();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Atenção'),
                          content: const Text('O texto não pode ser vazio'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onChanged: (text) {
                  textingStore.saveText(text);
                },
                onEditingComplete: () {
                  if (textEditingController.text.isNotEmpty) {
                    saveText();
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Digite seu texto aqui',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              PolicyButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDeleteConfirmationDialog();
        },
        child: const Icon(Icons.delete),
      ),
    );
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Tem certeza que deseja excluir o texto?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    textEditingController.clear();
                    saveText();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirmar',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void saveText() async {
    await UserService.setText(textEditingController.text);
  }
}
