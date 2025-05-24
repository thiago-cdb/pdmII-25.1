import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;

void main() {
  final dbPath = p.join(Directory.current.path, 'alunos.db');
  final db = sqlite3.open(dbPath);

  // Criação da tabela
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL
    );
  ''');

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Inserir aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Opção: ');
    final opcao = stdin.readLineSync();

    if (opcao == '1') {
      inserirAluno(db);
    } else if (opcao == '2') {
      listarAlunos(db);
    } else if (opcao == '0') {
      print('Encerrando...');
      db.dispose();
      break;
    } else {
      print('Opção inválida!');
    }
  }
}

void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (até 50 caracteres): ');
  final nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty || nome.length > 50) {
    print('Nome inválido.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?);');
  stmt.execute([nome.trim()]);
  stmt.dispose();

  print('Aluno inserido com sucesso!');
}

void listarAlunos(Database db) {
  final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO;');

  print('\nLista de Alunos:');
  for (final row in result) {
    print('ID: ${row['id']} | Nome: ${row['nome']}');
  }
}
