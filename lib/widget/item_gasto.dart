import 'package:appgastos/models/gasto_model.dart';
import 'package:flutter/material.dart';

class ItemGasto extends StatelessWidget {
  final GastoModel gasto;
  final VoidCallback onDelete; // Función de eliminación pasada como parámetro

  ItemGasto({
    required this.gasto,
    required this.onDelete, // Constructor actualizado
  });

  @override
  Widget build(BuildContext context) {
    String assetImage;
    switch (gasto.type) {
      case 'Alimentos':
        assetImage = "assets/images/alimentos.webp";
        break;
      case 'Banco y seguro':
        assetImage = "assets/images/bancos.webp";
        break;
      case 'Entretenimiento':
        assetImage = "assets/images/entretenimiento.webp";
        break;
      case 'Servicios':
        assetImage = "assets/images/servicios.webp";
        break;
      case 'Otros':
        assetImage = "assets/images/otros.webp";
        break;
      default:
        assetImage = "assets/images/otros.webp";
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Image.asset(
          assetImage,
          height: 40,
          width: 40,
        ),
        title: Text(
          gasto.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          gasto.datetime,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "S/ ${gasto.price}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed:
                  onDelete, // Llama a la función de eliminación pasada como parámetro
              icon: Icon(
                Icons.delete,
                size: 20,
              ),
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
