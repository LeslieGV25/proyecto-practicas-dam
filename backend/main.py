from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import auth, usuarios, categorias, productos, pedidos, mesas, reservas, ingredientes

app = FastAPI(title="API Restaurante Bravo")

# Configuración de CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Registrar routers
app.include_router(auth.router)
app.include_router(usuarios.router)
app.include_router(categorias.router)
app.include_router(productos.router)
app.include_router(pedidos.router)
app.include_router(mesas.router)
app.include_router(reservas.router)
app.include_router(ingredientes.router)

@app.get("/")
def inicio():
    return {"status": "Servidor funcionando"}

