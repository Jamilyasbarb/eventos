
import 'dart:convert';

List<Pessoa> pessoaFromJson(String str) => List<Pessoa>.from(json.decode(str).map((x) => Pessoa.fromJson(x)));
String pessoaToJson(List<Pessoa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pessoa {
   int id;
   String nome;
   String observacao;
   String tipo;

  Pessoa({
    required this.id,
    required this.nome, 
    required this.observacao, 
    required this.tipo
  });
  
  factory Pessoa.fromJson(Map<String, dynamic> json){
    return Pessoa(
      id: json['id'],
      nome: json['nome'],
      observacao: json['observacao'],
      tipo: json['tipo']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'observacao': observacao,
      'tipo': tipo
    };
  }
}