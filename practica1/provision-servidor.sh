
echo "-----> [SERVIDOR] Actualizando lista de paquetes..."
apt-get update >/dev/null 2>&1

echo "-----> [SERVIDOR] Instalando dependencias base (curl, unzip, git)..."
apt-get install -y curl unzip git >/dev/null 2>&1

echo "-----> [SERVIDOR] Instalando Consul..."
if [ ! -f "/usr/local/bin/consul" ]; then
    curl -sL https://releases.hashicorp.com/consul/1.18.1/consul_1.18.1_linux_amd64.zip -o consul.zip
    unzip consul.zip >/dev/null 2>&1
    mv consul /usr/local/bin/
    rm consul.zip
fi

echo "-----> [SERVIDOR] Instalando Node.js v18..."
if ! command -v node >/dev/null || ! node -v | grep -q "v18"; then
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - >/dev/null 2>&1
    apt-get install -y nodejs >/dev/null 2>&1
fi

echo "-----> [SERVIDOR] Clonando o actualizando el repositorio de la aplicación..."
cd /home/vagrant
rm -rf consulService
git clone https://github.com/omondragon/consulService

echo "-----> [SERVIDOR] Configurando la IP en la aplicación..."
sed -i 's/192.168.100.3/192.168.56.3/g' /home/vagrant/consulService/app/index.js

echo "-----> [SERVIDOR] Automatizando la instalación de dependencias (express y consul)..."
cd /home/vagrant/consulService/app
npm install express
npm install consul

echo "-----> [SERVIDOR] ¡Aprovisionamiento completado!"
echo "El entorno está listo. Para iniciar los servicios, conéctate y ejecuta:"
echo "1. (Terminal 1) consul agent -ui -dev -bind=192.168.56.3 -client=0.0.0.0"
echo "2. (Terminal 2) cd /home/vagrant/consulService/app && node index.js 5000"
echo "3. (Terminal 3) cd /home/vagrant/consulService/app && node index.js 5001"
echo "4. (Terminal 4) cd /home/vagrant/consulService/app && node index.js 5002"
