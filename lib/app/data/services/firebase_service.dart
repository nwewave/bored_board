import 'dart:async';
import 'dart:developer';

import 'package:boasting_board/app/widgets/default_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../util/logger.dart';
import '../../util/toast.dart';

class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();
  final auth = FirebaseAuth.instance;

  int? _resendToken; // 인증문자 재전송시 토큰1`
  // int? _verificationStatus; // 인증 상태
  String? _verificationId; // 인증 id

  // final _cacheKey = 'centers_cache';

  void reset() {
    _resendToken = null;
    _verificationId = null;
  }

  /// 파이어베이스 회원가입
  Future<UserCredential?> signUpFirebase(
      {required String id, required String pw}) async {
    try {
      final credential =
          await auth.createUserWithEmailAndPassword(email: id, password: pw);
      dlog.d('회원가입 완료\n${credential.user?.uid}');
      // userUid = credential.user?.uid ?? '';
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          errorToast("이미 사용중인 이메일입니다");
          break;
        case "invalid-email":
          errorToast("잘못된 이메일 형식입니다");
          break;
        case "operation-not-allowed":
          errorToast("사용할 수 없는 방식입니다");
          break;
        case "weak-password":
          errorToast("비밀번호 보안 수준이 너무 낮습니다");
          break;
        default:
          errorToast("알 수 없는 오류가 발생했습니다");
          break;
      }
      return null;
    } catch (e) {
      dlog.e(e);
      return null;
    }
  }

  /// 파이어베이스 휴대폰 인증 시작
  // Future<void> authorizePhoneNumber({
  //   required String phoneNumber,
  //   required RxBool isSendAuth,
  //   Timer? authTimer,
  //   required Function() startAuthTimer,
  // }) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     forceResendingToken: _resendToken,
  //     timeout: const Duration(seconds: 120), // 2분 59초 뒤 인증번호 무효
  //     verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
  //       // TODO: 인증 코드 발송 성공
  //       dlog.d('인증 코드 발송 성공');
  //     },
  //     verificationFailed: (FirebaseAuthException error) {
  //       dlog.e(error.code);

  //       // TODO: 인증 코드 발송 실패
  //       dlog.d('인증 코드 발송 실패');
  //       isSendAuth.value = false;
  //       authTimer?.cancel();
  //       if (error.code == "too-many-requests") {
  //         Get.back();
  //         errorToast('인증번호 요청 횟수를 초과하였습니다.\n나중에 다시 시도해 주세요.');
  //       }

  //       //TODO: 휴대전화 인증 코드 전송 실패.
  //       else if (error.code == "missing-client-identifier") {
  //         Get.back();
  //         dlog.e(error);

  //         errorToast('휴대전화 인증 코드 전송에 실패하였습니다.');
  //       } else {
  //         errorToast('휴대폰 번호를 확인해 주세요.');
  //         Get.back();
  //       }
  //     },
  //     codeSent: (String verificationId, int? forceResendingToken) {
  //       // 인증 코드 발송 시작
  //       dlog.d('인증 코드 발송 시작');

  //       Get.back();
  //       isSendAuth.value = true;
  //       _verificationId = verificationId;
  //       _resendToken = forceResendingToken ?? 0;
  //       startAuthTimer();
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // 3분내 인증 실패 타임아웃

  //       try {
  //         if (Get.isRegistered<PhoneValidController>() ||
  //             Get.isRegistered<FindIdController>()) {
  //           isSendAuth.value = false;
  //           authTimer?.cancel();
  //         }
  //       } catch (e) {
  //         isSendAuth.value = false;
  //         dlog.d('인증번호 시간 종료\n$e');
  //       }
  //     },
  //   );
  // }

  /// 인증번호 유효성 확인
  // Future<bool> checkAuthorizeCode(
  //     {required String smsCode, required String phoneNumber}) async {
  //   if (_verificationId == null) return false;
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId!, smsCode: smsCode);

  //   dlog.d('폰 인증 시작\n${credential.smsCode}');
  //   try {
  //     UserCredential userCredential =
  //         await auth.signInWithCredential(credential);
  //     if (userCredential.user != null) {
  //       await auth.currentUser!.delete(); // 폰 번호로 로그인된 계정 삭제
  //       log('폰 번호로 로그인된 계정 삭제');
  //       await auth.signOut(); // 폰 번호로 로그인된 계정 세션 종료
  //       log('폰 번호로 로그인된 계정 세션 종료');
  //       // Get.off(() => SignUpView());
  //       return true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     dlog.e('폰 인증 실패\n${e.message}');
  //   }
  //   return false;
  // }

  // /// firebase auth 이메일 가입 여부 확인.
  // Future<bool> checkUserEmail(String email) async {
  //   final List<String> provideList =
  //       await auth.fetchSignInMethodsForEmail(email);

  //   if (provideList.isNotEmpty) {
  //     // 이미 가입됨.
  //     return false;
  //   }
  //   // 가입 안됨.
  //   return true;
  // }

  /// 파이어베이스 로그인
  Future<void> signInFirebase({
    required String id,
    required String pw,
    // bool isGoogleLogin = false,
    // bool isAppleLogin = false,
    // bool isKakaoLogin = false,
    // bool isNaverLogin = false,
  }) async {
    try {
      Get.focusScope?.unfocus();
      late UserCredential? credential;
      const DefaultLoader();
      // if (isGoogleLogin) {
      //   await SocialLoginController.to.signInWithGoogle();
      //   Get.back(); // 로딩 종료
      //   return;
      // } else if (isAppleLogin) {
      //   await SocialLoginController.to.signInWithApple();
      //   Get.back(); // 로딩 종료
      //   return;
      // } else if (isKakaoLogin) {
      //   await SocialLoginController.to.signInWithKakao();
      //   Get.back(); // 로딩 종료
      //   return;
      // } else if (isNaverLogin) {
      //   Get.back();
      //   await SocialLoginController.to.signInWithNaver();
      //   Get.back(); // 로딩 종료
      //   return;
      // } else {}

      if ((id.length < 5 || pw.length < 5) || !GetUtils.isEmail(id)) {
        errorToast('아이디 또는 비밀번호가 올바르지 않습니다.');
        GetUtils.printFunction('아이디 체크', GetUtils.isEmail(id), '정보??',
            isError: true);
        Get.back(); // 로딩 종료
        return;
      }
      credential =
          await auth.signInWithEmailAndPassword(email: id, password: pw);
/* todo
        final newUserInfo = await apiRepository.getUserData(userId: id);
        if (credential.user != null && newUserInfo != null) {
          await UserService.to.handleLoginSuccess(newUserInfo);
          // Get.back(); // 로딩 종료
          // UserService.to.goFirstLoginHome();
        } */
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dlog.e('해당 이메일을 찾을 수 없음');
      } else if (e.code == 'wrong-password') {
        dlog.e('패스워드 틀림');
      }
      errorToast('아이디 또는 비밀번호가 올바르지 않습니다.');
      Get.back(); // 로딩 종료
    } catch (e) {
      dlog.e(e);
      errorToast('아이디 또는 비밀번호가 올바르지 않습니다.');
      Get.back(); // 로딩 종료
    }
  }
}
