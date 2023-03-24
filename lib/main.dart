import 'package:classschedule_app/bloc/BlocTwo.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './bloc/CounterBloc.dart';
import './bloc/BlocProvider.dart';

void main() {
  runApp(ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  ScheduleApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      home: Test()
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext contextt) {
    final CounterBloc? Counter = BlocProvider.of<CounterBloc>(contextt);
    return Scaffold(
      appBar: AppBar(
        title: Text("Petar"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: Counter?.counterStream,
          builder: (context, snapshot) {
            if(snapshot.data != null) {
              return Column(
                children: [
                  Text(snapshot.data.toString(), style: TextStyle(fontSize: 30),),
                  ElevatedButton(onPressed: () {
                    Navigator.push(contextt, MaterialPageRoute(builder: (context) => const primer()));
                  }, child: Text('Next page'))
                ],
              );
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Counter?.handleState();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class primer extends StatelessWidget {
  const primer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc? CounterBlock = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Column(
        children: [
          StreamBuilder<int>(
            initialData: CounterBlock?.count,
            stream: CounterBlock?.counterStream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              if(snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data.toString()),
                    ElevatedButton(onPressed: () {
                      Navigator.pop(context);}, child: Text('Petar')),
                    ElevatedButton(onPressed: () {
                      CounterBlock?.handleState();
                    }, child: Text('MNOZI'))
                  ],
                );
              } else {
                return Column(
                  children: [
                    Text("NEMA PARE"),
                    ElevatedButton(onPressed: () {
                      CounterBlock?.handleState();
                    }, child: Text('Change'))
                  ]
                );
              }
            }),
          ]
      ),
    );
  }
}





