# AlicIA - HackITBA 24'

# Descripción 📄

Alicia es una aplicación movil gratuita, impulsada por inteligencia artificial, con el propósito es disminuir la barrera de entrada para recibir apoyo psicológico. 

Para lograr esto, Alicia lleva a cabo una serie de conversaciones con el usuario en las que indaga sobre su bienestar mental y emocional, dando consejos y herramientas de introspección. Tras cada sesión se genera un resumen de la misma, y asi Alicia mantiene una noción sobre conversaciones previas. 

Adicionalmente, estos datos son luego reutilizados para la conformación de un reporte general sobre el usuario, el cual es descargable con el objetivo de presentarselo a un psicólogo a manera de pie para comenzar sesiones con el mismo.

# Instalación 💻

1. Instalar MongoDB >= 7.X
2. Instalar Node.js >= 18.X
3. Abrir el directorio ./server en la terminal
4. La API de OpenAI necesita una api key paga. Les proveemos el .env (no lo subimos al repo). Pegarlo dentro del directorio server.
5. Ejecutar `npm i`
6. Ejecutar `npm start` para iniciar el servidor
7. Descargar e instalar Flutter 3.19.X: asegurarse que al ejecutar el comando `flutter doctor` todas las instalaciones han sido realizadas (Android Studio, Google Chrome, Android toolchain, emulador o dispositivo conectado, etc).

    Les dejamos un tutorial completo: https://www.youtube.com/watch?v=NF6kQJY5kL4&pp=ygUVY29tbyBpbnN0YWxhciBmbHV0dGVy

8. Conseguir dirección IPv4 (del servidor), la cual será utilizada en la app móvil para conectarse. Pueden usar el comando `ipconfig` o `ifconfig` dependiendo si usan Windows u otro sistema operativo (para mac es desde la configuración: https://www.security.org/vpn/find-mac-ip-address/).
9. Cargar la dirección IPv4 del servidor + el puerto 3000 en el archivo `host.json` ubicado en `client/alicia/` de forma que quede como el siguiente ejemplo:
```json
{
    "BASE_URL": "http://ipDelServidor:3000"
}
```
Aclaración: el emulador tiene que estar conectado a la misma red que el servidor. El archivo `host.json` puede ya tener información cargada, reemplazar por la correspondiente al servidor que corran los evaluadores.

10. Abrir un emulador / conectar el celular a la pc y ejecutar los comandos en `client/alicia/` (en caso de conectar un dispositivo físico, activar la depuración USB y el modo desarrollador en el dispositivo):
```bash
$ flutter pub get
$ flutter pub upgrade
$ dart run build_runner build
$ flutter run --dart-define-from-file=host.json
```
11. Disfrutar :D
