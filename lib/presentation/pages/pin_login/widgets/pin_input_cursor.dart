import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marian/presentation/_shared/app_theme.dart';
import 'package:marian/presentation/pages/pin_login/pin_login_cubit.dart';

class PinInputCursor extends StatelessWidget {
  const PinInputCursor({super.key});

  @override
  Widget build(BuildContext context) {
    final pinCode = context.select((PinLoginCubit cubit) => cubit.state.pinCode);
    final isError = context.select((PinLoginCubit cubit) => cubit.state.behavior) == PinLoginBehavior.failure;

    return BlocConsumer<PinLoginCubit, PinLoginState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Enter PIN Code',
              style: AppTypography.titleSmall.copyWith(color: AppColor.text.main)),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PinInputBox(char: pinCode.isNotEmpty ? pinCode[0] : null),
              const SizedBox(width: 8.0),
              _PinInputBox(char: pinCode.length > 1 ? pinCode[1] : null),
              const SizedBox(width: 8.0),
              _PinInputBox(char: pinCode.length > 2 ? pinCode[2] : null),
              const SizedBox(width: 8.0),
              _PinInputBox(char: pinCode.length > 3 ? pinCode[3] : null),
              const SizedBox(width: 8.0),
              _PinInputBox(char: pinCode.length > 4 ? pinCode[4] : null),
              const SizedBox(width: 8.0),
              _PinInputBox(char: pinCode.length > 5 ? pinCode[5] : null),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(isError ? 'Error' : '',
              style: AppTypography.captionMedium.copyWith(color: AppColor.text.error)),
        ],
      );
    },
        listenWhen: (context, state) => state.behavior == PinLoginBehavior.success,
        listener: (context, state) {
          Navigator.pop(context);
        });
  }
}

class _PinInputBox extends StatelessWidget {
  final String? char;

  const _PinInputBox({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColor.surface.toggle,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _PinInputDot(char: char),
    );
  }
}

class _PinInputDot extends StatelessWidget {
  final String? char;

  const _PinInputDot({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    if (char == null) {
      return const SizedBox(width: 10, height: 10);
    } else {
      return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.icon.toggle,
            boxShadow: [AppShadow.normalPrimary],
          ),
        ),
      );
    }
  }
}