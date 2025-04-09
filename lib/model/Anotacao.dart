class Anotacao {
  int? id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  Anotacao.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        titulo = map["titulo"],
        descricao = map["descricao"],
        data = map["data"];

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "titulo": titulo,
      "descricao": descricao,
      "data": data,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}
