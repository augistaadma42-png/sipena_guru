import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../bloc/rekap_pengumpulan_bloc.dart';
import '../bloc/rekap_pengumpulan_event.dart';

/// Search field untuk mencari siswa berdasarkan nama
class SearchSiswaField extends StatefulWidget {
  const SearchSiswaField({super.key});

  @override
  State<SearchSiswaField> createState() => _SearchSiswaFieldState();
}

class _SearchSiswaFieldState extends State<SearchSiswaField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          context
              .read<RekapPengumpulanBloc>()
              .add(SearchStudentEvent(value));
        },
        style: AppTextStyles.cardTitle,
        decoration: InputDecoration(
          hintText: 'Cari siswa...',
          hintStyle: AppTextStyles.labelStyle,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.disabledGrey,
            size: 22,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: AppColors.disabledGrey, size: 18),
                  onPressed: () {
                    _controller.clear();
                    context
                        .read<RekapPengumpulanBloc>()
                        .add(const SearchStudentEvent(''));
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
                color: AppColors.primaryBlue, width: 1.5),
          ),
        ),
      ),
    );
  }
}
