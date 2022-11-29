import 'package:eventos/models/evento_model.dart';
import 'package:flutter/material.dart';

import '../services/evento_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Evento>? eventos;
   bool isLoadded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async{
    eventos = await EventoService().getEventos();
    if(eventos != null){
      setState(() {
        print(eventos?[0].evento);
        isLoadded = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
        visible: isLoadded,
        replacement: CircularProgressIndicator(),
          child: GridView.builder(
          itemCount: eventos?.length,
          itemBuilder: (context, index) => 
          Column(
              children: [
                Expanded(child: Text('1 ${eventos![index].evento}')),
              ],
            ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
          ),
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