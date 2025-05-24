import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  String username = 'remetente';
  String password = 'senha'; // senha de app

  final smtpServer = gmail(username, password);

  for (int i = 1; i <= 22; i++) {
    final message = Message()
      ..from = Address(username, 'Seu Nome')
      ..recipients.add('destinatario')
      ..subject = ''
      ..text = ''
      ..html = "<";

    try {
      final sendReport = await send(message, smtpServer);
      print('✅ [$i] Email enviado com sucesso.');
    } on MailerException catch (e) {
      print('❌ [$i] Falha ao enviar email.');
      for (var p in e.problems) {
        print('Problema: ${p.code}: ${p.msg}');
      }
    }

    // Aguarda 3 segundos entre os envios para evitar bloqueios
    await Future.delayed(Duration(seconds: 3));
  }

  print('\n🎯 Fim do envio de 22 e-mails.');
}
