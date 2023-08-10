import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/futureProvider/api_service.dart';
import 'package:state_management_riverpod/futureProvider/user_model.dart';


void main(){
  runApp(const ProviderScope(child: MyApp()));
}

final apiProvider = Provider<ApiService>((ref) => ApiService());

final userDataProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(apiProvider).getUser();
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Future Provider"),),
      body: userData.when(data: (data){
        return ListView.builder(itemBuilder: ((context,index){
          return ListTile(title: Text("${data[index].firstname} ${data[index].lastname}"),subtitle:Text(data[index].email) ,leading:
            CircleAvatar(child: Image.network(data[index].avatar),),);
        }),itemCount: data.length,);
      }, error: ((error,stackTrace) => Text(error.toString())), loading: (){
        return const Center(child: CircularProgressIndicator(),);
      }),
    );
  }
}

