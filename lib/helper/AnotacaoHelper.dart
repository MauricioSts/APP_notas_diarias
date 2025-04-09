import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Anotacao.dart';

class AnotacaoHelper {
  static const String nomeTabela = "anotacao";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  Database? _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _inicializarDB();
    return _db!;
  }

  Future<Database> _inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    return await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String sql = '''
      CREATE TABLE $nomeTabela (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo VARCHAR,
        descricao TEXT,
        data DATETIME
      )
    ''';
    await db.execute(sql);
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    final bancoDados = await db;
    return await bancoDados.insert(nomeTabela, anotacao.toMap());
  }

  Future<List<Map<String, dynamic>>> recuperarAnotacoes() async {
    final bancoDados = await db;
    return await bancoDados.query(nomeTabela, orderBy: "data DESC");
  }
}
