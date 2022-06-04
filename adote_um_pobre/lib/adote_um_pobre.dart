/*
Neste projeto, uma pessoa, o "pobre", pode pedir presentes, que serão escolhidos
pelos "ricos".
Para poder pedir presentes, o pobre deve realizar missões e ganhar créditos. 
O valor máximo do presente pedido depende do valor dos créditos que o pobre conseguiu.
O rico recebe um cashback de acordo com o valor do presente dado.
*/

void show() {
  /*
  var cashback = calcularCashbackRico(200, (valorPresente) {
    if (valorPresente >= 100 && valorPresente <= 500) {
      return 0.10;
    } else if (valorPresente > 500) {
      return 0.20;
    } else {
      return 0.0;
    }
  });

  print(cashback);

  print(ganharCreditosPorMissao());

  var pedido = pedirPresente((quantidadeCreditos) => quantidadeCreditos * 0.1,
      valorPresente: -50.0,
      urlPresente: 'http://www.presente.com',
      quantidadeCreditos: 100,
      mensagemApelo: 'Ô moço! Realiza meu sonho aí!');
  print(pedido);

  print(presentearPobreEGanharPontos(-1000));
  print(trocarPontosPorBeneficios(1000));

  print(converterPontosEmEstrelas(-10000));

  print(pedirPresentePorAmigoEGanharCreditos(false,
      valorPresente: 100,
      urlPresente: 'http://www.presente.com',
      nomeAmigo: 'José'));

  print(indicarAmigoRicoEGanharPontos(true,
      nomeAmigo: 'Maria', emailAmigo: 'maria@email.com'));
  print(venderProdutosEGanharCreditos(5, calcularPorcentagemCredito));
  */

  var pontosRico =
      comprarProdutosEGanharPontos(100, (valorProduto) => valorProduto * 0.05);

  print(pontosRico);
}

double calcularCashbackRico(
    double valorPresente, Function calcularPorcentagemCashback) {
  verificarValorNegativo(valorPresente);
  double porcentagemCashback = calcularPorcentagemCashback(valorPresente);

  return valorPresente * porcentagemCashback;
}

//nessa função, o pobre vai realizar uma missão e receber créditos de acordo com o grau de dificuldade da missão
int ganharCreditosPorMissao([String nivelDificuldade = 'facil']) {
  validarNivelDificuldade(nivelDificuldade);
  print(nivelDificuldade);
  if (nivelDificuldade == 'medio') {
    return 50;
  } else if (nivelDificuldade == 'dificil') {
    return 100;
  } else if (nivelDificuldade == 'muitoDificil') {
    return 500;
  } else if (nivelDificuldade == 'mimAjudaPorFavor') {
    return 10000;
  } else {
    return 10;
  }
}

String pedirPresente(Function calcularValorMaximo,
    {required double valorPresente,
    required String urlPresente,
    required int quantidadeCreditos,
    String mensagemApelo = 'Mim dá esse presente pufavô!'}) {
  double valorMaximo = calcularValorMaximo(quantidadeCreditos);
  verificarValorNegativo(valorPresente);
  validarUrlPresente(urlPresente);

  if (valorPresente <= valorMaximo) {
    return 'Presente cadastrado com sucesso! Aguarde um rico te atender!';
  } else {
    return 'Créditos insuficientes para realizar pedido. Peça um presente de menor valor ou realize mais missões!';
  }
}

//o pobre pode pedir um presente para um amigo, se o pedido for atendido, ele ganha créditos
double pedirPresentePorAmigoEGanharCreditos(bool atenderPedido,
    {required double valorPresente,
    required String urlPresente,
    required String nomeAmigo,
    String mensagem =
        'Mim ajude a fazer meu amigo feliz, ele precisa mais que eu!'}) {
  verificarValorNegativo(valorPresente);
  validarUrlPresente(urlPresente);

  if (atenderPedido) {
    return 250.0;
  } else {
    return 10.0;
  }
}

//o pobre pode também vender alguns produtos (por exemplo, artesanato ou alimentos que ele produz) e ganhar créditos
double venderProdutosEGanharCreditos(
    double valorProduto, Function calcularPorcentagemCredito) {
  verificarValorNegativo(valorProduto);
  double porcentagemCredito = calcularPorcentagemCredito(valorProduto);

  return valorProduto * porcentagemCredito;
}

//Além do cashback, o rico também ganha pontos que podem ser trocados por beneficios
double presentearPobreEGanharPontos(double valorPedido,
    [String mensagem = 'Tua história me comoveu! Toma teu presente!']) {
  verificarValorNegativo(valorPedido);
  print('Parabéns! Sua bondade fez um pobre feliz!');
  return valorPedido * 0.01;
}

double indicarAmigoRicoEGanharPontos(bool indicacaoAceita,
    {required String nomeAmigo,
    required String emailAmigo,
    String mensagem = 'Ei amigo, vamos participar ajudando os pobres?'}) {
  validarEmail(emailAmigo);

  if (indicacaoAceita) {
    return 5.0;
  } else {
    return 0.1;
  }
}

String trocarPontosPorBeneficios(double pontos) {
  verificarValorNegativo(pontos);

  if (pontos >= 10 && pontos < 100) {
    return 'Iphone';
  } else if (pontos >= 100 && pontos < 1000) {
    return 'Viagem para Paris';
  } else if (pontos >= 1000) {
    return 'Viagem para qualquer lugar do mundo!';
  } else {
    return 'Pontos insuficientes. Continue fazendo caridade!';
  }
}

//a cada 200 pontos o rico conquista uma estrela para ficar ao lado do perfil e garantir destaque na plataforma
// o número máximo de estrelas é 5
double converterPontosEmEstrelas(double pontos) {
  verificarValorNegativo(pontos);
  if (pontos > 1000) {
    return 5.0;
  }

  return pontos / 200;
}

//o rico pode comprar produtos vendidos pelos pobres e ganhar pontos
double comprarProdutosEGanharPontos(
    double valorProduto, Function calcularPorcentagemPontos) {
  verificarValorNegativo(valorProduto);
  double porcentagemPontos = calcularPorcentagemPontos(valorProduto);
  return valorProduto * porcentagemPontos;
}

void verificarValorNegativo(double valor) {
  if (valor < 0) {
    throw Exception('O valor não pode ser negativo!');
  }
}

void validarNivelDificuldade(String nivelDificuldade) {
  if (nivelDificuldade != 'facil' &&
      nivelDificuldade != 'medio' &&
      nivelDificuldade != 'dificil' &&
      nivelDificuldade != 'muitoDificil' &&
      nivelDificuldade != 'mimAjudaPorFavor') {
    throw Exception(
        'Informe um valor válido para o nível de dificuldade da missão!');
  }
}

void validarUrlPresente(String url) {
  if (!url.startsWith('http')) {
    throw Exception('Informe uma url válida!');
  }
}

void validarEmail(String email) {
  if (!email.contains('@')) {
    throw Exception('Informe um email válido!');
  }
}

double calcularPorcentagemCredito(valorProduto) {
  if (valorProduto >= 10 && valorProduto < 100) {
    return 0.02;
  } else if (valorProduto >= 100 && valorProduto < 1000) {
    return 0.05;
  } else if (valorProduto >= 1000) {
    return 0.1;
  } else {
    return 0.0;
  }
}
