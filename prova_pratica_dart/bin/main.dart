import 'dart:convert';
import '../lib/estrutura.dart';
import '../lib/envio_email.dart';

void main() async {
  final cliente = Cliente(codigo: 1, nome: 'João Alves', tipoCliente: 2);
  final vendedor = Vendedor(codigo: 101, nome: 'Mariana Rocha', comissao: 0.08);
  final veiculo = Veiculo(codigo: 501, descricao: 'Caminhão monstro', valor: 250000);

  final itens = [
    ItemPedido(sequencial: 1, descricao: 'Entrada', quantidade: 1, valor: 50000),
    ItemPedido(sequencial: 2, descricao: 'Parcela', quantidade: 10, valor: 20000),
  ];

  final pedido = PedidoVenda(
    codigo: 'PDV2025-001',
    data: DateTime.now(),
    valorPedido: 0, // será calculado
    cliente: cliente,
    vendedor: vendedor,
    veiculo: veiculo,
    items: itens,
  );

  final jsonData = jsonEncode(pedido.toJson());
  print('JSON gerado:\n$jsonData\n');

  await enviarEmail(jsonData);
}
