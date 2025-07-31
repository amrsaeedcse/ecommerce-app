import 'package:get_it/get_it.dart';

import '../firebase/firestore/FireBaseFireStore.dart';
import '../firebase/fireauth/firebaseauth.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerLazySingleton(() => FireBaseAuth());
  getIt.registerLazySingleton(() => FireBaseFireStore());
}
