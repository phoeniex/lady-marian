import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/pages/pin_login/pin_login_cubit.dart';

class PinKeyPad extends StatefulWidget {
  const PinKeyPad({super.key});

  @override
  State<StatefulWidget> createState() => _PinKeyPadState();
}

class _PinKeyPadState extends State<PinKeyPad> {
  PinLoginCubit get cubit => context.read<PinLoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PinCodeButton(title: '1', onPressed: ()=> cubit.enterPin('1')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '2', onPressed: ()=> cubit.enterPin('2')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '3', onPressed: ()=> cubit.enterPin('3')),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PinCodeButton(title: '4', onPressed: ()=> cubit.enterPin('4')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '5', onPressed: ()=> cubit.enterPin('5')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '6', onPressed: ()=> cubit.enterPin('6')),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PinCodeButton(title: '7', onPressed: ()=> cubit.enterPin('7')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '8', onPressed: ()=> cubit.enterPin('8')),
              const SizedBox(width: 32),
              _PinCodeButton(title: '9', onPressed: ()=> cubit.enterPin('9')),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _PinCodeButton(),
              const SizedBox(width: 32),
              _PinCodeButton(title: '0', onPressed: ()=> cubit.enterPin('0')),
              const SizedBox(width: 32),
              _PinCodeButton(isDelete: true, onPressed: ()=> cubit.removePin()),
            ],
          ),
        ],
      ),
    );
  }
}

class _PinCodeButton extends StatelessWidget {
  final String? title;
  final bool isDelete;
  final VoidCallback? onPressed;

  const _PinCodeButton({super.key, this.title, this.isDelete = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 64,
        height: 64,
        child: TextButton(
          onPressed: onPressed,
          child: Builder(builder: (context) {
            if (isDelete) {
              return SvgPicture.asset('assets/icons/ic_keyboard_backspace.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(AppColor.icon.loading, BlendMode.srcIn),
              );
            } else if (title != null) {
              return Text(title ?? '', style: AppTypography.titleLarge.copyWith(color: AppColor.text.main));
            } else {
              return const SizedBox(width: 64, height: 64);
            }
          }),
        )
    );
  }
}