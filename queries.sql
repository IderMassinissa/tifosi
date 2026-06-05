-- =============================================================
-- TIFOSI - Requêtes de vérification de la base de données
-- =============================================================

USE tifosi;

-- =============================================================
-- Requête 1 : Liste des noms des focaccias par ordre alphabétique croissant
-- =============================================================
-- But : Vérifier que toutes les focaccias sont bien insérées et afficher
--       leurs noms dans l'ordre A → Z
-- Résultat attendu : 8 focaccias triées alphabétiquement
SELECT nom
FROM foccacia
ORDER BY nom ASC;

-- =============================================================
-- Requête 2 : Nombre total d'ingrédients
-- =============================================================
-- But : Compter combien d'ingrédients distincts existent dans la base
-- Résultat attendu : 25
SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- =============================================================
-- Requête 3 : Prix moyen des focaccias
-- =============================================================
-- But : Calculer la moyenne des prix de toutes les focaccias
-- Résultat attendu : (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8 = 10.375
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM foccacia;

-- =============================================================
-- Requête 4 : Liste des boissons avec leur marque, triée par nom de boisson
-- =============================================================
-- But : Vérifier la liaison entre boisson et marque (JOIN)
-- Résultat attendu : 12 boissons avec leur marque, triées A → Z
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- =============================================================
-- Requête 5 : Liste des ingrédients pour une Raclaccia
-- =============================================================
-- But : Vérifier que les ingrédients de la Raclaccia sont bien enregistrés
-- Résultat attendu : Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan, Poivre (7 ingrédients)
SELECT i.nom AS ingredient, c.quantite AS quantite_g
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN foccacia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom = 'Raclaccia';

-- =============================================================
-- Requête 6 : Nom et nombre d'ingrédients pour chaque focaccia
-- =============================================================
-- But : Compter le nombre d'ingrédients par focaccia
-- Résultat attendu : 8 lignes avec le nom et le compte d'ingrédients
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- =============================================================
-- Requête 7 : Focaccia qui a le plus d'ingrédients
-- =============================================================
-- But : Trouver la focaccia avec la composition la plus riche
-- Résultat attendu : Paysanne (12 ingrédients)
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients
FROM foccacia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- =============================================================
-- Requête 8 : Liste des focaccias qui contiennent de l'ail
-- =============================================================
-- But : Filtrer les focaccias par ingrédient spécifique
-- Résultat attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne (4 focaccias)
SELECT f.nom AS focaccia
FROM foccacia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- =============================================================
-- Requête 9 : Liste des ingrédients inutilisés
-- =============================================================
-- But : Trouver les ingrédients qui ne sont dans aucune focaccia
-- Résultat attendu : Salami, Tomate cerise (non utilisés dans aucune recette)
SELECT i.nom AS ingredient_inutilise
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_focaccia IS NULL
ORDER BY i.nom ASC;

-- =============================================================
-- Requête 10 : Liste des focaccias qui n'ont pas de champignons
-- =============================================================
-- But : Trouver les focaccias sans champignons
-- Résultat attendu : Hawaienne, Américaine (pas de champignons)
SELECT f.nom AS focaccia
FROM foccacia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;