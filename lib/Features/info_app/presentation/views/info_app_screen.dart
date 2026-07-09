import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../Core/theme/cubit_theme/theme_cubit.dart';
import '../../../../Core/constants/color_constants.dart';
import 'package:hive/hive.dart';

import '../../data/models/app_info_hive_model.dart';
import '../../domain/entities/app_info.dart';
import '../veiw_model/cubit/info_cubit.dart';
import 'widgets/app_action_buttons_section.dart';
import 'widgets/app_info_card_section.dart';
import 'widgets/app_social_links_row.dart';
import 'widgets/bottom_wave_path_clipper.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InfoCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final box = Hive.box<AppInfoHive>('app_info_box'); 

    return Scaffold(
      body: BlocBuilder<InfoCubit, InfoState>(
        builder: (context, state) {
          AppInfo? info;
          if (state is InfoLoaded) {
            info = state.info;
          } else {
            final cached = box.get('info');
            if (cached != null) info = AppInfo(info: cached.info);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipPath(
                      clipper: BottomWavePathClipper(),
                      child: Container(
                        height: 200,
                        color: kPrimaryColor,
                      ),
                    ),
                    Positioned(
                      top: 64,
                      right: 16,
                      child: PhysicalModel(
                        elevation: 8,
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                        shadowColor: Colors.white54,
                        child: IconButton(
                          icon: FaIcon(
                            isDark
                                ? FontAwesomeIcons.solidSun
                                : FontAwesomeIcons.moon,
                            color: Colors.white,
                          ),
                          tooltip: isDark
                              ? 'التبديل إلى الوضع الفاتح'
                              : 'التبديل إلى الوضع الداكن',
                          onPressed: () {
                            context.read<ThemeCubit>().toggle();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
   
                AppInfoCardSection(info: info),

                const SizedBox(height: 24),

                AppActionButtonsSection(info: info),
                const SizedBox(height: 24),

                AppSocialLinksRow(),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
