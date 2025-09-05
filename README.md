# telegram_sms
Script para automatizar la captura de mensajes en un grupo de telegram (asi este privado) cuando se logra obtener el token de un bot incluido al grupo

## Condicione para que funcione:

El bot debe pertenecer a un grupo en telegram con permisos para poder leer los mensajes, si el bot no tiene este permiso, no sera posible capturar las conversaciones....

## Requisitos para correr el script

Antes de correr el script debes tener instalado `jq` 

```bash
sudo apt install jq -y
```

## Funcionamiento del bot

---

Una vez instalado jq y corrido el script (ya agregado al codigo el token del bot) se veria asi:


<img width="1275" height="220" alt="image" src="https://github.com/user-attachments/assets/864d966c-7d61-4dbf-932c-a72bad300a0b" />

---

ahora para fines de demostracion, vamos a enviar un mensaje en el grupo donde se encuentra el bot


<img width="1640" height="1074" alt="image" src="https://github.com/user-attachments/assets/035e2079-90cb-4433-a050-555d6ed12b98" />

---
ahora chequeamos la consola donde corrimos el script

<img width="1276" height="217" alt="image" src="https://github.com/user-attachments/assets/31da7cfb-94e8-42d3-a17e-68f0eb14ffa7" />

---
vamos a testear adjuntando archivos (el script se encarga tambien de extraerlos en nuestro equipo)

<img width="1642" height="1060" alt="image" src="https://github.com/user-attachments/assets/74207809-54c4-4aa0-855c-31f4dd2026c2" />

---

chequeamos la consola!!

<img width="1291" height="188" alt="image" src="https://github.com/user-attachments/assets/21a4ded8-6b56-4163-aa15-4e8a40839907" />

abrimos la imagen que se descargo!!

<img width="1291" height="965" alt="image" src="https://github.com/user-attachments/assets/ebea1ef0-3098-4a8e-a0c3-756b01a6654b" />

---

podemos testear tambien con audios y archivos!!! vemos

<img width="1653" height="1071" alt="image" src="https://github.com/user-attachments/assets/a5ce8cc1-1d28-4498-b817-4a86483b0dc3" />

---

consultamos la consola

<img width="1287" height="246" alt="image" src="https://github.com/user-attachments/assets/ccf3ffde-358f-4845-843e-4f2d3c49679c" />

---

chequeamos los archivos descargados

<img width="2555" height="1080" alt="image" src="https://github.com/user-attachments/assets/8ef05bad-a946-441a-af1d-a3fd7ddffc21" />

---

en definitiva el script funciona correctamente para lograr exfiltrar informacion de un grupo de telegram con solo obtener el token del bot y cuando este tiene permisos de leer mensajes!!!


## Envio de mensajes al grupo a traves del bot

Tambien es posible enviar mensajes en el grupo a traves del bot

```bash
curl -s "https://api.telegram.org/bot<TOKEN-BOT>/sendMessage" \
  -d "chat_id=<ID-CHAT>" \
  -d "MENSAJE A ENVIAR AQUI"
```

---

Para obtener el `chat_id` primero podemos hacer una peticion de la siguiente manera:

```bash
curl -s "https://api.telegram.org/bot<token>/getUpdates" |grep -w '"chat":{"id":'
```

<img width="2555" height="167" alt="image" src="https://github.com/user-attachments/assets/b6b49cab-129a-49bd-aee7-c136d70c8bae" />


pero para que esto funcione, que podamos ver esta informacion y obtener el id del grupo, es necesario tener mensajes pendientes por leer, por lo que debemos monitorear esto para lograr obtener el id, pero una vez obtenido lo demas es solo enviar el mensaje

```bash
curl -s "https://api.telegram.org/bot8401866283:AAEtl-TWMGdowvOKctbmsVKfcCtaL-6fHzk/sendMessage" \
  -d "chat_id=-4685694794" \
  -d "text=Este mensaje fue enviado a traves de la API de telegram"
```

<img width="2555" height="226" alt="image" src="https://github.com/user-attachments/assets/710e3d8a-31ed-49a7-851f-0f24c723c7b3" />

---

cheamos el grupo

<img width="1645" height="121" alt="image" src="https://github.com/user-attachments/assets/28d39bd0-be88-49c9-a486-55c2527f60f5" />











