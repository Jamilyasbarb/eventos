import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/evento_model.dart';

class EventoService{

  Future<List<Evento>> getEventos()async{
    var response = await http.get(Uri.parse('http://192.168.0.105:8080/eventos'));
      print(response.statusCode);
      print('objectrrrrrrrrrrrrooooooooo');

    if(response.statusCode == 200){
      print('objectrrrrrrrrrrrrooooooooo');
      var json = response.body;
      return eventoFromJson(json); 
    }else{
      throw Exception('Failed to load album');
    }
  }
  
}