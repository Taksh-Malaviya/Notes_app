import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NotesController extends GetxController {
  final notes = <Map<String, String>>[].obs; // Reactive list of maps for notes
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load stored notes and handle potential type mismatch
    List<dynamic>? storedNotes = storage.read<List<dynamic>>('notes');
    if (storedNotes != null) {
      notes.assignAll(
        storedNotes.whereType<Map<dynamic, dynamic>>().map(
              (note) => note.map(
                (key, value) => MapEntry(key.toString(), value.toString()),
              ),
            ),
      );
    }
  }

  void addNote(String title, String description) {
    if (title.isNotEmpty && description.isNotEmpty) {
      notes.add({'title': title, 'description': description});
      saveNotes();
    }
  }

  void editNote(int index, String updatedTitle, String updatedDescription) {
    if (updatedTitle.isNotEmpty && updatedDescription.isNotEmpty) {
      notes[index] = {'title': updatedTitle, 'description': updatedDescription};
      saveNotes();
    }
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    saveNotes();
  }

  void saveNotes() {
    // Save notes to GetStorage
    storage.write('notes', notes.toList());
  }

  void clearStorage() {
    final storage = GetStorage();
    storage.erase(); // Clears all stored data
  }
}

class AuthController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final pickedImage = Rx<File?>(null);
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load stored user data
    name.value = storage.read('name') ?? '';
    email.value = storage.read('email') ?? '';
    phoneNumber.value = storage.read('phone') ?? '';
    final imagePath = storage.read('profileImage');
    if (imagePath != null) {
      pickedImage.value = File(imagePath);
    }
  }

  void saveUserData() {
    storage.write('name', name.value);
    storage.write('email', email.value);
    storage.write('phone', phoneNumber.value);
    if (pickedImage.value != null) {
      storage.write('profileImage', pickedImage.value!.path);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
      saveUserData(); // Save image path permanently
    }
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await saveImagePermanently(File(pickedFile.path));
    }
  }

  // Capture image using camera
  Future<void> captureImageWithCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await saveImagePermanently(File(pickedFile.path));
    }
  }

  // Save image permanently
  Future<void> saveImagePermanently(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final String imagePath = join(directory.path, basename(image.path));
    final savedImage = await image.copy(imagePath);
    selectedImage.value = savedImage; // Update the selected image
  }
}
