// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data%20source/auth_remote_ds.dart' as _i6;
import '../../features/auth/data/data%20source/auth_remote_ds_impl.dart'
    as _i624;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/current_user_usecase.dart' as _i67;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/logout_usecase.dart' as _i757;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/chat/data/data%20source/chat_remote_ds.dart' as _i653;
import '../../features/chat/data/data%20source/chat_remote_ds_impl.dart'
    as _i594;
import '../../features/chat/data/repository/chat_repository_impl.dart' as _i88;
import '../../features/chat/domain/repository/chat_repository.dart' as _i477;
import '../../features/chat/domain/usecase/get_all_users.dart' as _i583;
import '../../features/chat/domain/usecase/get_chat_id.dart' as _i366;
import '../../features/chat/domain/usecase/get_messages.dart' as _i466;
import '../../features/chat/domain/usecase/send_messages.dart' as _i328;
import '../../features/chat/presentation/cubit/chat_cubit.dart' as _i305;
import '../../features/chat/presentation/cubit/private_chat_cubit.dart' as _i79;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i653.ChatRemoteDs>(() => _i594.ChatRemoteDsImpl());
    gh.lazySingleton<_i6.AuthRemoteDataSource>(
      () => _i624.AuthRemoteDsImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i477.ChatRepository>(
      () => _i88.ChatRepositoryImpl(gh<_i653.ChatRemoteDs>()),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i6.AuthRemoteDataSource>()),
    );
    gh.factory<_i67.GetCurrentUserUseCase>(
      () => _i67.GetCurrentUserUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i911.LoginUseCase>(
      () => _i911.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i757.LogoutUseCase>(
      () => _i757.LogoutUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i583.GetAllUsers>(
      () => _i583.GetAllUsers(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i366.GetChatId>(
      () => _i366.GetChatId(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i466.GetMessages>(
      () => _i466.GetMessages(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i328.SendMessage>(
      () => _i328.SendMessage(gh<_i477.ChatRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        loginUseCase: gh<_i911.LoginUseCase>(),
        registerUseCase: gh<_i769.RegisterUseCase>(),
        logoutUseCase: gh<_i757.LogoutUseCase>(),
        getCurrentUserUseCase: gh<_i67.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i79.PrivateChatCubit>(
      () => _i79.PrivateChatCubit(
        getMessagesUseCase: gh<_i466.GetMessages>(),
        sendMessageUseCase: gh<_i328.SendMessage>(),
      ),
    );
    gh.factory<_i305.ChatCubit>(
      () => _i305.ChatCubit(getAllUsersUseCase: gh<_i583.GetAllUsers>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i946.RegisterModule {}
