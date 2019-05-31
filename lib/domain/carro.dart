class Carro {
  String nome;
  String urlFoto;

  Carro(this.nome);
//  Carro();

  Carro.fromJson(Map<String, dynamic> json)  :
        nome = json["nome"],
        urlFoto = json["urlFoto"];

  @override
  String toString() {
    return nome;
  }
}
