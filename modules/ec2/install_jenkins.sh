#!/bin/bash
set -e

echo "🔧 Mise à jour des paquets (désactivation du hook post-invoke)..."
# Supprime les hooks APT qui causent des erreurs parfois
sudo rm -f /etc/apt/apt.conf.d/50command-not-found || true
sudo apt-get -o APT::Update::Post-Invoke-Success::= -y update

echo "🔧 Installation de curl..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl

echo "🐳 Installation de Docker..."
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh

echo "👤 Ajout de l'utilisateur ubuntu au groupe docker..."
sudo usermod -aG docker ubuntu

echo "📦 Installation de Docker Compose..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-compose

echo "📁 Création du dossier Jenkins..."
sudo mkdir -p /opt/jenkins

echo "📝 Création du fichier docker-compose.yaml pour Jenkins..."
sudo tee /opt/jenkins/docker-compose.yaml > /dev/null <<EOF
version: '3.3'
services:
  jenkins:
    privileged: true
    user: root
    container_name: jenkins-server
    image: jenkins/jenkins:2.490-jdk17
    restart: always
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - /usr/bin/docker:/usr/bin/docker
      - jenkins_launch:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
volumes:
  jenkins_launch:
EOF

echo "🚀 Lancement de Jenkins avec Docker Compose..."
cd /opt/jenkins
sudo docker-compose up -d

echo "✅ Jenkins installé et démarré avec succès."
