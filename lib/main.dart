import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/couple/couple_bloc.dart';
import 'blocs/couple/couple_event.dart';
import 'blocs/couple/couple_state.dart';
import 'blocs/memories/memories_bloc.dart';
import 'blocs/memories/memories_event.dart';
import 'blocs/surprise/surprise_bloc.dart';
import 'blocs/surprise/surprise_event.dart';
import 'core/theme/pink_theme.dart';
import 'ui/screens/couple_onboarding_screen.dart';
import 'ui/screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LoveVaultApp());
}

class LoveVaultApp extends StatelessWidget {
  const LoveVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const CheckAuthStatusEvent()),
        ),
        BlocProvider<CoupleBloc>(
          create: (_) => CoupleBloc()..add(const LoadCoupleInfoEvent()),
        ),
        BlocProvider<MemoriesBloc>(
          create: (_) => MemoriesBloc()..add(const LoadMemoriesEvent()),
        ),
        BlocProvider<SurpriseBloc>(
          create: (_) => SurpriseBloc()..add(const LoadSurprisesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'LoveVault - Couple Memory Keeper',
        debugShowCheckedModeBanner: false,
        theme: PinkTheme.lightTheme,
        home: BlocBuilder<CoupleBloc, CoupleState>(
          builder: (context, coupleState) {
            if (coupleState.coupleInfo.isSetupComplete) {
              return const MainNavigationScreen();
            }
            return const CoupleOnboardingScreen();
          },
        ),
      ),
    );
  }
}
