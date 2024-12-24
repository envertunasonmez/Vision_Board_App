import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:vision_board_app/cubit/vision_board_cubit.dart';

class VisionBoardView extends StatelessWidget {
  const VisionBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisionBoardCubit(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  "Create Vision Board",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<VisionBoardCubit, List<File?>>(
            builder: (context, images) {
              return GridView.builder(
                shrinkWrap: true, // Make grid view take only the needed space
                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                  crossAxisSpacing: 0, // No horizontal spacing
                  mainAxisSpacing: 0, // No vertical spacing
                  childAspectRatio:
                      0.8, // Make the grid items taller (height > width)
                ),
                itemCount: 24, // 4 columns, 6 rows
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _pickImage(context, index), // Photo pick
                    child: Container(
                      decoration: BoxDecoration(
                        // Remove border so images are flush with each other
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Stack(
                          children: [
                            // If there's an image, display it
                            if (images[index] != null)
                              Image.file(
                                images[index]!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            else
                              // Otherwise, show an icon to add a photo
                              Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Fotoğraf seçme işlemi
  Future<void> _pickImage(BuildContext context, int index) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      // Cubit üzerinden fotoğraf ekle
      context.read<VisionBoardCubit>().addImage(index, image);
    }
  }
}
