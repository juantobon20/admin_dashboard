import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/providers/user_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {

  final String uid;
  const UserView({
    super.key,
    required this.uid
  });

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  Usuario? usuario; 

  @override
  void initState() {
    super.initState();

    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid)
      .then((value) {
        if (value != null) {
          userFormProvider.user = value;
          userFormProvider.formKey  = GlobalKey();

          setState(() {
            usuario = value;
          });
        } else {
          NavigationService.replaceTo('/dashboard/users');
        }
      })
      ;
  }

  @override
  void dispose() {
    usuario = null;
    Provider.of<UserFormProvider>(context).user = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text(
          'User View',
          style: CustomLabels.h1()
        ),

        const SizedBox(height: 10),

        if (usuario == null)
          WhiteCard(
            child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )
          ),

          if (usuario != null)
            const _UserViewBody()
      ]
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody();

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(250)
      },
      children: const [
        TableRow(
          children: [
            _AvatarContainer(),
            
            _UserViewForm()
          ]
        )
      ],
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm();

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);

    return WhiteCard(
      title: 'Información general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: userFormProvider.user!.nombre,
              onChanged: (value) => userFormProvider.copyUserWith(nombre: value),
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del usuario', 
                label: 'Usuario', 
                iconData: Icons.supervised_user_circle_outlined
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Ingrese un nombre';
                }

                if (value.length < 2) {
                  return 'El nombre debe ser de dos letras minímo';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              initialValue: userFormProvider.user!.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo del usuario', 
                label: 'Correo', 
                iconData: Icons.mark_email_read_outlined
              ),
              onChanged: (value) => userFormProvider.copyUserWith(correo: value),
              validator: (value) {
                if (!EmailValidator.validate(value ?? '')) {
                  return 'Email no válido';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),


            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: TextButton.icon(
                onPressed: () async {
                  final saved = await userFormProvider.updateUser();
                  if (saved) {
                    NotificationService.showSnackbarError('Usuario actualizado');
                    if (context.mounted) {
                      Provider.of<UsersProvider>(context, listen: false).refreshUser(userFormProvider.user!);
                    }
                  } else {
                    NotificationService.showSnackbarError('No se pudo guardar');
                  }
                }, 
                icon: const Icon(Icons.save_outlined, color: Colors.white, size: 20), 
                label: const Text('Guardar', style: TextStyle(color: Colors.white),),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                  shadowColor: MaterialStatePropertyAll(Colors.transparent)
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserFormProvider>(context);

    final image = (provider.user!.img == null)
      ? const Image(image: AssetImage('no-image.jpg'))
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: provider.user!.img!);

    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2()),
        
            const SizedBox(height: 20),
        
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(child: image),

                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5)
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        child: const Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white,),
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false
                          );

                          if (result != null) {
                            if (context.mounted) {
                              NotificationService.showBusyIndicator(context);
                            }
                            
                            final respo = await provider.uploadImage(result.files.first.bytes!);
                            if (context.mounted) {
                              Navigator.pop(context);
                              Provider.of<UsersProvider>(context, listen: false).refreshUser(respo);
                            }
                          }
                        }
                      ),
                    ),
                  )
                ]
              ),
            ),
        
            const SizedBox(height: 20),
        
            Text(
              provider.user!.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }
}