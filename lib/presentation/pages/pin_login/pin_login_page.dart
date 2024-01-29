import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marian/domain/auth/repositories/auth_repository.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/pages/pin_login/pin_login_cubit.dart';
import 'package:marian/presentation/pages/pin_login/widgets/pin_input_cursor.dart';
import 'package:marian/presentation/pages/pin_login/widgets/pin_keypad.dart';

class PinLoginPage extends StatelessWidget {
  const PinLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface.page,
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (_) => PinLoginCubit(authRepository: context.read<AuthRepository>()),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  PinLoginCubit get pageCubit => context.read<PinLoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surface.page,
      child: const Stack(
        children: [
          Image(image: AssetImage('assets/images/im_bg_decorate_onboarding.png')),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 64.0),
                _Header(),
                SizedBox(height: 40.0),
                PinInputCursor(),
                SizedBox(height: 32.0),
                PinKeyPad(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onPressed() {
    Navigator.of(context).pop();
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [AppShadow.normalPrimary]),
            child: const Image(image: AssetImage('assets/images/im_headline_app_icon.png'))),
        const SizedBox(height: 16.0),
        Text('Simple To-Do App',
            style: AppTypography.titleLarge.copyWith(color: AppColor.text.main)
        ),
        const SizedBox(height: 4.0),
        Text('simple and clean.',
            style: AppTypography.titleSmall.copyWith(color: AppColor.text.description)
        ),
      ],
    );
  }
}