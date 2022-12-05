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
  final DateFormat dia = DateFormat('d');
  final DateFormat mes = DateFormat('M');
  final DateFormat ano = DateFormat('y');
  List<HoraEvento> listaHora = [];


  @override
  void initState() {
    super.initState();
    getCalendar();
    getData();
  }

  Calendar getCalendar(){
    String dataDia = dia.format(now);
    String dataMes = mes.format(now);
    String dataAno = ano.format(now);
    Calendar calendar = Calendar(dia: int.parse(dataDia), mes: int.parse(dataMes),
      ano: int.parse(dataAno), listaHora: listaHora);
    return calendar;
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      getCalendar().dia--;
                      // print(--);
                    });
                    // print('click 1');
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '${getCalendar().dia}/${getCalendar().mes}/${getCalendar().ano}',
                  style: TextStyle(fontSize: 30),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // dia.;
                    // print('click 2');
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
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