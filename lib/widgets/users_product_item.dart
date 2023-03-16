import 'package:flutter/material.dart';
import 'package:store_app/providers/product.dart';

class UserProductItems extends StatelessWidget{
  final Product product;
  const UserProductItems({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.title),
        subtitle: Text('\$${product.amount}'),
        leading: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(product.imageUrl),),
        trailing: FittedBox(

          child: Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit), color: Theme.of(context).primaryColor,),
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete), color: Theme.of(context).errorColor,),
            ],
          ),
        ),
      ),
    );
  }
}
