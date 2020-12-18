import 'package:quantofalta/models/Avaliacao.dart';

class Materia{

  String nome;
  List<Avaliacao> avaliacoes = List<Avaliacao>();

  Materia({this.nome, this.avaliacoes}){

    this.avaliacoes = List<Avaliacao>();
  }


}