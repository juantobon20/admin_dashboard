import 'package:admin_dashboard/providers/category_provider.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';

class CategoryDataTableSource extends DataTableSource {

  final BuildContext context;
  final CategoryProvider provider;

  CategoryDataTableSource({
    required this.context,
    required this.provider,
  });
  
  @override
  DataRow getRow(int index) {
    final category = provider.categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(category.id)),
        DataCell(Text(category.nombre)),
        DataCell(Text(category.usuario.nombre)),
        DataCell(Row(
          children: [
            IconButton(onPressed: () {
              showModalBottomSheet(
                context: context, 
                builder: (_) => CategoryModal(categoria: category)
              );
            }, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('¿Está seguro de borrarlo?'),
                  content: Text('¿Borrar definitivamente ${category.nombre}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      child: const Text('No')
                    ),

                    TextButton(
                      onPressed: () async {
                        await provider.deleteCategory(category.id);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }, 
                      child: const Text('Si, borrar')
                    ),
                  ],
                );

                showDialog(
                  context: context, 
                  builder: (_) => dialog
                );
              }, 
              icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.8),))
          ],
        )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => provider.categories.length;

  @override
  int get selectedRowCount => 0;

}