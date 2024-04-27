import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/providers/category_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {

  final Categoria? categoria;

  const CategoryModal({
    super.key,
    this.categoria
  });

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoria?.nombre ?? 'Nueva categoría', style: CustomLabels.h1().copyWith(color: Colors.white)),
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.close),
              )
            ],
          ),

          Divider(color: Colors.white.withOpacity(0.3)),

          const SizedBox(height: 20),

          TextFormField(
            initialValue: widget.categoria?.nombre,
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.inputDecoration(
              hint: 'Nombre de la categoría', 
              label: 'Categoría', 
              iconData: Icons.new_releases_outlined
            ),
            style: const TextStyle(color: Colors.white),
          ),

          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              text: 'Guardar',
              color: Colors.white,
              textColor: Colors.white,
              onPressed: () async {
                try {
                  if (id == null) {
                    await provider.newCategory(nombre);
                    NotificationService.showSnackbarError('$nombre Creado!');
                  } else {
                    await provider.updateCategory(id!, nombre);
                    NotificationService.showSnackbarError('$nombre Actualizado!');
                  }  
                } on Exception catch (e) {
                  NotificationService.showSnackbarError(e.toString()); 
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color(0xFF0F2041),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}