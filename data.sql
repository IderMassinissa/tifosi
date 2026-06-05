-- =============================================================
-- TIFOSI - Peuplement de la base de données
-- =============================================================

USE tifosi;

-- =============================================================
-- INSERTION : ingredient (25 ingrédients)
-- =============================================================
INSERT INTO ingredient (id_ingredient, nom) VALUES
(1,  'Ail'),
(2,  'Ananas'),
(3,  'Artichaut'),
(4,  'Bacon'),
(5,  'Base Tomate'),
(6,  'Base crème'),
(7,  'Champignon'),
(8,  'Chevre'),
(9,  'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fumé'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

-- =============================================================
-- INSERTION : marque (4 marques)
-- =============================================================
INSERT INTO marque (id_marque, nom) VALUES
(1, 'Coca-cola'),
(2, 'Cristalline'),
(3, 'Monster'),
(4, 'Pepsico');

-- =============================================================
-- INSERTION : boisson (12 boissons)
-- =============================================================
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
(1,  'Coca-cola zéro',          1),
(2,  'Coca-cola original',      1),
(3,  'Fanta citron',            1),
(4,  'Fanta orange',            1),
(5,  'Capri-sun',               1),
(6,  'Pepsi',                   4),
(7,  'Pepsi Max Zéro',          4),
(8,  'Lipton zéro citron',      4),
(9,  'Lipton Peach',            4),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source',           2);

-- =============================================================
-- INSERTION : foccacia (8 focaccias)
-- =============================================================
INSERT INTO foccacia (id_focaccia, nom, prix) VALUES
(1, 'Mozaccia',        9.80),
(2, 'Gorgonzollaccia', 10.80),
(3, 'Raclaccia',       8.90),
(4, 'Emmentalaccia',   9.80),
(5, 'Tradizione',      8.90),
(6, 'Hawaienne',       11.20),
(7, 'Américaine',      10.80),
(8, 'Paysanne',        12.80);

-- =============================================================
-- INSERTION : comprend (focaccia <-> ingredient + quantité)
-- Quantités par défaut (en grammes) :
--   Ail:2, Ananas:40, Artichaut:20, Bacon:80,
--   Base Tomate:200, Base crème:200, Champignon:40,
--   Chevre:50, Cresson:20, Emmental:50, Gorgonzola:50,
--   Jambon cuit:80, Jambon fumé:80, Oeuf:50, Oignon:20,
--   Olive noire:20, Olive verte:20, Parmesan:50, Piment:2,
--   Poivre:1, Pomme de terre:80, Raclette:50, Mozarella:50
-- =============================================================

-- Mozaccia (id=1)
-- Base tomate, Mozarella, cresson, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(1, 5,  200), -- Base Tomate
(1, 25, 50),  -- Mozarella
(1, 9,  20),  -- Cresson
(1, 13, 80),  -- Jambon fumé
(1, 1,  2),   -- Ail
(1, 3,  20),  -- Artichaut
(1, 7,  40),  -- Champignon
(1, 18, 50),  -- Parmesan
(1, 20, 1),   -- Poivre
(1, 16, 20);  -- Olive noire

-- Gorgonzollaccia (id=2)
-- Base tomate, Gorgonzola, cresson, ail, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(2, 5,  200), -- Base Tomate
(2, 11, 50),  -- Gorgonzola
(2, 9,  20),  -- Cresson
(2, 1,  2),   -- Ail
(2, 7,  40),  -- Champignon
(2, 18, 50),  -- Parmesan
(2, 20, 1),   -- Poivre
(2, 16, 20);  -- Olive noire

-- Raclaccia (id=3)
-- Base tomate, raclette, cresson, ail, champignon, parmesan, poivre
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(3, 5,  200), -- Base Tomate
(3, 22, 50),  -- Raclette
(3, 9,  20),  -- Cresson
(3, 1,  2),   -- Ail
(3, 7,  40),  -- Champignon
(3, 18, 50),  -- Parmesan
(3, 20, 1);   -- Poivre

-- Emmentalaccia (id=4)
-- Base crème, Emmental, cresson, champignon, parmesan, poivre, oignon
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(4, 6,  200), -- Base crème
(4, 10, 50),  -- Emmental
(4, 9,  20),  -- Cresson
(4, 7,  40),  -- Champignon
(4, 18, 50),  -- Parmesan
(4, 20, 1),   -- Poivre
(4, 15, 20);  -- Oignon

-- Tradizione (id=5)
-- Base tomate, Mozarella, cresson, jambon cuit, champignon(80), parmesan, poivre, olive noire(10), olive verte(10)
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(5, 5,  200), -- Base Tomate
(5, 25, 50),  -- Mozarella
(5, 9,  20),  -- Cresson
(5, 12, 80),  -- Jambon cuit
(5, 7,  80),  -- Champignon (quantité spéciale : 80g)
(5, 18, 50),  -- Parmesan
(5, 20, 1),   -- Poivre
(5, 16, 10),  -- Olive noire (quantité spéciale : 10g)
(5, 17, 10);  -- Olive verte (quantité spéciale : 10g)

-- Hawaienne (id=6)
-- Base tomate, Mozarella, cresson, bacon, ananas, piment, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(6, 5,  200), -- Base Tomate
(6, 25, 50),  -- Mozarella
(6, 9,  20),  -- Cresson
(6, 4,  80),  -- Bacon
(6, 2,  40),  -- Ananas
(6, 19, 2),   -- Piment
(6, 18, 50),  -- Parmesan
(6, 20, 1),   -- Poivre
(6, 16, 20);  -- Olive noire

-- Américaine (id=7)
-- Base tomate, Mozarella, cresson, bacon, pomme de terre(40), parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(7, 5,  200), -- Base Tomate
(7, 25, 50),  -- Mozarella
(7, 9,  20),  -- Cresson
(7, 4,  80),  -- Bacon
(7, 21, 40),  -- Pomme de terre (quantité spéciale : 40g)
(7, 18, 50),  -- Parmesan
(7, 20, 1),   -- Poivre
(7, 16, 20);  -- Olive noire

-- Paysanne (id=8)
-- Base crème, Chèvre, cresson, pomme de terre, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire, œuf
INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
(8, 6,  200), -- Base crème
(8, 8,  50),  -- Chevre
(8, 9,  20),  -- Cresson
(8, 21, 80),  -- Pomme de terre
(8, 13, 80),  -- Jambon fumé
(8, 1,  2),   -- Ail
(8, 3,  20),  -- Artichaut
(8, 7,  40),  -- Champignon
(8, 18, 50),  -- Parmesan
(8, 20, 1),   -- Poivre
(8, 16, 20),  -- Olive noire
(8, 14, 50);  -- Oeuf