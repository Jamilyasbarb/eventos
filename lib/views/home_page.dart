import 'package:eventos/models/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eventos/models/evento_model.dart';
import 'package:eventos/models/hora_evento_model.dart';
import '../services/evento_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  final DateTime now = DateTime.now();
  List<Evento>? eventos;
  int hora = 6;
  int minuto = 00;
  bool isLoadded = false;
  bool registrarEvento = false;
  DateTime? dateBackend;
  bool isChecked = false;
  // int dia = 0;
  // int mes = 0;
  // int ano = 0;
  int posicaoDia = 0;
  int contPessoa = 0;
  int day = 0;
  int month = 0;
  int year = 0;
  int ultimoDiaMesFormatted = 0;
  int ultimoDiaMesAnteriorFormatted = 0;
  List<HoraEvento> listaHora = [];
  List<bool> eventoFilter = [];
  List<String> filter = ['Descricao', 'Participantes', 'Local'];
  List<String> listaEventoFiltrado = [];
  String filtrado = '';
  int posicaoFilter = 0;


  @override
  void initState() {
    super.initState();
    getData();
    // dia = now.day;
    // mes = now.month;
    // ano = now.year;
  }

  getData() async {
    eventos = await EventoService().getEventos();
    if (eventos != null) {
      dateBackend = DateTime.parse(eventos![1].dataHora);
      day = dateBackend!.day;
      month = dateBackend!.month;
      year = dateBackend!.year;
      setState(() {
        isLoadded = true;
        eventoFilter = List.filled(eventos!.length, false);
        // temEvento();
      });
    }
  }

  List<HoraEvento> addHora() {
    for(var i = 0; i < 20; i++){
      HoraEvento horaEvento = HoraEvento(hora: hora, minuto: minuto);
      listaHora.add(horaEvento);
      minuto+= 30;
      if (minuto == 60) {
        minuto = 0;
        if(hora != 22){
          hora++;
        }else{
          break;
        }
      }
    }
    return listaHora;
  }

  bool verificaHora(int hora){
    registrarEvento = false;
    posicaoDia = 0;
    for(var i =0; i < eventos!.length; i++){
      DateTime data = DateTime.parse(eventos![i].dataHora);
      if(data.day == day && data.month == month && data.year == year){
        if(hora == data.hour){
          for(var p = 0; p < eventos![i].listaPessoas.length; p++){
            contPessoa = p;
          }
          registrarEvento = true;
          posicaoDia = i;
        }
      }
    }
    return registrarEvento;
  }

  filtraEvento(int index, String filtro){
    if(eventoFilter[index] == true && filtro == 'Descricao'){
      return eventos![posicaoDia].descricao;
    }else if(eventoFilter[index] == true && filtro == 'Participantes'){
      return eventos![posicaoDia].listaPessoas[0].nome;
    }else if(eventoFilter[index] == true && filtro == 'Local'){
      return eventos![posicaoDia].local;
    }

    return 'jajaja';
  }

    
  @override
  Widget build(BuildContext context) {
    DateTime ultimoDiaMes = DateTime(year, month + 1, 0);
    DateTime ultimoDiaMesAnterior = DateTime(year, month, 0);
    ultimoDiaMesFormatted = ultimoDiaMes.day;
    ultimoDiaMesAnteriorFormatted = ultimoDiaMesAnterior.day;
    Calendar calendar = Calendar(dia: day, mes: month,
      ano: year, listaHora: listaHora);

    if(hora != 22){
      addHora();
    }    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('WSA2014 Events'),
        actions: [
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                context: context, 
                builder: (BuildContext ctx){
                  return StatefulBuilder(
                    builder:(context, setState) {
                      return SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: eventos!.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text('${filter[index]}'),
                                    value: eventoFilter[index], 
                                    onChanged: (value) {
                                      setState(() {
                                        eventoFilter[index] = value!;
                                        posicaoFilter = index;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }, 
                    
                  );
                }
              );
            }, 
            icon: Icon(Icons.filter_alt)
          ),
        ],
      ),
      body: Visibility(
        visible: isLoadded,
        replacement: CircularProgressIndicator(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      if(day != 1){
                        day--;
                      }else{
                        month--;
                        print(ultimoDiaMesFormatted);
                        day = ultimoDiaMesAnteriorFormatted;
                      }
                      print(day);
                    });
                  },
                ),
                Text(
                  '${calendar.dia}/${calendar.mes}/${calendar.ano}',
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    setState(() {
                      print('ultimo dia $ultimoDiaMesFormatted');
                      if(day != ultimoDiaMesFormatted){
                        day++;
                      }else{
                        if(month != 12){
                          month++;
                          day = 1;
                        }else{
                          day = 1;
                          month = 1;
                          year++;
                        }
                      }
                      print(day);
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: calendar.listaHora.length,
                itemBuilder: ((context, index) {
                  verificaHora(listaHora[index].hora);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${calendar.listaHora[index].hora}:${calendar.listaHora[index].minuto}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              registrarEvento ? Expanded(
                                child: Column(
                                  children: [
                                    Text('${eventos![posicaoDia].evento}'), 
                                    filter[posicaoFilter] == 'Descricao' && eventoFilter[posicaoFilter] ? 
                                      Text('${eventos![posicaoDia].descricao}'): Text(''),
                                    filter[posicaoFilter] == 'Participantes' && eventoFilter[posicaoFilter] ? Text('${eventos![posicaoDia].listaPessoas[contPessoa].nome}') : Text(''),
                                    filter[posicaoFilter] == 'Local' && eventoFilter[posicaoFilter] ? Text('${eventos![posicaoDia].local}') : Text(''),
                                  ],    
                                    ),
                              ) : Row(children: [Text('')],),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ListView.builder(
//           itemCount: eventos?.length,
//           itemBuilder: ((context, index) {
//             return Text(eventos![index].evento);
//           })
//         ),

// GridView.builder(
//           itemCount: eventos?.length,
//           itemBuilder: (context, index) => 
//           Column(
//               children: [
//                 Expanded(child: Text('1 ${eventos![index].evento}')),
//               ],
//             ),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 7,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8
//           ),
//         ),