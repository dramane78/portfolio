# Castellane Auto-École — Application de Gestion

Projet réalisé dans le cadre du **BTS SIO option SLAM** — Épreuve E6 (PPE2).  
Application web de gestion d'auto-école développée en **PHP / MySQL** avec une architecture **MVC**.

---

## Fonctionnalités

| Module | Description |
|---|---|
| Candidats | Inscription, modification, suppression, suivi |
| Moniteurs | Gestion du personnel enseignant |
| Leçons | Planification et suivi des heures de conduite |
| Véhicules | Gestion du parc automobile et kilométrage |
| Facturation | Suivi des paiements par candidat |
| Planning | Vue calendaire des leçons |
| Espace élève | Interface de connexion candidat (front-office) |
| Administration | Interface secrétariat / admin (back-office) |

---

## Technologies utilisées

- **PHP** (architecture MVC)
- **MySQL** (base de données `castellane_auto`)
- **HTML5 / CSS3**
- **WAMP / Apache**

---

## Installation locale (WAMP)

1. Copier le dossier `projet_autoecole/` dans `C:\wamp64\www\`
2. Démarrer WAMP (Apache + MySQL)
3. Importer la base de données :
   - Ouvrir **phpMyAdmin** → `http://localhost/phpmyadmin`
   - Importer `sql/auto_ecole.sql` (crée la BDD et les données de test)
   - Importer `sql/auth.sql` (comptes utilisateurs)
4. Accéder à l'application : `http://localhost/projet_autoecole`

---

## Déploiement serveur (jour J — E6)

### 1. Transfert des fichiers via FileZilla
```
Protocole : SFTP
Hôte      : 172.20.1.X  (remplacer X par le numéro du poste)
Utilisateur: root
Mot de passe: root
Port      : 22
```
Copier le dossier `projet_autoecole/` vers `/var/www/html/` sur le serveur.

### 2. Import de la base de données via SSH
```bash
ssh root@172.20.1.X
mysql -u root -p
# mot de passe : root
```
Puis copier-coller le contenu de `sql/auto_ecole.sql` puis `sql/auth.sql`.

### 3. Accès à l'application
```
http://172.20.1.X/projet_autoecole
```

---

## Comptes de test

| Rôle | Identifiant | Mot de passe |
|---|---|---|
| Administrateur / Secrétariat | `admin` | `admin` |
| Candidat (espace élève) | `eleve1` | `eleve1` |

> Les comptes sont créés par le script `sql/auth.sql`.

---

## Structure du projet

```
projet_autoecole/
├── index.php               # Point d'entrée
├── login.php               # Connexion admin
├── logout.php
├── admin.php               # Tableau de bord admin
├── controleur/             # Logique métier (MVC)
│   ├── gestion_candidat.php
│   ├── gestion_moniteur.php
│   ├── gestion_lecon.php
│   ├── gestion_voiture.php
│   ├── gestion_facturation.php
│   ├── gestion_planning.php
│   └── home.php
├── modele/
│   └── modele.autoecole.php  # Connexion BDD + requêtes
├── Vue/Vue/                # Vues (affichage)
│   ├── vue_home.php
│   ├── vue_select_candidats.php
│   ├── vue_insert_candidat.php
│   └── ...
├── front/                  # Front-office (espace élève)
│   ├── accueil.htm
│   ├── inscription.php
│   ├── login.php
│   ├── mon_espace.php
│   └── tarifs.htm
├── assets/css/style.css
└── sql/
    ├── auto_ecole.sql      # Structure BDD + données de test
    └── auth.sql            # Comptes utilisateurs
```

---

## Auteur

**Dramane** — BTS SIO SLAM  
Dépôt GitHub : [github.com/dramane78/portfolio](https://github.com/dramane78/portfolio)
