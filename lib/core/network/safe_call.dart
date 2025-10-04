import 'package:black_bull/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() request) async {
  try {
    final result = await request();
    return Right(result);
  } on DioException catch (e) {
    if (e.error is Failure) return Left(e.error as Failure);
    return Left(UnexpectedFailure("Unhandled Dio error: ${e.message}"));
  } catch (e) {
    return Left(UnexpectedFailure(e.toString()));
  }
}
