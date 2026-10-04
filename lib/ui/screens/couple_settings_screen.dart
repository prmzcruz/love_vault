import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/couple/couple_bloc.dart';
import '../../blocs/couple/couple_event.dart';
import '../../core/theme/pink_theme.dart';

class CoupleSettingsScreen extends StatefulWidget {
  const CoupleSettingsScreen({super.key});

  @override
  State<CoupleSettingsScreen> createState() => _CoupleSettingsScreenState();
}

class _CoupleSettingsScreenState extends State<CoupleSettingsScreen> {
  late TextEditingController _myNameController;
  late TextEditingController _partnerNameController;
  late TextEditingController _nicknameController;
  late TextEditingController _loveNoteController;

  late DateTime _initialMeetDate;
  late DateTime _partnerBirthday;

  @override
  void initState() {
    super.initState();
    final info = context.read<CoupleBloc>().state.coupleInfo;
    _myNameController = TextEditingController(text: info.myName);
    _partnerNameController = TextEditingController(text: info.partnerName);
    _nicknameController = TextEditingController(text: info.relationshipNickname);
    _loveNoteController = TextEditingController(text: info.customLoveNote);
    _initialMeetDate = info.initialMeetDate;
    _partnerBirthday = info.partnerBirthday;
  }

  @override
  void dispose() {
    _myNameController.dispose();
    _partnerNameController.dispose();
    _nicknameController.dispose();
    _loveNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Couple Profile & App Settings ⚙️💕',
            style: TextStyle(
              color: PinkTheme.darkMagenta,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Customize names, anniversary dates, birthdays, and sweet notes',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),

          // Couple Names Box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: PinkTheme.primaryPink.withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Couple Identity',
                  style: TextStyle(
                    color: PinkTheme.darkMagenta,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _myNameController,
                  decoration: const InputDecoration(
                    labelText: 'My Name',
                    prefixIcon: Icon(Icons.person, color: PinkTheme.primaryPink),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _partnerNameController,
                  decoration: const InputDecoration(
                    labelText: "Partner's Name",
                    prefixIcon: Icon(Icons.favorite, color: PinkTheme.primaryPink),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    labelText: 'Couple Nickname / Title',
                    prefixIcon: Icon(Icons.star, color: PinkTheme.primaryPink),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Important Dates Box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: PinkTheme.primaryPink.withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Important Dates',
                  style: TextStyle(
                    color: PinkTheme.darkMagenta,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_month, color: PinkTheme.primaryPink),
                  title: const Text(
                    'Initial Meet / Anniversary Date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Text(_formatDate(_initialMeetDate)),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _initialMeetDate,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _initialMeetDate = picked);
                      }
                    },
                    child: const Text('Change Date'),
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cake, color: PinkTheme.primaryPink),
                  title: const Text(
                    "Partner's Birthday",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Text(_formatDate(_partnerBirthday)),
                  trailing: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _partnerBirthday,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) {
                        setState(() => _partnerBirthday = picked);
                      }
                    },
                    child: const Text('Change Date'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Custom Love Note Box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: PinkTheme.primaryPink.withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Custom Love Note',
                  style: TextStyle(
                    color: PinkTheme.darkMagenta,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _loveNoteController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Personal Love Message',
                    prefixIcon: Icon(Icons.mark_email_read_outlined, color: PinkTheme.primaryPink),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final bloc = context.read<CoupleBloc>();
                bloc.add(UpdateCoupleNamesEvent(
                  myName: _myNameController.text.trim(),
                  partnerName: _partnerNameController.text.trim(),
                  nickname: _nicknameController.text.trim(),
                ));
                bloc.add(UpdateImportantDatesEvent(
                  initialMeetDate: _initialMeetDate,
                  partnerBirthday: _partnerBirthday,
                ));
                bloc.add(UpdateCustomNoteEvent(_loveNoteController.text.trim()));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Couple settings saved with love! ❤️'),
                    backgroundColor: PinkTheme.primaryPink,
                  ),
                );
              },
              icon: const Icon(Icons.favorite, size: 20),
              label: const Text('Save Settings ❤️'),
            ),
          ),

          const SizedBox(height: 24),

          // Account & Authentication Box
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: PinkTheme.primaryPink.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: PinkTheme.primaryPink.withValues(alpha: 0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account & Gmail Connection 💌',
                      style: TextStyle(
                        color: PinkTheme.darkMagenta,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: PinkTheme.softCardPink,
                        backgroundImage: authState.photoUrl != null
                            ? NetworkImage(authState.photoUrl!)
                            : null,
                        child: authState.photoUrl == null
                            ? const Text('👤', style: TextStyle(fontSize: 20))
                            : null,
                      ),
                      title: Text(
                        authState.displayName ?? 'Connected Account',
                        style: const TextStyle(
                          color: PinkTheme.darkMagenta,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        authState.userEmail ?? 'Not signed in',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(const SignOutEvent());
                        },
                        icon: const Icon(Icons.logout, size: 18),
                        label: const Text('Sign Out Account'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
