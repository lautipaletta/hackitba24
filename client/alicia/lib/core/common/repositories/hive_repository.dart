import 'package:alicia/core/common/models/app_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final hiveRepositoryProvider = Provider((ref) => HiveRepository());

class HiveRepository {
  Future<Either<AppException, dynamic>> read({required AliciaHiveBox boxName, required AliciaHiveBox key}) async {
    try {
      final box = await Hive.openBox(boxName.value);
      return Right(box.get(key.value));
    } on Exception catch (e) {
      return Left(AppException(message: e.toString()));
    }
  }

  Future <void> write({required AliciaHiveBox boxName, required AliciaHiveBox key, required value}) {  
    return Hive.openBox(boxName.value).then((box) => box.put(key.value, value));
    
  }
}

enum AliciaHiveBox {
  ALICIA_BOX('aliciaBox'),
  USER_NAME('userName'),
  USER_ID('userId'),
  HAS_LOGGED_IN('hasLoggedIn');

  const AliciaHiveBox(this.value);
  final String value;
}
