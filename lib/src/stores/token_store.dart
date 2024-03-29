import 'dart:io';

import 'package:path/path.dart' as path;

import '../data/models/alfabeto_model.dart';
import '../domain/entities/token.dart';
import '../domain/usecases/i_usecase.dart';
import '../domain/usecases/tokens/get_tokens_from_palavras_reservadas_usecase.dart';
import '../errors/failures/i_failure.dart';

class TokenStore {
  final GetTokensFromPalavrasReservadasUsecase
      getTokensFromPalavrasReservadasUsecase;

  TokenStore({
    required this.getTokensFromPalavrasReservadasUsecase,
  }) {
    pipeline();
  }

  int column = 0;
  int row = 0;

  late AlfabetoModel alfabeto;

  bool isOver = false;

  List<IFailure> erros = [];

  Map<String, Token> tabelaSimbolos = {};

  bool hasError = false;
  String lexemaLido = '';

  void pipeline() async {
    final List<Token> tokensFromPalavrasReservadas =
        getTokensFromPalavrasReservadas();
    tabelaSimbolos.addEntries(
      tokensFromPalavrasReservadas.map(
        (e) => MapEntry(
          e.lexema,
          e,
        ),
      ),
    );
    alfabeto = AlfabetoModel.fromJson(
      File(
        path.joinAll(
          [
            '..\\',
            'T1-OtavioPontes-20221',
            'alfabeto.json',
          ],
        ),
      ).readAsStringSync(),
    );
  }

  List<Token> getTokensFromPalavrasReservadas() {
    return handleUseCaseSync(
      getTokensFromPalavrasReservadasUsecase,
      NoParams(),
    );
  }

  void addTokenToTable({required Token token}) {
    tabelaSimbolos.addAll(
      {
        token.lexema: token,
      },
    );
  }

  void addTokenToErrorList({required IFailure failure}) {
    erros.add(failure);
  }

  void updateToken({required Token token}) {
    tabelaSimbolos[token.lexema] = token;
  }

  Token? getTokenFromLexema({required Token token}) {
    return tabelaSimbolos[token.lexema];
  }
}
