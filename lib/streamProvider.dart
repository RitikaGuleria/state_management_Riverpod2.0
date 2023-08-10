import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final streamProvider = StreamProvider((ref){
  return Stream.periodic(const Duration(seconds: 2),((computationCount) => computationCount));
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final streamData = ref.watch(streamProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Stream Provider"),),
      body: streamData.when(data: (data) => Center(
        child: Text(data.toString()),
      ), error: ((error,stackTrace) => Text(error.toString())), loading: () => const Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
