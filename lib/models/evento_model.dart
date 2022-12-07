
import 'dart:convert';

import 'package:eventos/models/pessoa.dart';

List<Evento> eventoFromJson(String str) => List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));
String eventoToJson(List<Evento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Evento{
  int id;
  String evento;
  String descricao;
  String local;
  List<Pessoa> listaPessoas;
  String dataHora;

  Evento({
    required this.id,
    required this.evento,
    required this.descricao,
    required this.local,
    required this.listaPessoas,
    required this.dataHora
  });

  factory Evento.fromJson(Map<String, dynamic> json){
    return Evento(
      id: json['id'] ?? '',
      evento: json['evento'] ?? '',
      descricao: json['descricao'] ?? '',
      local: json['local'] ?? '',
      listaPessoas: List<Pessoa>.from(json['pessoas']?.map((x) => Pessoa.fromJson(x)) ?? const []),
      dataHora: json['dataHora'] ?? '', 
    );
  }

  Map<String,dynamic> toJson() =>{
    "id": id,
    "evento": evento,
    "descricao": descricao,
    "local": local,
    "listaPessoas": listaPessoas,
    "dataHora": dataHora
  };
}