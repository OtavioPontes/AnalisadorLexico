import 'package:analisador_lexico/analisador_lexico.dart';

void main() async {
  final TokenStore tokenStore = TokenStore(
    getTokensFromPalavrasReservadasUsecase:
        GetTokensFromPalavrasReservadasUsecase(),
  );
  final DFAStore dfaStore = DFAStore(tokenStore: tokenStore);

  final ScannerStore scannerStore = ScannerStore(
    dfaStore: dfaStore,
    tokenStore: tokenStore,
    getCodigoFonteFromFileUsecase: GetCodigoFonteFromFileUsecase(),
  );

  while (!tokenStore.isOver) {
    print(
      scannerStore.scanner(
        codigoFonte: scannerStore.codigoFonte,
        rowPar: tokenStore.row,
        columnPar: tokenStore.column,
      ),
    );
  }

  print('\nTabela De Simbolos:');
  tokenStore.tabelaSimbolos.forEach(
    (key, value) => print(value),
  );

  print('\nErros:');
  tokenStore.erros.forEach(
    (element) => {
      if (element is InvalidCharFailure)
        {
          print(
              '[Erro Léxico] - (${element.char}) Caractére Inválido na linha ${element.row! + 1} e coluna ${element.column! + 1}')
        }
      else if (element is InvalidWordFailure)
        {
          print(
              '[Erro Léxico] - (${element.char}) Palavra Rejeitada na linha ${element.row! + 1} e coluna ${element.column! + 1}')
        }
    },
  );
}
