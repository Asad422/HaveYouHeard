

import 'package:equatable/equatable.dart';

class Artist extends Equatable{
  final String name;
  final String img;

  Artist({required this.name, required this.img});
  
  @override
  List<Object?> get props => [name,img];

}