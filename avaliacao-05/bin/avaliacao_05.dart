import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  String username = 'francisco.thiago09@aluno.ifce.edu.br';
  String password = 'tudb umyt byry fyyh';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'thiago-cdb')
    ..recipients.add('fthiagocordeirodebrito@gmail.com')
    ..subject = 'Email de teste:: ${DateTime.now()}'
    ..text = ''
    ..html =
        "<h1>Teste SMTP com Dart</h1>\n<p>Este é um email <b>enviado com sucesso</b>.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Email enviado: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Falha ao enviar email.');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}
