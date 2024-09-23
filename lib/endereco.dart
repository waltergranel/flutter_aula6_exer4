class Endereco {
  final String logradouro;
  final String bairro;
  final String cidade;
  final String estado;

  Endereco({
    required this.logradouro,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });

  // Método para converter um Map em um objeto Endereco
  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      cidade: json['localidade'],
      estado: json['estado'],
    );
  }
}