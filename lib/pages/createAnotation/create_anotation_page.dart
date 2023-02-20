import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/pages/createAnotation/create_anotation_controller.dart';
import 'package:mybooknote/widgets/textfieldWidget.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateAnotation extends StatelessWidget {
  CreateAnotation({super.key, required this.subjectID});
  String subjectID;

  @override
  Widget build(BuildContext context) {
    CreateAnotationController controller = CreateAnotationController(subjectID: subjectID);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextfieldWidget(
                  controller: controller.titleTextfieldController,
                  labelText: 'Nome da anotação',
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigátório';
                    }
                    return null;
                  },
                ),
                TextfieldWidget(
                  margin: const EdgeInsets.only(top: 16),
                  controller: controller.descriptionTextfieldController,
                  labelText: 'Descrição',
                  maxLength: 1000,
                ),

                InkWell(
                  onTap: controller.pickImageFromCamera,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 6),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colors.blue.withOpacity(0.1),
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  child: InkWell(
                    onTap: controller.pickDocument,
                    child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 3,
                        radius: const Radius.circular(15),
                        dashPattern: const [10, 5],
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image_search_sharp, size: 42, color: Colors.grey),
                              Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: const Text('Adicione fotos ou documentos')),
                            ],
                          ),
                        )),
                  ),
                ),
                Observer(builder: (_) {
                  return Visibility(
                    visible: controller.images.isNotEmpty,
                    child: SizedBox(
                      height: 250,
                      child: ListView.separated(
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
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => MediaQuery(
                                                data:
                                                    MediaQueryData.fromWindow(WidgetsBinding.instance.window),
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
                          itemCount: controller.images.length),
                    ),
                  );
                }),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(onPressed: controller.createAnotation, child: const Text('Criar')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
