import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  /* ProviderScope stores all the states of the provider which will create in our application.
  Behind the scenes it actually creating an instance of ProviderContainer. The root of our app must be
  wrapped with ProviderScope.
   */
}

  /* 1)- Ist type of Riverpod provider is Provider. It is an object that encapsulates a piece of state and
  allows listening to that state. ref parameter used to read other providers.Provider<String> it holds a state of
   string type. It is used to access dependencies & objects that are immutable.  */

final nameProvider = Provider<String>((ref){
  return "Abhireet";
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage2(),
    );
  }
}

  /* Ist way to read the value from the created provider by using ConsumerWidget and creating an
  object ref of WidgetRef type in build constructor. */

class MyHomePage1 extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.wach is used to get the value of created provider
    final name= ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Provider"),),
      body: Center(
        child: Text(name),
      ),
    );
  }
}

/* 2nd way to read the value from the created provider by using Consumer. */
class MyHomePage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Center(
        child: Consumer(
          builder: (context,ref,child){
            final name = ref.watch(nameProvider);
            return Text(name);
          }
        ),
      ),
    );
  }
}

/* Till now what I've implemented that if the widget is stateless widget, how can we read or access
 the created provider. Now we'll see how to read the created provider when the widget is stateful
 widget*/
class MyHomePage3 extends ConsumerStatefulWidget {
  const MyHomePage3({super.key});

  @override
  _MyHomePage3State createState() => _MyHomePage3State();
}

class _MyHomePage3State extends ConsumerState<MyHomePage3> {
  @override
  Widget build(BuildContext context) {

    //we can also read the value of created provider from widget lifecycle method
    @override
    void initState(){
      super.initState();
      final name = ref.read(nameProvider);
      print(name);
    }

    final name = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Provider"),),
      body: Center(
        child: Text(name),
      ),
    );
  }
}

// 2) StateProvider
