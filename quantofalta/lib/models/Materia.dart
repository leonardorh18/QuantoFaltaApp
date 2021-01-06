import 'package:quantofalta/models/Avaliacao.dart';

class Materia{

  String nome;
  List<Avaliacao> avaliacoes = List<Avaliacao>();
  String id;
  String share_id;

  Materia({this.nome, this.avaliacoes, this.id, this.share_id}){


  }


}