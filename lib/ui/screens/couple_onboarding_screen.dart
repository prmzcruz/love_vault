import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../blocs/couple/couple_bloc.dart';
import '../../blocs/couple/couple_event.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/floating_hearts_overlay.dart';

class CoupleOnboardingScreen extends StatefulWidget {
  const CoupleOnboardingScreen({super.key});

  @override
  State<CoupleOnboardingScreen> createState() => _CoupleOnboardingScreenState();
}

class _CoupleOnboardingScreenState extends State<CoupleOnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _myNameController = TextEditingController(text: 'Alex');
  final _partnerNameController = TextEditingController(text: 'Maya');
  final _nicknameController = TextEditingController(text: 'Eternal Soulmates 💕');

  String? _myPhotoPath;
  String? _partnerPhotoPath;
  DateTime _initialMeetDate = DateTime(2023, 2, 14);
  final DateTime _partnerBirthday = DateTime(2026, 10, 20);

  final ImagePicker _picker = ImagePicker();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _myNameController.dispose();
    _partnerNameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto({required bool isMyPhoto, required ImageSource source}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          if (isMyPhoto) {
            _myPhotoPath = pickedFile.path;
          } else {
            _partnerPhotoPath = pickedFile.path;
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking photo: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PinkTheme.blushBackground,
      body: FloatingHeartsOverlay(
        heartCount: 16,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  // Title Banner
                  const Text(
                    'Welcome to LoveVault 🔐💕',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PinkTheme.darkMagenta,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Store, cherish, and protect your precious relationship memories from initial meet to forever!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.pink.shade800,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Partner 1 Card
                  _buildPartnerCard(
                    title: 'Partner 1 (My Details)',
                    nameController: _myNameController,
                    photoPath: _myPhotoPath,
                    isMyPhoto: true,
                    defaultAvatarEmoji: '👨',
                  ),

                  const SizedBox(height: 16),

                  // Heart Connector
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: PinkTheme.primaryPink,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Text('❤️', style: TextStyle(fontSize: 26)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Partner 2 Card
                  _buildPartnerCard(
                    title: "Partner 2 (My Soulmate's Details)",
                    nameController: _partnerNameController,
                    photoPath: _partnerPhotoPath,
                    isMyPhoto: false,
                    defaultAvatarEmoji: '👩',
                  ),

                  const SizedBox(height: 24),

                  // Relationship Details Box
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
                          'Relationship Milestones',
                          style: TextStyle(
                            color: PinkTheme.darkMagenta,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nicknameController,
                          decoration: const InputDecoration(
                            labelText: 'Couple Nickname / Title',
                            hintText: 'Soulmates 💕',
                            prefixIcon: Icon(Icons.star, color: PinkTheme.primaryPink),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.calendar_month, color: PinkTheme.primaryPink),
                          title: const Text('Initial Meet / Anniversary Date',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
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
                            child: const Text('Change'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<CoupleBloc>().add(
                                CompleteOnboardingEvent(
                                  myName: _myNameController.text.trim(),
                                  partnerName: _partnerNameController.text.trim(),
                                  myPhotoUrl: _myPhotoPath,
                                  partnerPhotoUrl: _partnerPhotoPath,
                                  nickname: _nicknameController.text.trim(),
                                  initialMeetDate: _initialMeetDate,
                                  partnerBirthday: _partnerBirthday,
                                ),
                              );
                        }
                      },
                      child: const Text(
                        'Start Our Love Journey ❤️',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerCard({
    required String title,
    required TextEditingController nameController,
    required String? photoPath,
    required bool isMyPhoto,
    required String defaultAvatarEmoji,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PinkTheme.primaryPink.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: PinkTheme.primaryPink.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: PinkTheme.darkMagenta,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Photo Avatar Preview
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: PinkTheme.softCardPink,
                  shape: BoxShape.circle,
                  border: Border.all(color: PinkTheme.primaryPink, width: 2),
                  image: photoPath != null
                      ? DecorationImage(
                          image: FileImage(File(photoPath)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: photoPath == null
                    ? Center(
                        child: Text(
                          defaultAvatarEmoji,
                          style: const TextStyle(fontSize: 36),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              // Camera / Gallery Buttons
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload Photo:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              side: const BorderSide(color: PinkTheme.primaryPink),
                            ),
                            onPressed: () => _pickPhoto(
                              isMyPhoto: isMyPhoto,
                              source: ImageSource.camera,
                            ),
                            icon: const Icon(Icons.camera_alt, size: 16, color: PinkTheme.primaryPink),
                            label: const Text('Camera', style: TextStyle(fontSize: 11)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              side: const BorderSide(color: PinkTheme.primaryPink),
                            ),
                            onPressed: () => _pickPhoto(
                              isMyPhoto: isMyPhoto,
                              source: ImageSource.gallery,
                            ),
                            icon: const Icon(Icons.photo_library, size: 16, color: PinkTheme.primaryPink),
                            label: const Text('Gallery', style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a name!';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Partner Name',
              prefixIcon: Icon(Icons.person, color: PinkTheme.primaryPink),
            ),
          ),
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
