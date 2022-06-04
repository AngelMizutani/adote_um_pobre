import 'package:adote_um_pobre/adote_um_pobre.dart';
import 'package:test/test.dart';

void main() {
  test('calcular valor do cashback com presente valendo entre 100 e 500', () {
    expect(
        calcularCashbackRico(400, (valorPresente) {
          if (valorPresente >= 100 && valorPresente <= 500) {
            return 0.10;
          } else if (valorPresente > 500) {
            return 0.20;
          } else {
            return 0;
          }
        }),
        40);
  });

  test('calcular valor do cashback com presente valendo mais de 500', () {
    expect(
        calcularCashbackRico(800, (valorPresente) {
          if (valorPresente >= 100 && valorPresente <= 500) {
            return 0.10;
          } else if (valorPresente > 500) {
            return 0.20;
          } else {
            return 0;
          }
        }),
        160);
  });

  test('calcular valor do cashback com presente valendo menos de 100', () {
    expect(
        calcularCashbackRico(50, (valorPresente) {
          if (valorPresente >= 100 && valorPresente <= 500) {
            return 0.10;
          } else if (valorPresente > 500) {
            return 0.20;
          } else {
            return 0.0;
          }
        }),
        0.0);
  });

  test('deve gerar exceção quando o valor do presente é negativo', () {
    expect(
        () => calcularCashbackRico(-50, (valorPresente) {
              if (valorPresente >= 100 && valorPresente <= 500) {
                return 0.10;
              } else if (valorPresente > 500) {
                return 0.20;
              } else {
                return 0.0;
              }
            }),
        throwsException);
  });

  group('testar os créditos ganhos por missão realizada', () {
    test('verificar crédito recebido na missão fácil', () {
      expect(ganharCreditosPorMissao(), 10);
    });
    test('verificar crédito recebido na missão média', () {
      expect(ganharCreditosPorMissao('medio'), 50);
    });
    test('verificar crédito recebido na missão dificil', () {
      expect(ganharCreditosPorMissao('dificil'), 100);
    });
    test('verificar crédito recebido na missão muito difícil', () {
      expect(ganharCreditosPorMissao('muitoDificil'), 500);
    });
    test(
        'verificar crédito recebido na missão "mim Ajuda por favor", a.k.a. impossível',
        () {
      expect(ganharCreditosPorMissao('mimAjudaPorFavor'), 10000);
    });
    test('verificar exceção em missão inválida', () {
      expect(() => ganharCreditosPorMissao('blablabla'), throwsException);
    });
  });

  group('testar o presente pedido pelo pobre', () {
    test(
        'verificar pedido com valor positivo, url correta e créditos suficientes',
        () {
      expect(
          pedirPresente((quantidadeCreditos) => quantidadeCreditos * 0.1,
              valorPresente: 10.0,
              urlPresente: 'http://www.presente.com',
              quantidadeCreditos: 100,
              mensagemApelo: 'Ô moço! Realiza meu sonho aí!'),
          'Presente cadastrado com sucesso! Aguarde um rico te atender!');
    });

    test(
        'verificar pedido com valor positivo, url correta e créditos insuficientes',
        () {
      expect(
          pedirPresente((quantidadeCreditos) => quantidadeCreditos * 0.1,
              valorPresente: 50.0,
              urlPresente: 'http://www.presente.com',
              quantidadeCreditos: 100,
              mensagemApelo: 'Ô moço! Realiza meu sonho aí!'),
          'Créditos insuficientes para realizar pedido. Peça um presente de menor valor ou realize mais missões!');
    });
    test('verificar exceção valor presente negativo', () {
      expect(
          () => pedirPresente((quantidadeCreditos) => quantidadeCreditos * 0.1,
              valorPresente: -50.0,
              urlPresente: 'http://www.presente.com',
              quantidadeCreditos: 500,
              mensagemApelo: 'Ô moço! Realiza meu sonho aí!'),
          throwsException);
    });
    test('verificar exceção url inválida', () {
      expect(
          () => pedirPresente((quantidadeCreditos) => quantidadeCreditos * 0.1,
              valorPresente: 50.0,
              urlPresente: 'www.presente.com',
              quantidadeCreditos: 500,
              mensagemApelo: 'Ô moço! Realiza meu sonho aí!'),
          throwsException);
    });
  });

  group('testar pedido para outro amigo', () {
    test('verificar pedido atendido, com valor positivo e url válida', () {
      expect(
          pedirPresentePorAmigoEGanharCreditos(true,
              valorPresente: 100,
              urlPresente: 'http://www.presente.com',
              nomeAmigo: 'Maria'),
          250);
    });
    test('verificar pedido não atendido, com valor positivo e url válida', () {
      expect(
          pedirPresentePorAmigoEGanharCreditos(false,
              valorPresente: 100,
              urlPresente: 'http://www.presente.com',
              nomeAmigo: 'Maria'),
          250);
    });

    test('verificar excecao com valor negativo do pedido', () {
      expect(
          () => pedirPresentePorAmigoEGanharCreditos(true,
              valorPresente: -100,
              urlPresente: 'http://www.presente.com',
              nomeAmigo: 'Maria'),
          throwsException);
    });
    test('verificar excecao com url do pedido inválida', () {
      expect(
          () => pedirPresentePorAmigoEGanharCreditos(true,
              valorPresente: 100,
              urlPresente: 'www.presente.com',
              nomeAmigo: 'Maria'),
          throwsException);
    });
  });

  group('verificar creditos com venda de produtos', () {
    test('verificar credito com produto abaixo de 10', () {
      expect(venderProdutosEGanharCreditos(5, calcularPorcentagemCredito), 0.0);
    });

    test('verificar credito com produto entre 10 e 100', () {
      expect(
          venderProdutosEGanharCreditos(20, calcularPorcentagemCredito), 0.4);
    });

    test('verificar credito com produto entre 100 e 1000', () {
      expect(
          venderProdutosEGanharCreditos(200, calcularPorcentagemCredito), 10.0);
    });

    test('verificar credito com produto maior que 1000', () {
      expect(venderProdutosEGanharCreditos(2000, calcularPorcentagemCredito),
          200.0);
    });

    test('verificar excecao com valor negativo', () {
      expect(
          () => venderProdutosEGanharCreditos(-200, calcularPorcentagemCredito),
          throwsException);
    });
  });

  group('testar pedido atendido pelo rico', () {
    test('verificar pedido com valor positivo', () {
      expect(presentearPobreEGanharPontos(1000), 10);
    });
    test('verificar exceção com valor negativo', () {
      expect(() => presentearPobreEGanharPontos(-1000), throwsException);
    });
  });

  group('testar indicacao de amigo rico', () {
    test('verificar indicacao aceita', () {
      expect(
          indicarAmigoRicoEGanharPontos(true,
              nomeAmigo: 'Maria', emailAmigo: 'maria@email.com'),
          5.0);
    });
    test('verificar indicacao recusada', () {
      expect(
          indicarAmigoRicoEGanharPontos(false,
              nomeAmigo: 'Maria', emailAmigo: 'maria@email.com'),
          0.1);
    });
    test('verificar exceção com email inválido', () {
      expect(
          () => indicarAmigoRicoEGanharPontos(true,
              nomeAmigo: 'Maria', emailAmigo: 'maria'),
          throwsException);
    });
  });

  group('testar beneficios trocados por pontos', () {
    test('verificar beneficio com valor abaixo de 10', () {
      expect(trocarPontosPorBeneficios(1),
          'Pontos insuficientes. Continue fazendo caridade!');
    });

    test('verificar beneficio com valor entre 10 e 100', () {
      expect(trocarPontosPorBeneficios(50), 'Iphone');
    });

    test('verificar beneficio com valor entre 100 e 1000', () {
      expect(trocarPontosPorBeneficios(500), 'Viagem para Paris');
    });

    test('verificar beneficio com valor superior a 1000', () {
      expect(trocarPontosPorBeneficios(5000),
          'Viagem para qualquer lugar do mundo!');
    });

    test('verificar excecao com valor negativo', () {
      expect(() => trocarPontosPorBeneficios(-5000), throwsException);
    });
  });

  group('testar pontos convertidos em estrelas', () {
    test('verificar quantidade de estrelas com pontos entre até 1000', () {
      expect(converterPontosEmEstrelas(500), 2.5);
    });

    test('verificar quantidade de estrelas com pontos acima de 1000', () {
      expect(converterPontosEmEstrelas(1200), 5.0);
    });

    test('verificar excecao com valor negativo', () {
      expect(() => converterPontosEmEstrelas(-2000), throwsException);
    });
  });

  group('testar compra feita pelo rico', () {
    test('verificar compra com valor positivo', () {
      expect(
          comprarProdutosEGanharPontos(
              100, (valorProduto) => valorProduto * 0.05),
          500);
    });
    test('verificar exceção com valor negativo', () {
      expect(
          () => comprarProdutosEGanharPontos(
              -100, (valorProduto) => valorProduto * 0.05),
          throwsException);
    });
  });
}
