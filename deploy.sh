#!/bin/bash

# Script para hacer build y deploy manual a GitHub Pages
# Ejecuta: chmod +x deploy.sh && ./deploy.sh

echo "🚀 Iniciando build/deploy para GitHub Pages..."

# Parse args
MODE="build-and-deploy"
AUTO_YES=0
BASE_HREF="/ocean_card/"

# Parse simple args
for arg in "$@"; do
    case $arg in
        deploy-only)
            MODE="deploy-only"
            shift
            ;;
        --yes)
            AUTO_YES=1
            shift
            ;;
        -b|--base-href)
            # next arg is the value
            BASE_HREF="$2"
            shift 2
            ;;
        --base-href=*)
            BASE_HREF="${arg#*=}"
            shift
            ;;
        *)
            # ignore
            ;;
    esac
done

# Verificar que estemos en la rama principal
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "master" ]; then
    echo "⚠️  Advertencia: No estás en la rama 'master'. Rama actual: $BRANCH"
    read -p "¿Continuar de todos modos? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Deploy cancelado"
        exit 1
    fi
fi

# Limpiar build anterior
echo "🧹 Limpiando builds anteriores..."
flutter clean

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Habilitar web si no está habilitado
echo "🌐 Habilitando plataforma web..."
flutter config --enable-web

# Hacer build para web (si corresponde)
if [ "$MODE" = "build-and-deploy" ]; then
    # Limpiar build anterior
    echo "🧹 Limpiando builds anteriores..."
    flutter clean

    # Obtener dependencias
    echo "📦 Obteniendo dependencias..."
    flutter pub get

    # Habilitar web si no está habilitado
    echo "🌐 Habilitando plataforma web..."
    flutter config --enable-web

    echo "🔨 Construyendo aplicación web con base-href=${BASE_HREF}..."
    flutter build web --release --base-href "${BASE_HREF}"
    BUILD_EXIT_CODE=$?
    if [ $BUILD_EXIT_CODE -ne 0 ]; then
        echo "❌ Error en el build"
        exit $BUILD_EXIT_CODE
    fi
    echo "✅ Build completado exitosamente"
    echo "📁 Los archivos están en: ./build/web"
else
    echo "⚡ Modo deploy-only: se asume que ./build/web ya existe (no se ejecuta flutter clean ni pub get)"
    if [ ! -d "./build/web" ]; then
        echo "❌ Directorio ./build/web no encontrado. Ejecuta el script sin 'deploy-only' o genera el build manualmente."
        exit 1
    fi
fi

# Verificar que el build fue exitoso

# --- Deploy a gh-pages desde build/web ---
echo "📤 Preparando deploy a branch 'gh-pages' desde ./build/web ..."

# Confirmación si no está en modo auto-yes
if [ $AUTO_YES -eq 0 ]; then
    read -p "Continuar y sobrescribir la rama 'gh-pages' remota? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Deploy cancelado"
        exit 1
    fi
fi

REMOTE_URL=$(git config --get remote.origin.url)
if [ -z "$REMOTE_URL" ]; then
    echo "❌ No se encontró remote 'origin'. Asegúrate de ejecutar este script dentro de un repo git con remote configurado."
    exit 1
fi

pushd build/web > /dev/null || exit 1

    # Inicializar repo temporal si no hay .git
    if [ -d ".git" ]; then
        echo "ℹ️  build/web ya tiene un repo git (inusual); usarlo para el deploy"
    else
        git init
        git checkout -b gh-pages-temp
    fi

    git add -A
    git commit -m "Deploy website: $(date -u +"%Y-%m-%dT%H:%M:%SZ")" || true

    # Forzar push al branch gh-pages del remote origin
    echo "🔁 Pusheando a ${REMOTE_URL} -> gh-pages (forzado)..."
    git push --force "$REMOTE_URL" HEAD:gh-pages
    PUSH_EXIT=$?

    # Si creamos un repo temporal, limpiar .git
    if [ -f .git ] || [ -d .git ]; then
        # Si el repo fue inicializado por este script, eliminar metadatos
        # Para detectar, comprobamos si existe el branch gh-pages-temp
        if git rev-parse --verify gh-pages-temp >/dev/null 2>&1; then
            rm -rf .git
        fi
    fi

popd > /dev/null || exit 1

if [ $PUSH_EXIT -eq 0 ]; then
    echo "✅ Deploy completado. Sitio publicado en la rama 'gh-pages'."
    echo "🔗 URL probable: https://$(basename -s .git "${REMOTE_URL}" | sed 's/\.git$//')/"
    exit 0
else
    echo "❌ Error al pushear a gh-pages"
    exit $PUSH_EXIT
fi
