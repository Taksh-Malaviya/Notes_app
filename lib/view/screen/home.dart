import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Notes_Controller/Notes_Controller.dart';
import 'Detailpage.dart';

class HomePage extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final NotesController controller = Get.put(NotesController());
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App",style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 320,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            authController.pickedImage.value != null
                                ? FileImage(authController.pickedImage.value!)
                                : null,
                        child: authController.pickedImage.value == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                          "Name: ${authController.name.value}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )),
                    Obx(() => Text(
                          "Email: ${authController.email.value}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )),
                    Obx(() => Text(
                          "Phone: ${authController.phoneNumber.value}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => _showEditProfileDialog(context),
                      child: const Text("Edit Profile"),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: Obx(() => controller.notes.isEmpty
          ? const Center(child: Text("No notes available"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
              itemCount: controller.notes.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(
                    NoteDetailsPage(),
                    arguments: {
                      'title': controller.notes[index]['title'] ?? "",
                      'description':
                          controller.notes[index]['description'] ?? "",
                    },
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.notes[index]['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.notes[index]['description'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                titleController.text =
                                    controller.notes[index]['title'] ?? '';
                                descriptionController.text =
                                    controller.notes[index]['description'] ??
                                        '';
                                Get.defaultDialog(
                                  title: "Edit Note",
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          labelText: "Title",
                                        ),
                                      ),
                                      TextField(
                                        controller: descriptionController,
                                        decoration: const InputDecoration(
                                          labelText: "Description",
                                        ),
                                      ),
                                    ],
                                  ),
                                  onConfirm: () {
                                    controller.editNote(
                                      index,
                                      titleController.text,
                                      descriptionController.text,
                                    );
                                    titleController.clear();
                                    descriptionController.clear();
                                    Get.back();
                                  },
                                  onCancel: () {
                                    titleController.clear();
                                    descriptionController.clear();
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                controller.deleteNote(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descriptionController.clear();
          Get.defaultDialog(
            title: "Add Note",
            content: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                ),
              ],
            ),
            onConfirm: () {
              controller.addNote(
                titleController.text,
                descriptionController.text,
              );
              titleController.clear();
              descriptionController.clear();
              Get.back();
            },
            onCancel: () {
              titleController.clear();
              descriptionController.clear();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController =
        TextEditingController(text: authController.name.value);
    final emailController =
        TextEditingController(text: authController.email.value);
    final phoneController =
        TextEditingController(text: authController.phoneNumber.value);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            authController.pickedImage.value != null
                                ? FileImage(authController.pickedImage.value!)
                                : null,
                        child: authController.pickedImage.value == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () => _showImagePicker(context),
                          icon: const Icon(Icons.add_a_photo, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                authController.name.value = nameController.text;
                authController.email.value = emailController.text;
                authController.phoneNumber.value = phoneController.text;
                authController.saveUserData();
                Get.back();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take Photo'),
              onTap: () {
                authController.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                authController.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
