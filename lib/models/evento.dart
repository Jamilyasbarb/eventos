import 'package:eventos/models/pessoa.dart';

class Evento{
  int id;
  String evento;
  String descricao;
  String local;
  List<Pessoa> listaPessoas;

  Evento({
    required this.id,
    required this.evento,
    required this.descricao,
    required this.local,
    required this.listaPessoas,
  });
}