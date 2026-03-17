import 'dart:io';

import 'package:flutter/material.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';
import 'package:opsentra_hr/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _profileCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();

  final String employeeId = 'EMP-1024'; // 🔒 Read-only

  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _profileCtrl.dispose();
    _dobCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      _dobCtrl.text = "${date.day}-${date.month}-${date.year}";
    }
  }

  // 🟢 Show Bottom Sheet for Camera / Gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pick from Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await _pickFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                Navigator.pop(context);
                await _pickFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 Gallery pick with permission
  Future<void> _pickFromGallery() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gallery permission denied")),
      );
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = image);
    }
  }

  // 🟢 Camera pick with permission
  Future<void> _pickFromCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Camera permission denied")));
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _profileImage = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.editprofile,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.editProfile);
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 🔵 Profile Image
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        backgroundImage: _profileImage != null
                            ? FileImage(File(_profileImage!.path))
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primary,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _field(AppLocalizations.of(context)!.name, _nameCtrl),
                  _field(
                    AppLocalizations.of(context)!.employeeId,
                    _profileCtrl,
                  ),
                  _field(AppLocalizations.of(context)!.address, _addressCtrl),
                  GestureDetector(
                    onTap: _pickDob,
                    child: AbsorbPointer(
                      child: _field(
                        AppLocalizations.of(context)!.dateofbirth,
                        _dobCtrl,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Save changes
                      },
                      child: Text(
                        AppLocalizations.of(context)!.savechanges,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController? controller, {
    bool enabled = true,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
