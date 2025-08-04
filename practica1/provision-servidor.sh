
echo "-----> [SERVIDOR] Actualizando lista de paquetes..."
apt-get update >/dev/null 2>&1

echo "-----> [SERVIDOR] Instalando dependencias (curl, unzip, git)..."
apt-get install -y curl unzip git >/dev/null 2>&1

echo "-----> [SERVIDOR] Instalando Consul..."
curl -sL https://releases.hashicorp.com/consul/1.18.1/consul_1.18.1_linux_amd64.zip -o consul.zip
unzip consul.zip >/dev/null 2>&1
mv consul /usr/local/bin/
rm consul.zip

echo "-----> [SERVIDOR] Instalando Node.js v18..."
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - >/dev/null 2>&1
apt-get install -y nodejs >/dev/null 2>&1

echo "-----> [SERVIDOR] Clonando el repositorio de la aplicación..."
cd /home/vagrant
rm -rf consulService
git clone https://github.com/omondragon/consulService

echo "-----> [SERVIDOR] Configurando la IP en la aplicación..."
sed -i 's/192.168.100.3/192.168.56.3/g' /home/vagrant/consulService/app/index.js

echo "-----> [SERVIDOR] Instalando dependencias de la app Node.js..."
cd /home/vagrant/consulService/app
npm install >/dev/null 2>&1

echo "-----> [SERVIDOR] Aprovisionamiento completado."
echo "Para iniciar la app, conéctate y ejecuta: cd /home/vagrant/consulService/app && node index.js 5000"
