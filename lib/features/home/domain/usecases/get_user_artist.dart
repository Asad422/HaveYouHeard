import 'package:dartz/dartz.dart';
import 'package:have_you_heard/core/errors/failures.dart';
import 'package:have_you_heard/core/usecase.dart';
import 'package:have_you_heard/features/home/domain/entities/artist.dart';
import 'package:have_you_heard/features/home/domain/repositories/user_repository.dart';

class GetUserArtist extends UseCaseNoParams<List<Artist>> {
    final UserRepository repository;
    GetUserArtist({required this.repository});
    @override
    Future<Either<Failure, List<Artist>>> call() async {
      return await repository.getUserArtists();
    }
  }