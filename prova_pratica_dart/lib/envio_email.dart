import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


Future<void> enviarEmail(String jsonData) async {
  final tempDir = Directory.systemTemp;
  final filePath = p.join(tempDir.path, 'pedido.json');
  final file = File(filePath);

  await file.writeAsString(jsonData);

  final smtpServer = gmail('francisco.thiago09@aluno.ifce.edu.br', 'tudb umyt byry fyyh');

  final message = Message()
    ..from = Address('francisco.thiago09@aluno.ifce.edu.br', 'Francisco Thiago Cordeiro de Brito')
    ..recipients.add('taveira@ifce.edu.br')
    ..subject = 'PROVA PRATICA-DART'
    ..text = 'Segue em anexo o arquivo JSON gerado.'
    ..attachments = [
      FileAttachment(file)
        ..location = Location.inline
        ..fileName = 'pedido.json',
    ];

  try {
    final sendReport = await send(message, smtpServer);
    print('Email enviado: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Erro ao enviar: $e');
  }
}
