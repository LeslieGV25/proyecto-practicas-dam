from fastapi import APIRouter, Query
from datetime import datetime
from bson import ObjectId
from database import coleccion_pedidos, coleccion_productos, coleccion_ingredientes
from models import PedidoCrear

router = APIRouter(prefix="/pedidos", tags=["Pedidos"])

def _descontar_stock(items: list):
    """Descuenta el stock de ingredientes de cada producto pedido,
    excluyendo los ingredientes que el cliente quitó (campo 'sin')."""
    for item in items:
        producto_id = item.get("producto_id", "")
        cantidad_pedida = item.get("cantidad", 1)
        ingredientes_excluidos = item.get("sin", [])

        if not producto_id:
            continue

        # Buscar el producto en BD para obtener sus ingredientes
        try:
            producto_db = coleccion_productos.find_one({"_id": ObjectId(producto_id)})
        except Exception:
            producto_db = None

        if not producto_db:
            continue

        ingredientes_raw = producto_db.get("ingredientes", [])

        for ing in ingredientes_raw:
            # Obtener el nombre del ingrediente
            if isinstance(ing, str):
                nombre_ing = ing
            elif isinstance(ing, dict):
                nombre_ing = ing.get("nombre", "")
            else:
                continue

            # Saltar si el cliente lo excluyó
            if nombre_ing in ingredientes_excluidos:
                continue

            # Descontar 1 unidad por cada cantidad pedida
            coleccion_ingredientes.update_one(
                {"nombre": {"$regex": f"^{nombre_ing}$", "$options": "i"}},
                {"$inc": {"cantidad_actual": -cantidad_pedida}}
            )

@router.post("")
def crear_pedido(pedido: PedidoCrear):
    pedido_dict = pedido.dict()
    pedido_dict["fecha"] = datetime.now().isoformat()
    pedido_dict["estado"] = "pendiente"

    # Descontar stock de ingredientes
    _descontar_stock(pedido.items)

    resultado = coleccion_pedidos.insert_one(pedido_dict)
    return {
        "id": str(resultado.inserted_id),
        "fecha": pedido_dict["fecha"],
        "total": pedido.total,
        "estado": "pendiente",
        "items": len(pedido.items),
        "mesa_id": pedido.mesa_id,
        "numero_mesa": pedido.numero_mesa,
    }

@router.get("")
def obtener_pedidos(usuario_id: str = Query(...)):
    pedidos = coleccion_pedidos.find({"usuario_id": usuario_id})
    resultado = []
    for p in pedidos:
        resultado.append({
            "id": str(p["_id"]),
            "fecha": p.get("fecha", ""),
            "total": p.get("total", 0),
            "estado": p.get("estado", "pendiente"),
            "items": p.get("items", []),
            "tipo_entrega": p.get("tipo_entrega", ""),
            "metodo_pago": p.get("metodo_pago", ""),
            "direccion_entrega": p.get("direccion_entrega", ""),
            "mesa_id": p.get("mesa_id"),
            "numero_mesa": p.get("numero_mesa"),
            "notas": p.get("notas", ""),
        })
    return resultado
