import 'package:get/get.dart';

import '../modules/add_soal/bindings/add_soal_binding.dart';
import '../modules/add_soal/views/add_soal_view.dart';
import '../modules/bhs_sunda/bindings/bhs_sunda_binding.dart';
import '../modules/bhs_sunda/views/bhs_sunda_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_guru/bindings/home_guru_binding.dart';
import '../modules/home_guru/views/home_guru_view.dart';
import '../modules/list_sunda/bindings/list_sunda_binding.dart';
import '../modules/list_sunda/views/list_sunda_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/materi_guru/bindings/materi_guru_binding.dart';
import '../modules/materi_guru/views/materi_guru_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tambah_video_guru/bindings/tambah_video_guru_binding.dart';
import '../modules/tambah_video_guru/views/tambah_video_guru_view.dart';
import '../modules/tentang_sekolah/bindings/tentang_sekolah_binding.dart';
import '../modules/tentang_sekolah/views/tentang_sekolah_view.dart';
import '../modules/tugas_list/bindings/tugas_list_binding.dart';
import '../modules/tugas_list/views/tugas_list_view.dart';
import '../modules/tugas_siswa/bindings/tugas_siswa_binding.dart';
import '../modules/tugas_siswa/views/tugas_siswa_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BHS_SUNDA,
      page: () => const BhsSundaView(),
      binding: BhsSundaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.LIST_SUNDA,
      page: () => ListSundaView(),
      binding: ListSundaBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.HOME_GURU,
      page: () => HomeGuruView(),
      binding: HomeGuruBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG_SEKOLAH,
      page: () => const TentangSekolahView(),
      binding: TentangSekolahBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_VIDEO_GURU,
      page: () => const TambahVideoGuruView(),
      binding: TambahVideoGuruBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SOAL,
      page: () => const AddSoalView(),
      binding: AddSoalBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_LIST,
      page: () => const TugasListView(),
      binding: TugasListBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_SISWA,
      page: () => const TugasSiswaView(),
      binding: TugasSiswaBinding(),
    ),
  ];
}
