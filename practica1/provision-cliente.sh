
echo "-----> [CLIENTE] Actualizando lista de paquetes..."
apt-get update >/dev/null 2>&1

echo "-----> [CLIENTE] Instalando curl..."
apt-get install -y curl >/dev/null 2>&1

echo "-----> [CLIENTE] Aprovisionamiento completado."
