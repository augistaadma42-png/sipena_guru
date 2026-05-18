import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PengaturanNotifikasiPage extends StatefulWidget {
  const PengaturanNotifikasiPage({Key? key}) : super(key: key);

  @override
  State<PengaturanNotifikasiPage> createState() =>
      _PengaturanNotifikasiPageState();
}

class _PengaturanNotifikasiPageState
    extends State<PengaturanNotifikasiPage> {

  bool _notifInternal = true;
  bool _notifEmail = false;

  bool _notifAbsensi = true;
  bool _notifTugasKumpul = true;
  bool _notifTugasBelumDinilai = true;
  bool _notifPengajuan = true;

  void _showToast(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildToggleItem({
    required String judul,
    required String deskripsi,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? icon,
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.primaryBlue)
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: iconColor ?? AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 14),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: AppTextStyles.cardTitle
                    .copyWith(fontSize: 14),
              ),

              const SizedBox(height: 2),

              Text(
                deskripsi,
                style: AppTextStyles.cardSubtitle
                    .copyWith(fontSize: 12),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor:
              AppColors.successGreen,
          inactiveThumbColor:
              Colors.white,
          inactiveTrackColor:
              AppColors.borderLight,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.backgroundLight,

      appBar: const CustomAppBar(
        title: 'Notifikasi',
        showBackButton: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// CARD INTERNAL
            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                        16),
                border: Border.all(
                    color: AppColors
                        .borderLight),
              ),

              child: Column(
                children: [

                  _buildToggleItem(
                    judul:
                        'Notifikasi Internal',
                    deskripsi:
                        'Notifikasi di dalam aplikasi',
                    value:
                        _notifInternal,
                    icon: Icons
                        .notifications_outlined,
                    iconColor:
                        AppColors
                            .primaryBlue,
                    onChanged: (val) {
                      setState(() {
                        _notifInternal =
                            val;
                      });

                      _showToast(
                        val
                            ? 'Notifikasi internal aktif'
                            : 'Notifikasi internal mati',
                      );
                    },
                  ),

                  if (_notifInternal) ...[

                    const SizedBox(
                        height: 18),

                    const Divider(),

                    const SizedBox(
                        height: 18),

                    _buildToggleItem(
                      judul:
                          'Absensi Belum Diisi',
                      deskripsi:
                          'Ingatkan jika ada kelas belum diabsen',
                      value:
                          _notifAbsensi,
                      icon: Icons
                          .fact_check_outlined,
                      iconColor:
                          AppColors
                              .primaryBlue,
                      onChanged: (val) {
                        setState(() {
                          _notifAbsensi =
                              val;
                        });
                      },
                    ),

                    const SizedBox(
                        height: 18),

                    _buildToggleItem(
                      judul:
                          'Siswa Kumpul Tugas',
                      deskripsi:
                          'Notif siswa mengumpulkan tugas',
                      value:
                          _notifTugasKumpul,
                      icon: Icons
                          .inbox_outlined,
                      iconColor:
                          AppColors
                              .successGreen,
                      onChanged: (val) {
                        setState(() {
                          _notifTugasKumpul =
                              val;
                        });
                      },
                    ),

                    const SizedBox(
                        height: 18),

                    _buildToggleItem(
                      judul:
                          'Tugas Belum Dinilai',
                      deskripsi:
                          'Ingatkan tugas belum dinilai',
                      value:
                          _notifTugasBelumDinilai,
                      icon: Icons
                          .access_time_outlined,
                      iconColor:
                          AppColors
                              .secondaryOrange,
                      onChanged: (val) {
                        setState(() {
                          _notifTugasBelumDinilai =
                              val;
                        });
                      },
                    ),

                    const SizedBox(
                        height: 18),

                    _buildToggleItem(
                      judul:
                          'Pengajuan Tidak Masuk',
                      deskripsi:
                          'Notif izin / sakit / dispen',
                      value:
                          _notifPengajuan,
                      icon: Icons
                          .person_off_outlined,
                      iconColor:
                          Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          _notifPengajuan =
                              val;
                        });
                      },
                    ),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// CARD EMAIL
            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                        16),
                border: Border.all(
                    color: AppColors
                        .borderLight),
              ),

              child: Column(
                children: [

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Container(
                        padding:
                            const EdgeInsets
                                .all(
                                    10),

                        decoration:
                            BoxDecoration(
                          color: const Color(
                              0xFFFFF3E0),
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      10),
                        ),

                        child:
                            const Icon(
                          Icons
                              .email_outlined,
                          color: AppColors
                              .secondaryOrange,
                        ),
                      ),

                      const SizedBox(
                          width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Wrap(
                              spacing: 8,
                              runSpacing: 4,

                              children: [

                                Text(
                                  'Notifikasi Email',
                                  style:
                                      AppTextStyles
                                          .sectionTitle,
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        8,
                                    vertical:
                                        2,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        AppColors.backgroundLight,
                                    borderRadius:
                                        BorderRadius.circular(
                                            10),
                                  ),

                                  child:
                                      const Text(
                                    'Opsional',
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 4),

                            Text(
                              'Kirim ringkasan harian ke email',
                              maxLines: 2,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                            )
                          ],
                        ),
                      ),

                      Switch(
                        value:
                            _notifEmail,
                        onChanged:
                            (val) {
                          setState(() {
                            _notifEmail =
                                val;
                          });

                          _showToast(
                            val
                                ? 'Notifikasi email aktif'
                                : 'Notifikasi email mati',
                          );
                        },
                      )
                    ],
                  ),

                  if (_notifEmail) ...[
                    const SizedBox(
                        height: 14),

                    const Divider(),

                    const SizedBox(
                        height: 14),

                    Container(
                      padding:
                          const EdgeInsets
                              .all(14),

                      decoration:
                          BoxDecoration(
                        color: AppColors
                            .backgroundLight,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    10),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons
                                .alternate_email,
                            size: 16,
                          ),

                          const SizedBox(
                              width:
                                  10),

                          Expanded(
                            child:
                                Text(
                              'umikulsumspd@sekolah.sch.id',
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    Text(
                      'Ringkasan aktivitas dikirim setiap hari pukul 18.00',
                      style:
                          AppTextStyles
                              .cardSubtitle
                              .copyWith(
                        fontSize:
                            11,
                      ),
                    )
                  ]
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}