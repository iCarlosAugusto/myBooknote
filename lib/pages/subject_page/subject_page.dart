import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'package:mybooknote/pages/subject_page/subject_controller.dart';

class SubjectPage extends StatelessWidget {
  final String subjectID;
  const SubjectPage({super.key, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    SubjectController subjectController = SubjectController(subjectID: subjectID);

    return Scaffold(
      appBar: AppBar(title: const Text('Materia')),
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
                    child: const Icon(Icons.add, color: Colors.white),
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
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            showModalBottomSheet(
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
                                                  File(subjectController.images[index]),
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
                          child: Image.file(
                            File(subjectController.images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: subjectController.images.length);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
