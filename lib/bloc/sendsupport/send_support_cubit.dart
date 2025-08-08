import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'send_support_state.dart';

class SendSupportCubit extends Cubit<SendSupportState> {
  SendSupportCubit() : super(SendSupportSuccess());

  Future semEmail(String message) async {
    try {
      emit(SendSupportLoading());
      await sendEmail(message);
      emit(SendSupportSuccess());
    } catch (e) {
      emit(SendSupportFailure());
    }
  }

  Future sendEmail(String message) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': "service_c1giws2",
        'template_id': "template_wla4y9r",
        'user_id': "03Eq50fwVTJw_DFiJ",
        'template_params': {
          "user_email": FirebaseAuth.instance.currentUser!.email,
          "message": message,
        },
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      throw Exception("erorr");
    }
    //
  }
}
