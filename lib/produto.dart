class Produto {

  int _cod = 0;
  String _nome = "";
  double _preco = 0;
 int get cod => this._cod;

 set cod(int value) => this._cod = value;

  get nome => this._nome;

 set nome( value) => this._nome = value;

  get preco => this._preco;

 set preco( value) => this._preco = value;

  Produto();

Produto.fromJson(Map <String, dynamic> json)
:
_cod = json['cod'],
_nome = json['nome'],
_preco = json['preco']
;
 

}