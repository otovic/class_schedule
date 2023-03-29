import 'package:classschedule_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './Bloc2/DataBloc.dart';
import './SettingsBloc/SettingsBloc.dart';

void main() {
  runApp(ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  ScheduleApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (context) {
              return SettingsBloc();
            },
            child: Test2()));
  }
}

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(listener: (context, state) {
        if (state.status == loadStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
              'Authentication Failure',
              textDirection: TextDirection.ltr,
            )));
        }
      }, child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return Column(
          children: [
            Text(state.settings.classLenght.toString()),
            ElevatedButton(
                onPressed: () {
                  // context
                  //     .read<DataBloc>()
                  //     .add(StatusChangedd(ReadStatus.notstarted));
                },
                child: const Text('Promeni')),
            Text(state.status.toString())
          ],
        );
      })),
    );
  }
}


// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext contextt) {
//     final CounterBloc? Counter = BlocProvider.of<CounterBloc>(contextt);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Petar"),
//         backgroundColor: Colors.amber,
//       ),
//       body: Center(
//         child: StreamBuilder<int>(
//           stream: Counter?.counterStream,
//           builder: (context, snapshot) {
//             if(snapshot.data != null) {
//               return Column(
//                 children: [
//                   Text(snapshot.data.toString(), style: TextStyle(fontSize: 30),),
//                   ElevatedButton(onPressed: () {
//                     Navigator.push(contextt, MaterialPageRoute(builder: (context) => const primer()));
//                   }, child: Text('Next page'))
//                 ],
//               );
//             } else {
//               return Text('Loading');
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Counter?.handleState();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class primer extends StatelessWidget {
//   const primer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CounterBloc? CounterBlock = BlocProvider.of<CounterBloc>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HOME"),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<int>(
//             initialData: CounterBlock?.count,
//             stream: CounterBlock?.counterStream,
//             builder: (context, AsyncSnapshot<int> snapshot) {
//               if(snapshot.hasData) {
//                 return Column(
//                   children: [
//                     Text(snapshot.data.toString()),
//                     ElevatedButton(onPressed: () {
//                       Navigator.pop(context);}, child: Text('Petar')),
//                     ElevatedButton(onPressed: () {
//                       CounterBlock?.handleState();
//                     }, child: Text('MNOZI'))
//                   ],
//                 );
//               } else {
//                 return Column(
//                   children: [
//                     Text("NEMA PARE"),
//                     ElevatedButton(onPressed: () {
//                       CounterBlock?.handleState();
//                     }, child: Text('Change'))
//                   ]
//                 );
//               }
//             }),
//           ]
//       ),
//     );
//   }
// }





