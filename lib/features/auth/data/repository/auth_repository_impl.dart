import 'package:chat/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:chat/features/auth/domain/entity/user_entity.dart';
import 'package:chat/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);
  @override
  UserEntity? getCurrentUser() {
    return remote.getCurrentUser();
  }

  @override
  Future<UserEntity> login(String email, String password) async{
    return await remote.login(email, password);
  }

  @override
  Future<void> logout() async{
    return await remote.logout() ;
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async{
   return await remote.register(name, email, password) ;
  }

}