# AlicIA - HackITBA 24'

# Descripción 🗎

Alicia es una aplicación movil gratuita, impulsada por inteligencia artificial, con el propósito es disminuir la barrera de entrada para recibir apoyo psicológico. 

Para lograr esto, Alicia lleva a cabo una serie de conversaciones con el usuario en las que indaga sobre su bienestar mental y emocional, dando consejos y herramientas de introspección. Tras cada sesión se genera un resumen de la misma, y asi Alicia mantiene una noción sobre conversaciones previas. 

Adicionalmente, estos datos son luego reutilizados para la conformación de un reporte general sobre el usuario, el cual es descargable con el objetivo de presentarselo a un psicólogo a manera de pie para comenzar sesiones con el mismo.

# Instalación 💻

1. Instalar MongoDB
2. Instalar Node.js
3. Abrir el directorio ./server en la terminal
4. Ejecutar npm i
5. Ejecutar npm start para iniciar el servidor
5. Descargar Flutter 3.19.X
6. Conseguir dirección IPv4 (del servidor)
7. Cargar la dirección IPv4 del servidor + el puerto 3000 en el archivo host.json ubicado en `client/alicia/` de forma que quede como el siguiente ejemplo:
```json
{
    "BASE_URL": "http://ipDelServidor:3000"
}
```
8. Abrir un emulador / conectar el celular a la pc y ejecutar los comandos:
```bash
$ flutter pub get
$ flutter pub upgrade
$ dart run build_runner build
$ flutter run --dart-define-from-file=host.json
```
9. Disfrutar :D
