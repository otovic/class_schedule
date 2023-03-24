import 'package:flutter/material.dart';

import './bloc.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget{
  final T bloc;
  final Widget child;


  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  State createState() => BlocProviderState<T>();

  static T? of<T extends BlocBase>(BuildContext context, {bool listen = true}) {
    final BlocProvider<T>? provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider?.bloc;
  }
}

class BlocProviderState<T> extends State<BlocProvider>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}