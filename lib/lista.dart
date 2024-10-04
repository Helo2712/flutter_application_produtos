import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_produtos/produto.dart';
import 'package:flutter_application_produtos/repository.dart';
import 'package:http/http.dart' as http;

class MyLista extends StatefulWidget {
  const MyLista({super.key});

  @override
  State<MyLista> createState() => _MyListaState();
}

class _MyListaState extends State<MyLista> {
  ProdutoRepository prodrepo = ProdutoRepository();
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    fazerRequisicao();
  }

  Future<void> fazerRequisicao() async {
    var url = Uri.parse('http://localhost:8080/apiProduto/todos');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List listaProd = jsonDecode(response.body) as List;
      setState(() {
        prodrepo.listaProd = listaProd.map((item) => Produto.fromJson(item)).toList();
        isLoading = false; 
      });
    } else {
      
      print('Erro: ${response.statusCode}');
      setState(() {
        isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Listagem de Produtos",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color.fromARGB(255, 74, 195, 171),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) 
          : ListView.builder(
              itemCount: prodrepo.listaProd.length,
              itemBuilder: (context, index) {
                final produto = prodrepo.listaProd[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      produto.nome.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Código: ${produto.cod}'),
                        Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'), 
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
