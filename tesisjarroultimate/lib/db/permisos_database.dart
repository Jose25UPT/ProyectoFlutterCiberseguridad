import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static List<Map<String, dynamic>> getAllPermissions() {
    return [
      {
        'nombre': 'ACCESS_FINE_LOCATION',
        'descripcion': 'Acceso a la ubicación precisa del dispositivo.',
        'plataforma': 'Android',
        'categoria': 'Ubicación',
        'clave_sistema': 'android.permission.ACCESS_FINE_LOCATION'
      },
      {
        'nombre': 'ACCESS_COARSE_LOCATION',
        'descripcion': 'Acceso a la ubicación aproximada del dispositivo.',
        'plataforma': 'Android',
        'categoria': 'Ubicación',
        'clave_sistema': 'android.permission.ACCESS_COARSE_LOCATION'
      },
      {
        'nombre': 'ACCESS_BACKGROUND_LOCATION',
        'descripcion': 'Permite que la aplicación acceda a la ubicación en segundo plano.',
        'plataforma': 'Android',
        'categoria': 'Ubicación',
        'clave_sistema': 'android.permission.ACCESS_BACKGROUND_LOCATION'
      },
      {
        'nombre': 'ACCESS_LOCATION_EXTRA_COMMANDS',
        'descripcion': 'Permite el acceso a comandos adicionales de ubicación.',
        'plataforma': 'Android',
        'categoria': 'Ubicación',
        'clave_sistema': 'android.permission.ACCESS_LOCATION_EXTRA_COMMANDS'
      },
      {
        'nombre': 'ACCESS_MEDIA_LOCATION',
        'descripcion': 'Permite acceder a la ubicación geográfica en los archivos multimedia.',
        'plataforma': 'Android',
        'categoria': 'Ubicación',
        'clave_sistema': 'android.permission.ACCESS_MEDIA_LOCATION'
      },

  // 📷 Permisos de cámara
  {
    'nombre': 'CAMERA',
    'descripcion': 'Permite que la aplicación acceda a la cámara.',
    'plataforma': 'Android',
    'categoria': 'Cámara',
    'clave_sistema': 'android.permission.CAMERA'
  },

  // 🎙️ Permisos de micrófono/audio
  {
    'nombre': 'RECORD_AUDIO',
    'descripcion': 'Permite que la aplicación grabe audio.',
    'plataforma': 'Android',
    'categoria': 'Micrófono',
    'clave_sistema': 'android.permission.RECORD_AUDIO'
  },
  {
    'nombre': 'MODIFY_AUDIO_SETTINGS',
    'descripcion': 'Permite que la aplicación modifique la configuración de audio.',
    'plataforma': 'Android',
    'categoria': 'Audio',
    'clave_sistema': 'android.permission.MODIFY_AUDIO_SETTINGS'
  },
  {
    'nombre': 'CAPTURE_AUDIO_OUTPUT',
    'descripcion': 'Permite que la aplicación capture la salida de audio.',
    'plataforma': 'Android',
    'categoria': 'Audio',
    'clave_sistema': 'android.permission.CAPTURE_AUDIO_OUTPUT'
  },
  {
    'nombre': 'CAPTURE_VOICE_COMMUNICATION_OUTPUT',
    'descripcion': 'Permite capturar la salida de comunicación por voz.',
    'plataforma': 'Android',
    'categoria': 'Audio',
    'clave_sistema': 'android.permission.CAPTURE_VOICE_COMMUNICATION_OUTPUT'
  },

  // 👤 Permisos de contactos
  {
    'nombre': 'READ_CONTACTS',
    'descripcion': 'Permite que la aplicación lea los contactos del usuario.',
    'plataforma': 'Android',
    'categoria': 'Contactos',
    'clave_sistema': 'android.permission.READ_CONTACTS'
  },
  {
    'nombre': 'WRITE_CONTACTS',
    'descripcion': 'Permite que la aplicación modifique los contactos del usuario.',
    'plataforma': 'Android',
    'categoria': 'Contactos',
    'clave_sistema': 'android.permission.WRITE_CONTACTS'
  },

  // 🗓️ Permisos de calendario
  {
    'nombre': 'READ_CALENDAR',
    'descripcion': 'Permite que la aplicación lea los eventos del calendario del usuario.',
    'plataforma': 'Android',
    'categoria': 'Calendario',
    'clave_sistema': 'android.permission.READ_CALENDAR'
  },
  {
    'nombre': 'WRITE_CALENDAR',
    'descripcion': 'Permite que la aplicación modifique los eventos del calendario del usuario.',
    'plataforma': 'Android',
    'categoria': 'Calendario',
    'clave_sistema': 'android.permission.WRITE_CALENDAR'
  },

  // 📞 Permisos de llamadas
  {
    'nombre': 'READ_CALL_LOG',
    'descripcion': 'Permite que la aplicación lea el registro de llamadas del usuario.',
    'plataforma': 'Android',
    'categoria': 'Llamadas',
    'clave_sistema': 'android.permission.READ_CALL_LOG'
  },
  {
    'nombre': 'WRITE_CALL_LOG',
    'descripcion': 'Permite que la aplicación modifique el registro de llamadas del usuario.',
    'plataforma': 'Android',
    'categoria': 'Llamadas',
    'clave_sistema': 'android.permission.WRITE_CALL_LOG'
  },
  {
    'nombre': 'PROCESS_OUTGOING_CALLS',
    'descripcion': 'Permite que la aplicación procese llamadas salientes.',
    'plataforma': 'Android',
    'categoria': 'Llamadas',
    'clave_sistema': 'android.permission.PROCESS_OUTGOING_CALLS'
  },
  {
    'nombre': 'ANSWER_PHONE_CALLS',
    'descripcion': 'Permite que la aplicación responda llamadas telefónicas.',
    'plataforma': 'Android',
    'categoria': 'Llamadas',
    'clave_sistema': 'android.permission.ANSWER_PHONE_CALLS'
  },
  {
    'nombre': 'ADD_VOICEMAIL',
    'descripcion': 'Permite que la aplicación agregue mensajes de voz.',
    'plataforma': 'Android',
    'categoria': 'Llamadas',
    'clave_sistema': 'android.permission.ADD_VOICEMAIL'
  },
  // 📩 Permisos de SMS/MMS
{
  'nombre': 'READ_SMS',
  'descripcion': 'Permite que la aplicación lea los mensajes SMS del usuario.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.READ_SMS'
},
{
  'nombre': 'SEND_SMS',
  'descripcion': 'Permite que la aplicación envíe mensajes SMS.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.SEND_SMS'
},
{
  'nombre': 'RECEIVE_SMS',
  'descripcion': 'Permite que la aplicación reciba mensajes SMS.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.RECEIVE_SMS'
},
{
  'nombre': 'RECEIVE_WAP_PUSH',
  'descripcion': 'Permite recibir mensajes WAP PUSH.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.RECEIVE_WAP_PUSH'
},
{
  'nombre': 'RECEIVE_MMS',
  'descripcion': 'Permite recibir mensajes MMS.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.RECEIVE_MMS'
},
{
  'nombre': 'READ_CELL_BROADCASTS',
  'descripcion': 'Permite leer mensajes de difusión celular.',
  'plataforma': 'Android',
  'categoria': 'Mensajes',
  'clave_sistema': 'android.permission.READ_CELL_BROADCASTS'
},

// 🌐 Permisos de Red
{
  'nombre': 'ACCESS_WIFI_STATE',
  'descripcion': 'Permite que la aplicación acceda a la información sobre redes Wi-Fi.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'clave_sistema': 'android.permission.ACCESS_WIFI_STATE'
},
{
  'nombre': 'CHANGE_WIFI_STATE',
  'descripcion': 'Permite que la aplicación cambie el estado de la conectividad Wi-Fi.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'clave_sistema': 'android.permission.CHANGE_WIFI_STATE'
},
{
  'nombre': 'ACCESS_NETWORK_STATE',
  'descripcion': 'Permite que la aplicación acceda a la información sobre redes.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'clave_sistema': 'android.permission.ACCESS_NETWORK_STATE'
},
{
  'nombre': 'CHANGE_NETWORK_STATE',
  'descripcion': 'Permite que la aplicación cambie el estado de la conectividad de red.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'clave_sistema': 'android.permission.CHANGE_NETWORK_STATE'
},
{
  'nombre': 'INTERNET',
  'descripcion': 'Permite que la aplicación acceda a Internet.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'clave_sistema': 'android.permission.INTERNET'
},

// 📶 Permisos de Bluetooth
{
  'nombre': 'BLUETOOTH',
  'descripcion': 'Permite que la aplicación se conecte a dispositivos Bluetooth emparejados.',
  'plataforma': 'Android',
  'categoria': 'Bluetooth',
  'clave_sistema': 'android.permission.BLUETOOTH'
},
{
  'nombre': 'BLUETOOTH_ADMIN',
  'descripcion': 'Permite que la aplicación configure los dispositivos Bluetooth locales.',
  'plataforma': 'Android',
  'categoria': 'Bluetooth',
  'clave_sistema': 'android.permission.BLUETOOTH_ADMIN'
},
{
  'nombre': 'BLUETOOTH_PRIVILEGED',
  'descripcion': 'Permite el acceso sin restricciones a Bluetooth.',
  'plataforma': 'Android',
  'categoria': 'Bluetooth',
  'clave_sistema': 'android.permission.BLUETOOTH_PRIVILEGED'
},
{
  'nombre': 'BLUETOOTH_CONNECT',
  'descripcion': 'Permite conectarse a dispositivos Bluetooth emparejados (Android 12+).',
  'plataforma': 'Android',
  'categoria': 'Bluetooth',
  'clave_sistema': 'android.permission.BLUETOOTH_CONNECT'
},
  {
    'permiso': 'BLUETOOTH_SCAN',
    'descripcion': 'Permite buscar dispositivos Bluetooth (Android 12+).',
    'plataforma': 'Android',
    'categoria': 'Bluetooth',
    'constante': 'android.permission.BLUETOOTH_SCAN',
  },
  {
    'permiso': 'BLUETOOTH_ADVERTISE',
    'descripcion': 'Permite publicar un servicio Bluetooth (Android 12+).',
    'plataforma': 'Android',
    'categoria': 'Bluetooth',
    'constante': 'android.permission.BLUETOOTH_ADVERTISE',
  },
  {
    'permiso': 'NFC',
    'descripcion': 'Permite que la aplicación se comunique con etiquetas NFC.',
    'plataforma': 'Android',
    'categoria': 'NFC',
    'constante': 'android.permission.NFC',
  },
  {
    'permiso': 'NFC_TRANSACTION_EVENT',
    'descripcion': 'Permite recibir eventos de transacción NFC.',
    'plataforma': 'Android',
    'categoria': 'NFC',
    'constante': 'android.permission.NFC_TRANSACTION_EVENT',
  },
  {
    'permiso': 'NFC_PREFERRED_PAYMENT_INFO',
    'descripcion': 'Permite acceder a la información de pago preferida NFC.',
    'plataforma': 'Android',
    'categoria': 'NFC',
    'constante': 'android.permission.NFC_PREFERRED_PAYMENT_INFO',
  },
  {
    'permiso': 'UWB_RANGING',
    'descripcion': 'Permite el acceso a la tecnología de banda ultra ancha (UWB).',
    'plataforma': 'Android',
    'categoria': 'Red',
    'constante': 'android.permission.UWB_RANGING',
  },
  {
    'permiso': 'NEARBY_WIFI_DEVICES',
    'descripcion': 'Permite el acceso a dispositivos Wi-Fi cercanos (Android 13+).',
    'plataforma': 'Android',
    'categoria': 'Red',
    'constante': 'android.permission.NEARBY_WIFI_DEVICES',
  },

  // Permisos de seguridad/autenticación
  {
    'permiso': 'USE_FINGERPRINT',
    'descripcion': 'Permite que la aplicación use el hardware de huellas digitales.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.USE_FINGERPRINT',
  },
  {
    'permiso': 'USE_BIOMETRIC',
    'descripcion': 'Permite que la aplicación use autenticación biométrica.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.USE_BIOMETRIC',
  },
  {
    'permiso': 'MANAGE_BIOMETRIC',
    'descripcion': 'Permite gestionar la autenticación biométrica.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.MANAGE_BIOMETRIC',
  },
  {
    'permiso': 'USE_FACE',
    'descripcion': 'Permite usar autenticación facial.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.USE_FACE',
  },
  {
    'permiso': 'USE_IRIS',
    'descripcion': 'Permite usar autenticación por iris.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.USE_IRIS',
  },
  {
    'permiso': 'DISABLE_KEYGUARD',
    'descripcion': 'Permite que la aplicación desactive el bloqueo de pantalla.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.DISABLE_KEYGUARD',
  },
  {
    'permiso': 'MANAGE_DEVICE_ADMINS',
    'descripcion': 'Permite gestionar administradores de dispositivos.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.MANAGE_DEVICE_ADMINS',
  },
  {
    'permiso': 'SET_TIME',
    'descripcion': 'Permite establecer la hora del sistema.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.SET_TIME',
  },
  {
    'permiso': 'SET_TIME_ZONE',
    'descripcion': 'Permite establecer la zona horaria.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.SET_TIME_ZONE',
  },
  {
    'permiso': 'REQUEST_PASSWORD_COMPLEXITY',
    'descripcion': 'Permite solicitar un nivel específico de complejidad de contraseña.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.REQUEST_PASSWORD_COMPLEXITY',
  },
  {
    'permiso': 'REQUEST_DELETE_PACKAGES',
    'descripcion': 'Permite solicitar la eliminación de paquetes.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.REQUEST_DELETE_PACKAGES',
  },
  {
    'permiso': 'REQUEST_INSTALL_PACKAGES',
    'descripcion': 'Permite solicitar la instalación de paquetes.',
    'plataforma': 'Android',
    'categoria': 'Seguridad',
    'constante': 'android.permission.REQUEST_INSTALL_PACKAGES',
  },
  // Permisos de almacenamiento
{
  'permiso': 'READ_EXTERNAL_STORAGE',
  'descripcion': 'Permite que la aplicación lea desde el almacenamiento externo.',
  'plataforma': 'Android',
  'categoria': 'Almacenamiento',
  'constante': 'android.permission.READ_EXTERNAL_STORAGE',
},
{
  'permiso': 'WRITE_EXTERNAL_STORAGE',
  'descripcion': 'Permite que la aplicación escriba en el almacenamiento externo.',
  'plataforma': 'Android',
  'categoria': 'Almacenamiento',
  'constante': 'android.permission.WRITE_EXTERNAL_STORAGE',
},
{
  'permiso': 'MANAGE_EXTERNAL_STORAGE',
  'descripcion': 'Permite que la aplicación administre todos los archivos en el almacenamiento externo.',
  'plataforma': 'Android',
  'categoria': 'Almacenamiento',
  'constante': 'android.permission.MANAGE_EXTERNAL_STORAGE',
},

// Permisos multimedia
{
  'permiso': 'READ_MEDIA_AUDIO',
  'descripcion': 'Permite que la aplicación lea archivos de audio.',
  'plataforma': 'Android',
  'categoria': 'Multimedia',
  'constante': 'android.permission.READ_MEDIA_AUDIO',
},
{
  'permiso': 'READ_MEDIA_IMAGES',
  'descripcion': 'Permite leer archivos de imágenes.',
  'plataforma': 'Android',
  'categoria': 'Multimedia',
  'constante': 'android.permission.READ_MEDIA_IMAGES',
},
{
  'permiso': 'READ_MEDIA_VIDEO',
  'descripcion': 'Permite leer archivos de video.',
  'plataforma': 'Android',
  'categoria': 'Multimedia',
  'constante': 'android.permission.READ_MEDIA_VIDEO',
},
{
  'permiso': 'READ_MEDIA_VISUAL_USER_SELECTED',
  'descripcion': 'Permite leer medios visuales seleccionados por el usuario (Android 14+).',
  'plataforma': 'Android',
  'categoria': 'Multimedia',
  'constante': 'android.permission.READ_MEDIA_VISUAL_USER_SELECTED',
},
// Permisos del sistema
{
  'permiso': 'SYSTEM_ALERT_WINDOW',
  'descripcion': 'Permite que la aplicación muestre ventanas sobre otras aplicaciones.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.SYSTEM_ALERT_WINDOW',
},
{
  'permiso': 'WAKE_LOCK',
  'descripcion': 'Permite que la aplicación evite que el dispositivo entre en modo de suspensión.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.WAKE_LOCK',
},
{
  'permiso': 'RECEIVE_BOOT_COMPLETED',
  'descripcion': 'Permite que la aplicación reciba el evento de finalización del arranque.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.RECEIVE_BOOT_COMPLETED',
},
{
  'permiso': 'INSTALL_PACKAGES',
  'descripcion': 'Permite que la aplicación instale paquetes.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.INSTALL_PACKAGES',
},
{
  'permiso': 'DELETE_PACKAGES',
  'descripcion': 'Permite que la aplicación desinstale paquetes.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.DELETE_PACKAGES',
},
{
  'permiso': 'READ_LOGS',
  'descripcion': 'Permite que la aplicación lea los registros del sistema.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.READ_LOGS',
},
{
  'permiso': 'WRITE_SETTINGS',
  'descripcion': 'Permite que la aplicación modifique la configuración del sistema.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.WRITE_SETTINGS',
},
{
  'permiso': 'REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
  'descripcion': 'Permite solicitar ignorar optimizaciones de batería.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
},
{
  'permiso': 'REQUEST_COMPANION_RUN_IN_BACKGROUND',
  'descripcion': 'Permite solicitar ejecución en segundo plano para dispositivos compañeros.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND',
},
{
  'permiso': 'REQUEST_COMPANION_USE_DATA_IN_BACKGROUND',
  'descripcion': 'Permite solicitar uso de datos en segundo plano para dispositivos compañeros.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND',
},
{
  'permiso': 'REQUEST_DELETE_PACKAGES',
  'descripcion': 'Permite solicitar la eliminación de paquetes.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.REQUEST_DELETE_PACKAGES',
},
{
  'permiso': 'REQUEST_INSTALL_PACKAGES',
  'descripcion': 'Permite solicitar la instalación de paquetes.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.REQUEST_INSTALL_PACKAGES',
},
// Accesibilidad
{
  'permiso': 'BIND_ACCESSIBILITY_SERVICE',
  'descripcion': 'Permite que la aplicación se vincule a un servicio de accesibilidad.',
  'plataforma': 'Android',
  'categoria': 'Accesibilidad',
  'constante': 'android.permission.BIND_ACCESSIBILITY_SERVICE',
},
// Sistema
{
  'permiso': 'BIND_AUTOFILL_SERVICE',
  'descripcion': 'Permite que la aplicación se vincule a un servicio de autocompletado.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_AUTOFILL_SERVICE',
},
// Red
{
  'permiso': 'BIND_VPN_SERVICE',
  'descripcion': 'Permite que la aplicación se vincule a un servicio VPN.',
  'plataforma': 'Android',
  'categoria': 'Red',
  'constante': 'android.permission.BIND_VPN_SERVICE',
},
// Sistema
{
  'permiso': 'BIND_WALLPAPER',
  'descripcion': 'Permite que la aplicación se vincule a un servicio de fondo de pantalla.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_WALLPAPER',
},
// Notificaciones
{
  'permiso': 'BIND_NOTIFICATION_LISTENER_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de escucha de notificaciones.',
  'plataforma': 'Android',
  'categoria': 'Notificaciones',
  'constante': 'android.permission.BIND_NOTIFICATION_LISTENER_SERVICE',
},
// Sistema
{
  'permiso': 'BIND_PRINT_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de impresión.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_PRINT_SERVICE',
},
{
  'permiso': 'BIND_QUICK_SETTINGS_TILE',
  'descripcion': 'Permite vincularse a un servicio de configuración rápida.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_QUICK_SETTINGS_TILE',
},
{
  'permiso': 'BIND_TEXT_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de texto.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_TEXT_SERVICE',
},
{
  'permiso': 'BIND_VOICE_INTERACTION',
  'descripcion': 'Permite vincularse a un servicio de interacción por voz.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_VOICE_INTERACTION',
},
{
  'permiso': 'BIND_VR_LISTENER_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de escucha de realidad virtual.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_VR_LISTENER_SERVICE',
},
{
  'permiso': 'BIND_CARRIER_SERVICES',
  'descripcion': 'Permite vincularse a servicios de operadora.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_CARRIER_SERVICES',
},
{
  'permiso': 'BIND_CARRIER_MESSAGING_SERVICE',
  'descripcion': 'Permite vincularse a servicios de mensajería de operadora.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_CARRIER_MESSAGING_SERVICE',
},
{
  'permiso': 'BIND_CHOOSER_TARGET_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de objetivos del selector.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_CHOOSER_TARGET_SERVICE',
},
{
  'permiso': 'BIND_CONDITION_PROVIDER_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de proveedor de condiciones.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_CONDITION_PROVIDER_SERVICE',
},
{
  'permiso': 'BIND_DEVICE_ADMIN',
  'descripcion': 'Permite vincularse a un administrador de dispositivo.',
  'plataforma': 'Android',
  'categoria': 'Seguridad',
  'constante': 'android.permission.BIND_DEVICE_ADMIN',
},
{
  'permiso': 'BIND_DREAM_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de pantalla de sueño.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_DREAM_SERVICE',
},
{
  'permiso': 'BIND_INCALL_SERVICE',
  'descripcion': 'Permite vincularse a un servicio en llamada.',
  'plataforma': 'Android',
  'categoria': 'Teléfono',
  'constante': 'android.permission.BIND_INCALL_SERVICE',
},
{
  'permiso': 'BIND_INPUT_METHOD',
  'descripcion': 'Permite vincularse a un método de entrada.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_INPUT_METHOD',
},
{
  'permiso': 'BIND_MIDI_DEVICE_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de dispositivo MIDI.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_MIDI_DEVICE_SERVICE',
},
{
  'permiso': 'BIND_NFC_SERVICE',
  'descripcion': 'Permite vincularse a un servicio NFC.',
  'plataforma': 'Android',
  'categoria': 'NFC',
  'constante': 'android.permission.BIND_NFC_SERVICE',
},
{
  'permiso': 'BIND_SCREENING_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de selección.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_SCREENING_SERVICE',
},
{
  'permiso': 'BIND_TELECOM_CONNECTION_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de conexión de telecomunicaciones.',
  'plataforma': 'Android',
  'categoria': 'Teléfono',
  'constante': 'android.permission.BIND_TELECOM_CONNECTION_SERVICE',
},
{
  'permiso': 'BIND_VISUAL_VOICEMAIL_SERVICE',
  'descripcion': 'Permite vincularse a un servicio de buzón de voz visual.',
  'plataforma': 'Android',
  'categoria': 'Teléfono',
  'constante': 'android.permission.BIND_VISUAL_VOICEMAIL_SERVICE',
},
{
  'permiso': 'BIND_VOICE_RECOGNITION',
  'descripcion': 'Permite vincularse a un servicio de reconocimiento de voz.',
  'plataforma': 'Android',
  'categoria': 'Sistema',
  'constante': 'android.permission.BIND_VOICE_RECOGNITION',
}
    ];
  }
}



