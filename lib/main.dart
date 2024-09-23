import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aula6_exer4/endereco.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController cepController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  var erro = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Busca CEP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: cepController,
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Digite o CEP:'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
                'Resultado\n$erro',
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ruaController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Rua:'),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: bairroController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Bairro:'),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: cidadeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Cidade:'),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: estadoController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Estado:'),
              ),
              TextButton(
                onPressed: buscaCEP,
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buscaCEP() async {
    //var vlr;
    String cep = cepController.text;
    String url = 'https://viacep.com.br/ws/$cep/json/';

    final resposta = await http.get(Uri.parse(url));
    if (resposta.body.length <= 21) {
      setState(() {
        erro = 'Não existe esse CEP';
        ruaController.clear();
        bairroController.clear();
        cidadeController.clear();
        estadoController.clear();
      });
    } else if (resposta.statusCode == 200) {
      // resposta 200 OK
      // o body contém JSON
      final jsonDecodificado = jsonDecode(resposta.body);
      final endereco = Endereco.fromJson(jsonDecodificado);
      setState(() {
        erro = '';
        ruaController.text = endereco.logradouro;
        bairroController.text = endereco.bairro;
        cidadeController.text = endereco.cidade;
        estadoController.text = endereco.estado;
      });
    } else {
      setState(() {
        //vlr = resposta.statusCode;
        //      erro = '$vlr';

        erro = 'Falha ao carregar.';
      });
    }
  }
}
