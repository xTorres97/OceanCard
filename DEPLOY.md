# 🚀 Deploy Automático a GitHub Pages

Este proyecto está configurado para hacer deploy automático a GitHub Pages cuando se hace push a la rama `main`.

## 📋 Configuración Inicial

### 1. Habilitar GitHub Pages en tu repositorio

1. Ve a tu repositorio en GitHub
2. Ve a **Settings** > **Pages**
3. En **Source**, selecciona **GitHub Actions**
4. Guarda los cambios

### 2. Configurar permisos de workflow

1. Ve a **Settings** > **Actions** > **General**
2. En **Workflow permissions**, selecciona **Read and write permissions**
3. Marca **Allow GitHub Actions to create and approve pull requests**
4. Guarda los cambios

## 🔄 Despliegue Automático

El deploy se ejecuta automáticamente cuando:
- Haces push a la rama `main`
- Ejecutas manualmente el workflow desde GitHub Actions

### Proceso automático:
1. Se instala Flutter
2. Se obtienen las dependencias (`flutter pub get`)
3. Se habilita la plataforma web
4. Se construye la app (`flutter build web`)
5. Se despliega a GitHub Pages

## 🛠️ Deploy Manual

Si quieres hacer build local antes de subir:

```bash
# Opción 1: Usar el script incluido
./deploy.sh

# Opción 2: Comandos manuales
flutter clean
flutter pub get
flutter config --enable-web
flutter build web --release --web-renderer html --base-href "/ocean_card/"
```

## 🌐 URL de la aplicación

Una vez desplegada, tu aplicación estará disponible en:
```
https://[tu-usuario].github.io/ocean_card/
```

## 📁 Archivos de configuración

- `.github/workflows/deploy.yml` - Configuración de GitHub Actions
- `deploy.sh` - Script para deploy manual
- `web/index.html` - Configurado con base href dinámico

## 🔧 Troubleshooting

### Error de permisos
Si ves errores de permisos, verifica que GitHub Actions tenga permisos de escritura en **Settings** > **Actions** > **General**.

### Error de base href
Si los assets no cargan correctamente, verifica que el `--base-href` en el workflow coincida con el nombre de tu repositorio.

### Error de Flutter version
Si hay problemas con la versión de Flutter, actualiza la versión en `.github/workflows/deploy.yml`:

```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.19.0'  # Cambia por tu versión
    channel: 'stable'
```

## 📝 Notas importantes

1. **Base href**: Está configurado como `/ocean_card/` - cambia esto si tu repositorio tiene otro nombre
2. **Rama principal**: El workflow está configurado para la rama `main` - cámbialo si usas otra rama
3. **Web renderer**: Usa `html` renderer para mejor compatibilidad

## 🚦 Estados del deploy

Puedes ver el estado del deploy en:
- **Actions** tab en GitHub
- Badge de estado (opcional): Agrega esto a tu README principal:

```markdown
![Deploy Status](https://github.com/[usuario]/ocean_card/workflows/Deploy%20to%20GitHub%20Pages/badge.svg)
```
