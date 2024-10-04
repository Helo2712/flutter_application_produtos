

import 'package:flutter_application_produtos/produto.dart';

class ProdutoRepository{
  List<Produto> _listaProd = [];
  
  get listaProd => this._listaProd;

 set listaProd( value) => this._listaProd = value;
 ProdutoRepository();
}