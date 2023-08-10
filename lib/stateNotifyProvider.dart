import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 3) StateNotifyProvider is a provider that is used to listen & expose a stateNotifier.
* StateNotifyProvider along with stateNotifier is a recommended soln. for managing state which
* may change interaction to user interaction. It is used for centralizing the business logic in
* single place, improving maintainability over time.
*  */

class CounterDemo extends StateNotifier<int>
{
  CounterDemo() : super(0); //initilazing the state with initial value as 0.

  void increment() {
    state++;
  }
}

final valueProvider = StateNotifierProvider.autoDispose<CounterDemo,int>((ref) {
  // ref.keepAlive();
  final link=ref.keepAlive();
  final timer= Timer(const Duration(seconds: 10),(){
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  return CounterDemo();
});

void main()
{
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
          primaryColor: Colors.purple
      ),
      home: MyFun(),
    );
  }
}

class MyFun extends ConsumerWidget {
  const MyFun({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final count = ref.watch(valueProvider);

    return Scaffold(
      appBar: AppBar(title: Text("StateNotifyProvider")),
      body: Center(
        child: Text("$count",style: const TextStyle(fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        ref.read(valueProvider.notifier).increment();
      }, child: const Icon(Icons.add)),
    );
  }
}
