import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 2) StateProvider- It is used to store simple mutabe objects,it cannot be used to store
 the complex objects. */

final counterProvider = StateProvider<int>((ref) => 0);

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

    final count = ref.watch(counterProvider);

    ref.listen(counterProvider, (previous, next) {
      if(next == 5)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The value is $next")));
        }
    });

    return Scaffold(
      appBar: AppBar(title: Text("StateProvider"),actions: [
        IconButton(onPressed: (){

          // ref.invalidate(counterProvider);
          ref.refresh(counterProvider);

        }, icon: const Icon(Icons.refresh))
      ],),
      body: Center(
        child: Text(count.toString(),style: const TextStyle(fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        // ref.read(counterProvider.notifier).state++;
        ref.read(counterProvider.notifier).update((state) => state+1);
      }, child: const Icon(Icons.add)),
    );
  }
}
