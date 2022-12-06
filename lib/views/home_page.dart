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
  DateTime? dateBackend;
  // int dia = 0;
  // int mes = 0;
  // int ano = 0;
  int day = 0;
  int month = 0;
  int year = 0;
  int ultimoDiaMesFormatted = 0;
  int ultimoDiaMesAnteriorFormatted = 0;
  List<HoraEvento> listaHora = [];


  @override
  void initState() {
    super.initState();
    getData();
     
    // dia = now.day;
    // mes = now.month;
    // ano = now.year;
   
    print(day);
  }

  getData() async {
    eventos = await EventoService().getEventos();
    if (eventos != null) {
      dateBackend = DateTime.parse(eventos![1].dataHora);
      day = dateBackend!.day;
      month = dateBackend!.month;
      year = dateBackend!.year;
      setState(() {
        // print(eventos?[0].evento);
        isLoadded = true;
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
    
    // Calendar calendar = Calendar()
    return listaHora;
  }

  @override
  Widget build(BuildContext context) {
    DateTime ultimoDiaMes = DateTime(year, month + 1, 0);
    print('mes testeeeee$month');
    print('uktimo dia mes$ultimoDiaMesFormatted');
    DateTime ultimoDiaMesAnterior = DateTime(year, month, 0);
    ultimoDiaMesFormatted = ultimoDiaMes.day;
    print('ultimo dia formatado $ultimoDiaMesFormatted');
    ultimoDiaMesAnteriorFormatted = ultimoDiaMesAnterior.day;
    Calendar calendar = Calendar(dia: day, mes: month,
      ano: year, listaHora: listaHora);



    if(hora != 22){
      addHora();
    }    
    return Scaffold(
      appBar: AppBar(),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${calendar.listaHora[index].hora}:${calendar.listaHora[index].minuto}'),
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