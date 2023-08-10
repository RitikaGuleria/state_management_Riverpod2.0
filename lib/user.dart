import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String name;
  final String address;

  const User({required this.name, required this.address});

  @override
  List<Object?> get props => [name,address];
}