import 'package:eventos/models/hora_evento_model.dart';

class Calendar{
  int dia;
  int mes;
  int ano;
  List<HoraEvento> listaHora;

  Calendar({
    required this.dia,
    required this.mes,
    required this.ano,
    required this.listaHora
  });
}