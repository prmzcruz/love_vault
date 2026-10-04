import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/floating_hearts_overlay.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String? sentCode;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.sentCode,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() => _resendSeconds = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _enteredCode {
    return _controllers.map((c) => c.text.trim()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PinkTheme.blushBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: PinkTheme.darkMagenta),
          onPressed: () {
            context.read<AuthBloc>().add(const CancelOtpEvent());
          },
        ),
        title: const Text('Email Verification 💌'),
      ),
      body: FloatingHeartsOverlay(
        heartCount: 12,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: PinkTheme.softCardPink,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text('✉️', style: TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verify Your Email Address',
                  style: TextStyle(
                    color: PinkTheme.darkMagenta,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We sent a 6-digit verification security code to:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: PinkTheme.softCardPink,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.email,
                    style: const TextStyle(
                      color: PinkTheme.primaryPink,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Simulated Email Inbox Notification Toast
                if (widget.sentCode != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.shade400),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text('📬', style: TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Simulated Email Notification:',
                                style: TextStyle(
                                  color: Color(0xFF5D4037),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Your Verification Code is: ${widget.sentCode}',
                                style: const TextStyle(
                                  color: PinkTheme.primaryPink,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy,
                              size: 20, color: PinkTheme.primaryPink),
                          onPressed: () {
                            if (widget.sentCode != null &&
                                widget.sentCode!.length == 6) {
                              for (int i = 0; i < 6; i++) {
                                _controllers[i].text = widget.sentCode![i];
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                // 6-digit OTP PIN Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 46,
                      height: 56,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: PinkTheme.darkMagenta,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: PinkTheme.primaryPink,
                              width: 2.5,
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              _focusNodes[index].unfocus();
                            }
                          } else if (index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      final code = _enteredCode;
                      if (code.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter the full 6-digit code!'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }
                      context
                          .read<AuthBloc>()
                          .add(VerifyOtpCodeEvent(code));
                    },
                    child: const Text(
                      'Verify & Enter App ❤️',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Resend Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code? ",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: _resendSeconds == 0
                          ? () {
                              context
                                  .read<AuthBloc>()
                                  .add(const ResendOtpCodeEvent());
                              _startResendTimer();
                            }
                          : null,
                      child: Text(
                        _resendSeconds == 0
                            ? 'Resend Code'
                            : 'Resend in ${_resendSeconds}s',
                        style: TextStyle(
                          color: _resendSeconds == 0
                              ? PinkTheme.primaryPink
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
