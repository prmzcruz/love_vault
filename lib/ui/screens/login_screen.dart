import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/floating_hearts_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PinkTheme.blushBackground,
      body: FloatingHeartsOverlay(
        heartCount: 16,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? 'Authentication failed. Try again!',
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isAuthenticating =
                      state.status == AuthStatus.authenticating;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Heart Logo Banner
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: PinkTheme.romanticGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: PinkTheme.primaryPink
                                    .withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              '👩‍❤️‍👨',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Couples Memory & Birthday',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PinkTheme.darkMagenta,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text(
                        'Surprize App 💕',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PinkTheme.primaryPink,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Log in with your Gmail OAuth account to save, sync, and share your romantic love story from initial meet to forever!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.pink.shade800,
                            fontSize: 13.5,
                            height: 1.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Google OAuth Sign-In Button
                      Container(
                        width: double.infinity,
                        height: 56,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            elevation: 6,
                            shadowColor:
                                PinkTheme.primaryPink.withValues(alpha: 0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                color: PinkTheme.primaryPink
                                    .withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                          ),
                          onPressed: isAuthenticating
                              ? null
                              : () {
                                  context
                                      .read<AuthBloc>()
                                      .add(const SignInWithGoogleEvent());
                                },
                          child: isAuthenticating
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: PinkTheme.primaryPink,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Official Google 'G' icon representation
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'G',
                                        style: TextStyle(
                                          color: Color(0xFF4285F4),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Sign in with Google / Gmail',
                                      style: TextStyle(
                                        color: PinkTheme.darkMagenta,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Direct Gmail Address Dialog Option
                      TextButton.icon(
                        onPressed: isAuthenticating
                            ? null
                            : () => _showGmailInputDialog(context),
                        icon: const Icon(
                          Icons.mail_outline,
                          color: PinkTheme.primaryPink,
                          size: 20,
                        ),
                        label: const Text(
                          'Sign in with custom Gmail address 💌',
                          style: TextStyle(
                            color: PinkTheme.primaryPink,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Row(
                        children: [
                          Expanded(child: Divider(indent: 30, endIndent: 10)),
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Expanded(child: Divider(indent: 10, endIndent: 30)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Guest Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: PinkTheme.primaryPink.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: isAuthenticating
                              ? null
                              : () {
                                  context
                                      .read<AuthBloc>()
                                      .add(const SignInAsGuestEvent());
                                },
                          icon: const Text('💕', style: TextStyle(fontSize: 18)),
                          label: const Text(
                            'Continue as Guest Sweetheart',
                            style: TextStyle(
                              color: PinkTheme.darkMagenta,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Privacy Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.lock_outline,
                              size: 14,
                              color: PinkTheme.primaryPink,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Private & Secure OAuth 2.0 Encryption',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showGmailInputDialog(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Row(
            children: [
              Text('💌', style: TextStyle(fontSize: 26)),
              SizedBox(width: 8),
              Text(
                'Gmail Authentication',
                style: TextStyle(
                  color: PinkTheme.darkMagenta,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Gmail Address',
                  hintText: 'yourname@gmail.com',
                  prefixIcon: Icon(Icons.email, color: PinkTheme.primaryPink),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name / Nickname',
                  hintText: 'Alex',
                  prefixIcon: Icon(Icons.person, color: PinkTheme.primaryPink),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                final name = nameController.text.trim();
                if (email.isEmpty || !email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid Gmail address!'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }
                context.read<AuthBloc>().add(
                      SendEmailOtpEvent(
                        email: email,
                        displayName: name.isEmpty ? 'Sweetheart' : name,
                      ),
                    );
                Navigator.pop(dialogContext);
              },
              child: const Text('Sign In ❤️'),
            ),
          ],
        );
      },
    );
  }
}
