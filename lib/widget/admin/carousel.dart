import 'dart:html'; // Import for web file handling
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart'; // Web image picker
import 'dart:typed_data';

class CarouselMain extends StatefulWidget {
  const CarouselMain({super.key});

  @override
  State<CarouselMain> createState() => _CarouselMainState();
}

class _CarouselMainState extends State<CarouselMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Carousel(), title: "Carousel");
  }
}

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> imageUrls = [];
  bool isDeleting = false; // Track if the deletion is in progress

  @override
  void initState() {
    super.initState();
    _loadImages(); // Load images initially when the widget is created
  }

  // Upload image to Firebase Storage and save the URL to Firestore
  Future<void> _uploadImage() async {
    final image = await ImagePickerWeb.getImageAsFile();
    if (image == null) return; // If no image is selected, exit the function.

    try {
      // Generate a unique filename using the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Use a reference to Firebase Storage to upload the file
      final storageRef = _storage.ref().child('uploads/carousel/$fileName');
      final uploadTask = storageRef.putBlob(image); // `putBlob` is used for web File

      // Listen to the upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        switch (snapshot.state) {
          case TaskState.running:
            print("Upload is in progress...");
            break;
          case TaskState.success:
            print("Upload completed successfully");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          default:
            break;
        }
      });

      // Wait for the upload to finish
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL after the upload is finished
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the URL to Firestore
      await _firestore.collection('images').add({
        'url': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update the UI by adding the new image URL
      setState(() {
        imageUrls.add(downloadUrl);
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Load images from Firestore and update the UI
  Future<void> _loadImages() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('images')
          .orderBy('timestamp', descending: true)
          .get();

      setState(() {
        imageUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
      });
    } catch (e) {
      print("Error loading images: $e");
    }
  }

  // Delete image from Firebase Storage and Firestore
  Future<void> _deleteImage(String imageUrl) async {
    setState(() {
      isDeleting = true; // Show loading indicator
    });

    try {
      // Show confirmation dialog before deleting
      bool? confirmDelete = await _showDeleteDialog();

      if (confirmDelete != true) {
        setState(() {
          isDeleting = false; // Hide loading if the user cancels
        });
        return;
      }

      // Find the image document in Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('images')
          .where('url', isEqualTo: imageUrl)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Delete the Firestore document
        await snapshot.docs.first.reference.delete();

        // Delete the image from Firebase Storage
        Reference storageRef = _storage.refFromURL(imageUrl);
        await storageRef.delete();

        // Update the UI by removing the image from the list
        setState(() {
          imageUrls.remove(imageUrl);
          isDeleting = false; // Hide loading after deletion
        });
      }
    } catch (e) {
      print("Error deleting image: $e");
      setState(() {
        isDeleting = false; // Hide loading if an error occurs
      });
    }
  }

  // Show a confirmation dialog before deleting the image
  Future<bool?> _showDeleteDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to delete this image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(78, 115, 222, 1))),
          onPressed: _uploadImage,
          child: const Text('Upload Image',style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: imageUrls.isEmpty
              ? const Center(child: Text("No images found"))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 images per row (you can adjust)
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0, // Makes the grid cells square
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    String imageUrl = imageUrls[index];
                    return Stack(
                      clipBehavior: Clip.none, // Allow the delete button to overlay
                      children: [
                        // Image widget with a border radius for rounded corners
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: isDeleting
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    _deleteImage(imageUrl);
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
