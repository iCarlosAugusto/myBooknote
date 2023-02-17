import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/pages/createAnotation/create_anotation_controller.dart';

class CreateAnotation extends StatelessWidget {
  const CreateAnotation({super.key});

  @override
  Widget build(BuildContext context) {
    CreateAnotationController controller = CreateAnotationController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome da anotação',
              ),
            ),
            TextFormField(
              maxLength: 500,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Descrição',
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => print('Click'),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 6),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.image_outlined, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () => print('Click'),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 6),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.camera, color: Colors.white),
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
                                //subjectController.selectImage(subjectController.images[index]);
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
                                //subjectController.selectedImages.isNotEmpty
                                //    ? subjectController.selectImage(subjectController.images[index])
                                //    :
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
                                                      File(controller.images[index].url),
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
                                  File(controller.images[index].url),
                                  fit: BoxFit.fill,
                                );
                              }),
                            ),
                          ],
                        ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: controller.images.length);
              }),
            ),
            ElevatedButton(onPressed: controller.createAnotation, child: const Text('Criar'))
          ],
        ),
      ),
    );
  }
}
