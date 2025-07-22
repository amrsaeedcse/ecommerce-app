import 'package:get_it/get_it.dart';

import '../firebase/FireBaseFireStore.dart';
import '../firebase/firebaseauth.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerLazySingleton(() => FireBaseAuth());
  getIt.registerLazySingleton(() => FireBaseFireStore());
}
