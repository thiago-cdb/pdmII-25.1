class Cliente {
  int codigo;
  String nome;
  int tipoCliente;

  Cliente({required this.codigo, required this.nome, required this.tipoCliente});

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nome': nome,
        'tipoCliente': tipoCliente,
      };
}

class Vendedor {
  int codigo;
  String nome;
  double comissao;

  Vendedor({required this.codigo, required this.nome, required this.comissao});

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nome': nome,
        'comissao': comissao,
      };
}

class Veiculo {
  int codigo;
  String descricao;
  double valor;

  Veiculo({required this.codigo, required this.descricao, required this.valor});

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'descricao': descricao,
        'valor': valor,
      };
}

class ItemPedido {
  int sequencial;
  String descricao;
  int quantidade;
  double valor;

  ItemPedido({
    required this.sequencial,
    required this.descricao,
    required this.quantidade,
    required this.valor,
  });

  Map<String, dynamic> toJson() => {
        'sequencial': sequencial,
        'descricao': descricao,
        'quantidade': quantidade,
        'valor': valor,
      };
}

class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cliente;
  Vendedor vendedor;
  Veiculo veiculo;
  List<ItemPedido> items;

  PedidoVenda({
    required this.codigo,
    required this.data,
    required this.valorPedido,
    required this.cliente,
    required this.vendedor,
    required this.veiculo,
    required this.items,
  });

  double calcularPedido() {
    return items.fold(0, (sum, item) => sum + item.valor * item.quantidade);
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'data': data.toIso8601String(),
        'valorPedido': calcularPedido(),
        'cliente': cliente.toJson(),
        'vendedor': vendedor.toJson(),
        'veiculo': veiculo.toJson(),
        'items': items.map((e) => e.toJson()).toList(),
      };
}
