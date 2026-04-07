from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from pymongo import MongoClient
import bcrypt  # <--- 1. Importamos la librería

# Conexión a MongoDB Atlas
MONGO_URI = "mongodb+srv://dam_grupo_bravo:cduEJRiDSc99ErTG@cluster0.wdmtidw.mongodb.net/?appName=Cluster0"
cliente = MongoClient(MONGO_URI)
db = cliente['comandas_db']
coleccion_usuarios = db['usuarios']

app = FastAPI(title="API Restaurante Bravo")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class UsuarioRegistro(BaseModel):
    nombre: str
    password_hash: str
    correo: str
    telefono: str
    direccion: str
    rol: str = "cliente"

class UsuarioLogin(BaseModel):
    correo: str  
    password_hash: str

# --- RUTAS ACTUALIZADAS ---

@app.post("/registro")
def registrar_usuario(usuario: UsuarioRegistro):
    try:
        # Verificamos si el correo ya existe
        if coleccion_usuarios.find_one({"correo": usuario.correo}):
            raise HTTPException(status_code=400, detail="El correo ya está registrado")
        
        # 2. HASHEAR LA CONTRASEÑA
        # Convertimos el texto a bytes
        password_bytes = usuario.password_hash.encode('utf-8')
        # Generamos la "sal" y el hash
        sal = bcrypt.gensalt()
        hash_generado = bcrypt.hashpw(password_bytes, sal)
        
        # Preparamos el diccionario y guardamos el hash como texto (decode)
        usuario_dict = usuario.dict()
        usuario_dict["password_hash"] = hash_generado.decode('utf-8')
        
        resultado = coleccion_usuarios.insert_one(usuario_dict)
        return {"mensaje": "Usuario creado correctamente", "id": str(resultado.inserted_id)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/login")
def iniciar_sesion(credenciales: UsuarioLogin):
    usuario = coleccion_usuarios.find_one({"correo": credenciales.correo})
    
    if usuario:
        # 3. VERIFICAR LA CONTRASEÑA
        # La que viene del login (texto -> bytes)
        password_ingresada = credenciales.password_hash.encode('utf-8')
        # La que está en la DB (texto -> bytes)
        password_guardada_db = usuario["password_hash"].encode('utf-8')
        
        # Comparamos
        if bcrypt.checkpw(password_ingresada, password_guardada_db):
            return {"mensaje": "Login exitoso", "nombre": usuario["nombre"]}
    
    raise HTTPException(status_code=401, detail="Credenciales incorrectas")

@app.get("/")
def inicio():
    return {"status": "Servidor funcionando"}
