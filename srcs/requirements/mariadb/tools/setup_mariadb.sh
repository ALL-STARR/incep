#!/bin/bash

echo "🚀 Démarrage de l'initialisation de MariaDB..."

# Vérification des variables d'environnement
if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ]; then
    echo "❌ Variables d'environnement requises manquantes."
    exit 1
fi

echo "🆕 Aucune base détectée — initialisation en cours..."
SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
SQL_PASSWORD=$(cat /run/secrets/db_password)
# Lancer MariaDB
service mariadb start

echo "🔗 Connexion à la base de données..."
MAX_RETRIES=30
COUNT=0
while [ $COUNT -lt $MAX_RETRIES ]; do
    if mysqladmin ping -h"localhost" --silent; then
        echo "✅ Connexion établie !"
        break
    fi
    echo "🔄 Tentative $((COUNT + 1))/$MAX_RETRIES..."
    sleep 2
    COUNT=$((COUNT + 1))
done

if [ $COUNT -eq $MAX_RETRIES ]; then
    echo "❌ Impossible de se connecter à MariaDB."
    exit 1
fi

echo "🔧 Configuration initiale..."

# Définir le mot de passe root via socket (aucun mot de passe requis au premier démarrage)
mysql --protocol=socket -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

sleep 2

# Utiliser le mot de passe root pour la suite
mysql -u root -p"${SQL_ROOT_PASSWORD}" << EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "🎉 Initialisation terminée avec succès !"

echo "🔥 Redémarrage de MariaDB en mode production..."
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

sleep 2

exec mariadbd-safe
