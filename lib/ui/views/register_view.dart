import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

    @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  //validator: ,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.inputDecoration(
                    hint: 'Ingrese su nombre',
                    label: 'Nombre',
                    iconData: Icons.supervised_user_circle_sharp
                  ) 
                ),

                const SizedBox(height: 20),

                TextFormField(
                  //validator: ,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.inputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Email',
                    iconData: Icons.email_outlined
                  ) 
                ),

                const SizedBox(height: 20),

                TextFormField(
                  //validator: ,
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
                  onPressed: () {}, 
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
  }
}