-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 25 mrt 2025 om 07:41
-- Serverversie: 10.4.32-MariaDB
-- PHP-versie: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_b2k`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `category`
--

INSERT INTO `category` (`id`, `name`, `image`) VALUES
(1, 'Vlees', 'vlees.png'),
(2, 'Vis', 'vis.png'),
(3, 'Vegetarisch', 'vega.png');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250218110316', '2025-02-18 12:04:54', 33),
('DoctrineMigrations\\Version20250218115351', '2025-02-18 12:54:09', 18),
('DoctrineMigrations\\Version20250218120251', '2025-02-18 13:03:45', 76),
('DoctrineMigrations\\Version20250218122643', '2025-02-18 13:26:50', 8),
('DoctrineMigrations\\Version20250310161337', '2025-03-10 17:13:49', 21),
('DoctrineMigrations\\Version20250311073559', '2025-03-11 08:36:06', 20),
('DoctrineMigrations\\Version20250320064300', '2025-03-21 08:25:30', 41),
('DoctrineMigrations\\Version20250321092140', '2025-03-21 10:21:46', 329),
('DoctrineMigrations\\Version20250321150521', '2025-03-21 16:05:26', 20),
('DoctrineMigrations\\Version20250322211007', '2025-03-22 22:10:30', 92),
('DoctrineMigrations\\Version20250322211951', '2025-03-22 22:19:57', 18),
('DoctrineMigrations\\Version20250324064552', '2025-03-24 07:46:50', 67),
('DoctrineMigrations\\Version20250324150724', '2025-03-24 16:07:30', 14);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `image`, `price`, `category_id`) VALUES
(1, 'Pizza Hawaï', NULL, 'hawai.jpg', 10.00, 1),
(2, 'Pizza Mozarella', NULL, 'mozarella.jpg', 4.99, 3),
(3, 'Pizza Quattro Formaggi', NULL, 'quattro_formaggi.png', 12.99, 3),
(4, 'Pizza Salami Picante', NULL, 'salami_picante.webp', 5.00, 1),
(5, 'Pizza Tonno', NULL, 'tonno.png', 10.00, 2),
(6, 'Pizza Truffel', NULL, 'truffel.jpg', 12.00, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `purchase`
--

CREATE TABLE `purchase` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `purchase`
--

INSERT INTO `purchase` (`id`, `date`, `street`, `city`, `postal_code`, `user_id`) VALUES
(2, '2025-03-22 22:24:59', 'test', 'test', 'test', 1),
(3, '2025-03-24 08:01:24', 'Brasserskade 1', 'Delft', '2612 CA', 2),
(4, '2025-03-24 08:03:42', 'Leeghwaterplein 72', 'Den Haag', '2521 DB', 2),
(5, '2025-03-24 16:15:27', 'Teststraat 78', 'Delfzijl', '3333 TT', 3),
(6, '2025-03-25 07:40:45', 'Teststraat 78', 'Delft', '1111 RT', 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `purchase_product`
--

CREATE TABLE `purchase_product` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `purchase_product`
--

INSERT INTO `purchase_product` (`id`, `product_id`, `purchase_id`, `quantity`) VALUES
(1, 2, 2, 2),
(2, 6, 2, 1),
(3, 5, 2, 2),
(4, 4, 2, 2),
(5, 1, 3, 1),
(6, 1, 4, 1),
(7, 2, 4, 1),
(8, 6, 4, 3),
(9, 4, 4, 2),
(10, 1, 5, 1),
(11, 4, 5, 5),
(12, 6, 5, 3),
(13, 1, 6, 2);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `first_name`, `last_name`) VALUES
(1, 'admin@example.com', '[\"ROLE_ADMIN\"]', '$2y$13$TYl0br9DU6N/4cS/r8VInel37QBabVz/UYRJbtgxnSmd34VQGgu/a', 'Koos', 'Busters'),
(2, 'user@example.com', '[]', '$2y$13$1afUXptwJ1VTpK8ASbNVs.h7DMQ8H59MB62qW2sWUCzdkZsRQF4Ku', 'Constant', 'Lam'),
(3, 'user1@example.com', '[]', '$2y$13$H/3d/PErJGrkGhViHcVNDOU2qOqyrSBsg468rL7amipZXB.Nse296', 'Test', 'Test');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexen voor tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexen voor tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Indexen voor tabel `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6117D13BA76ED395` (`user_id`);

--
-- Indexen voor tabel `purchase_product`
--
ALTER TABLE `purchase_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C890CED44584665A` (`product_id`),
  ADD KEY `IDX_C890CED4558FBEB9` (`purchase_id`);

--
-- Indexen voor tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT voor een tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `purchase_product`
--
ALTER TABLE `purchase_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT voor een tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Beperkingen voor tabel `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `FK_6117D13BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Beperkingen voor tabel `purchase_product`
--
ALTER TABLE `purchase_product`
  ADD CONSTRAINT `FK_C890CED44584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_C890CED4558FBEB9` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
