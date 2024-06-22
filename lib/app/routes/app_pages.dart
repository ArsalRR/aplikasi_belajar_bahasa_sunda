import 'package:get/get.dart';

import '../modules/add_soal/bindings/add_soal_binding.dart';
import '../modules/add_soal/views/add_soal_view.dart';
import '../modules/bhs_sunda/bindings/bhs_sunda_binding.dart';
import '../modules/bhs_sunda/views/bhs_sunda_view.dart';
import '../modules/daftar_materi_guru/bindings/daftar_materi_guru_binding.dart';
import '../modules/daftar_materi_guru/views/daftar_materi_guru_view.dart';
import '../modules/daftar_tugas_siswa/bindings/daftar_tugas_siswa_binding.dart';
import '../modules/daftar_tugas_siswa/views/daftar_tugas_siswa_view.dart';
import '../modules/datar_nilai/bindings/datar_nilai_binding.dart';
import '../modules/datar_nilai/views/datar_nilai_view.dart';
import '../modules/edit_tugas/bindings/edit_tugas_binding.dart';
import '../modules/edit_tugas/views/edit_tugas_view.dart';
import '../modules/edit_vidio_guru/bindings/edit_vidio_guru_binding.dart';
import '../modules/edit_vidio_guru/views/edit_vidio_guru_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_guru/bindings/home_guru_binding.dart';
import '../modules/home_guru/views/home_guru_view.dart';
import '../modules/list_materi_guru/bindings/list_materi_guru_binding.dart';
import '../modules/list_materi_guru/views/list_materi_guru_view.dart';
import '../modules/list_sunda/bindings/list_sunda_binding.dart';
import '../modules/list_sunda/views/list_sunda_view.dart';
import '../modules/list_tugas_siswa/bindings/list_tugas_siswa_binding.dart';
import '../modules/list_tugas_siswa/views/list_tugas_siswa_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
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
import '../modules/tugas_detail/bindings/tugas_detail_binding.dart';
import '../modules/tugas_detail/views/tugas_detail_view.dart';
import '../modules/tugas_list/bindings/tugas_list_binding.dart';
import '../modules/tugas_list/views/tugas_list_view.dart';
import '../modules/tugas_siswa/bindings/tugas_siswa_binding.dart';
import '../modules/tugas_siswa/views/tugas_siswa_view.dart';
import '../modules/update_materi_vidio_guru/bindings/update_materi_vidio_guru_binding.dart';
import '../modules/update_materi_vidio_guru/views/update_materi_vidio_guru_view.dart';
import '../modules/vidio_pembelajaran/bindings/vidio_pembelajaran_binding.dart';
import '../modules/vidio_pembelajaran/views/vidio_pembelajaran_view.dart';

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
      name: _Paths.DATAR_NILAI,
      page: () => DatarNilaiView(),
      binding: DatarNilaiBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SOAL,
      page: () => AddSoalView(),
      binding: AddSoalBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_LIST,
      page: () => TugasListView(),
      binding: TugasListBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_SISWA,
      page: () => TugasSiswaView(),
      binding: TugasSiswaBinding(),
    ),
    GetPage(
      name: _Paths.LIST_MATERI_GURU,
      page: () => ListMateriGuruView(),
      binding: ListMateriGuruBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_VIDIO_GURU,
      page: () => EditVidioGuruView(),
      binding: EditVidioGuruBinding(),
    ),
    GetPage(
      name: _Paths.VIDIO_PEMBELAJARAN,
      page: () => VidioPembelajaranView(),
      binding: VidioPembelajaranBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_MATERI_GURU,
      page: () => const DaftarMateriGuruView(),
      binding: DaftarMateriGuruBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_MATERI_VIDIO_GURU,
      page: () => const UpdateMateriVidioGuruView(),
      binding: UpdateMateriVidioGuruBinding(),
    ),
    GetPage(
      name: _Paths.LIST_TUGAS_SISWA,
      page: () => const ListTugasSiswaView(),
      binding: ListTugasSiswaBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_TUGAS_SISWA,
      page: () => const DaftarTugasSiswaView(),
      binding: DaftarTugasSiswaBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_TUGAS,
      page: () => const EditTugasView(),
      binding: EditTugasBinding(),
    ),
    GetPage(
      name: _Paths.TUGAS_DETAIL,
      page: () => TugasDetailView(),
      binding: TugasDetailBinding(),
    ),
  ];
}
