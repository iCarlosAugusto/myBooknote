import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/pages/subject_page/subject_controller.dart';

class SubjectPage extends StatelessWidget {
  final String subjectID;
  const SubjectPage({super.key, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    SubjectController subjectController = SubjectController(subjectID: subjectID);
    List<ImageEntity> selectedImages = [];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Observer(builder: (_) {
          return AppBar(
              leading: subjectController.selectedImages.isNotEmpty
                  ? IconButton(
                      onPressed: subjectController.clearSelectedImages, icon: const Icon(Icons.close))
                  : null,
              title: Text(subjectController.selectedImages.isEmpty
                  ? 'Matéria'
                  : subjectController.selectedImages.length.toString()));
        }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Imagens'),
            Text(subjectID),
            Row(
              children: [
                GestureDetector(
                  onTap: () => subjectController.pickImageFromGalery(subjectID: subjectID),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 6),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.image_outlined, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () => subjectController.pickImageFromCamera(subjectID: subjectID),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: Observer(builder: (_) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Stack(
                          children: [
                            InkWell(
                              onLongPress: () {
                                subjectController.selectImage(subjectController.images[index]);
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () => print('Compartilhar!'),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [Icon(Icons.share), Text('Compartilhar')],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => print('Excluir!'),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [Icon(Icons.delete), Text('Excluir')],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              onTap: () {
                                subjectController.selectedImages.isNotEmpty
                                    ? subjectController.selectImage(subjectController.images[index])
                                    : showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => MediaQuery(
                                              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
                                              child: SafeArea(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      color: Colors.black,
                                                      child: Center(
                                                        child: Image.file(
                                                          File(subjectController.images[index].url),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () => context.pop(),
                                                        icon: const Icon(
                                                          Icons.close_rounded,
                                                          color: Colors.white,
                                                          size: 32,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ));
                              },
                              child: Observer(builder: (_) {
                                return Image.file(
                                  File(subjectController.images[index].url),
                                  fit: BoxFit.fill,
                                );
                              }),
                            ),
                            Observer(builder: (_) {
                              return Visibility(
                                visible: subjectController.selectedImages.isNotEmpty,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: subjectController.selectedImages
                                                .contains(subjectController.images[index])
                                            ? const Icon(Icons.check, color: Colors.white)
                                            : const Icon(Icons.circle_outlined, color: Colors.white))),
                              );
                            }),
                          ],
                        ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: subjectController.images.length);
              }),
            ),
            Container(margin: EdgeInsets.only(top: 18), child: Text('Anotações')),
            InkWell(
              onTap: () => context.push('/createAnotation/$subjectID'),
              child: Container(
                margin: const EdgeInsets.only(top: 8, right: 6),
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
