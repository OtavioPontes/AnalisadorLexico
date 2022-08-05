import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;

import '../../../errors/failures/failures.dart';
import '../../../errors/failures/i_failure.dart';
import '../i_usecase.dart';

class GetCodigoFonteFromFileUsecase
    implements UseCaseSync<List<String>, NoParams> {
  @override
  Either<IFailure, List<String>> call(NoParams params) {
    try {
      List<String> codigoFonte = File(
        path.joinAll(
          [
            '..\\',
            'T1-OtavioPontes-20221',
            'fonte.alg',
          ],
        ),
      ).readAsLinesSync();
      codigoFonte = codigoFonte.map((e) => e += '\n').toList();
      codigoFonte.last += ' \$';
      return Right(codigoFonte);
    } catch (_) {
      return Left(
        InternalFailure(column: 0, row: 0),
      );
    }
  }
}
