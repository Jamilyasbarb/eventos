import 'package:flutter/material.dart';

import 'package:eventos/models/calendar_model.dart';
import 'package:eventos/models/evento_model.dart';
import 'package:eventos/models/hora_evento_model.dart';
import '../services/evento_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  List<Evento>? eventos;
  int hora = 6;
  int minuto = 00;
  bool isLoadded = false;
  List<HoraEvento> listaHora = [
  ];


  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    eventos = await EventoService().getEventos();
    if (eventos != null) {
      setState(() {
        // print(eventos?[0].evento);
        isLoadded = true;
      });
    }
  }

  List<HoraEvento> addHora() {
    for(var i = 0; i < 20; i++){
    // data = DateTime.parse(eventos![i].dataHora);   
    data = DateTime.utc(2022);
    print(data);
    HoraEvento horaEvento = HoraEvento(hora: hora, minuto: minuto);
      listaHora.add(horaEvento);
      // print(listaHora[i].hora);
      // print(minuto);
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
                Text('Data')
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaHora.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${listaHora[index].hora}:${listaHora[index].minuto}'),
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