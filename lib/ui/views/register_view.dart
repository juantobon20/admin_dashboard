import 'package:admin_dashboard/providers/register_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

    @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(
        builder: (context) {
          final registerProvider = Provider.of<RegisterFormProvider>(context);
          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerProvider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                         validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingrese su nombre';
                          }
                          if (value.length < 6) {
                            return 'El nombre debe ser de 6 caracteres';
                          }
                          return null;
                        },
                        onChanged: (value) => registerProvider.name = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.inputDecoration(
                          hint: 'Ingrese su nombre',
                          label: 'Nombre',
                          iconData: Icons.supervised_user_circle_sharp
                        ) 
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        onChanged: (value) => registerProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? '')) {
                            return 'Email no válido';
                          } 
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.inputDecoration(
                          hint: 'Ingrese su correo',
                          label: 'Email',
                          iconData: Icons.email_outlined
                        ) 
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe ser de 6 caracteres';
                          }
                          return null;
                        },
                        onChanged: (value) => registerProvider.password = value,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.inputDecoration(
                          hint: 'Ingrese su contraseña',
                          label: 'Contraseña',
                          iconData: Icons.lock_outline
                        ) 
                      ),

                      const SizedBox(height: 20),

                      CustomOutlinedButton(
                        onPressed: () => registerProvider.validateForm(), 
                        text: 'Crear cuenta',
                      ),

                      const SizedBox(height: 20),

                      LinkText(
                        text: 'Ir al login',
                        onPressed: () {
                          Navigator.pushNamed(context, Flurorouter.loginRoute);
                        },
                      )
                    ],
                  )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}