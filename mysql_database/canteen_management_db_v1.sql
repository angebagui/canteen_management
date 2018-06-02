-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 02 Juin 2018 à 16:26
-- Version du serveur :  5.5.42
-- Version de PHP :  7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `canteen_management_db_v1`
--

-- --------------------------------------------------------

--
-- Structure de la table `drinks`
--

CREATE TABLE `drinks` (
  `id` bigint(20) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `price` varchar(300) DEFAULT NULL,
  `photo` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) NOT NULL,
  `reference` varchar(300) DEFAULT NULL,
  `customer_name` varchar(300) DEFAULT NULL,
  `customer_address` varchar(300) DEFAULT NULL,
  `customer_email` varchar(300) DEFAULT NULL,
  `customer_phone` varchar(300) DEFAULT NULL,
  `order_reference` varchar(300) DEFAULT NULL,
  `amount` varchar(300) DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `item_orders`
--

CREATE TABLE `item_orders` (
  `id` bigint(20) NOT NULL,
  `meal_id` bigint(20) DEFAULT NULL,
  `order_reference` varchar(300) DEFAULT NULL,
  `drink_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `is_meal` tinyint(1) DEFAULT NULL,
  `price` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `meals`
--

CREATE TABLE `meals` (
  `id` bigint(20) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `price` varchar(300) DEFAULT NULL,
  `photo` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `menu_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `menu_meals`
--

CREATE TABLE `menu_meals` (
  `id` bigint(20) NOT NULL,
  `menu_id` bigint(20) DEFAULT NULL,
  `meal_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `reference` varchar(300) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `is_validated` tinyint(1) DEFAULT '0',
  `validation_date` timestamp NULL DEFAULT NULL,
  `id_admin_validation` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `invoice_reference` varchar(300) DEFAULT NULL,
  `payment_method` varchar(300) DEFAULT NULL,
  `payment_reference` varchar(300) DEFAULT NULL,
  `amount` varchar(300) DEFAULT NULL,
  `id_admin_paid` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `payment_receipts`
--

CREATE TABLE `payment_receipts` (
  `id` bigint(20) NOT NULL,
  `reference` varchar(300) DEFAULT NULL,
  `invoice_reference` varchar(300) DEFAULT NULL,
  `payment_reference` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `code` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `phone` varchar(300) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `photo` varchar(300) DEFAULT NULL,
  `role_code` varchar(300) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `drinks`
--
ALTER TABLE `drinks`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`reference`),
  ADD KEY `order_reference` (`order_reference`);

--
-- Index pour la table `item_orders`
--
ALTER TABLE `item_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meal_id` (`meal_id`),
  ADD KEY `drink_id` (`drink_id`),
  ADD KEY `order_reference` (`order_reference`);

--
-- Index pour la table `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `menu_meals`
--
ALTER TABLE `menu_meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_id` (`menu_id`),
  ADD KEY `meal_id` (`meal_id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`reference`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `id_admin_validation` (`id_admin_validation`);

--
-- Index pour la table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_reference_2` (`payment_reference`),
  ADD KEY `invoice_reference` (`invoice_reference`),
  ADD KEY `payment_reference` (`payment_reference`),
  ADD KEY `id_admin_paid` (`id_admin_paid`);

--
-- Index pour la table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`reference`),
  ADD KEY `invoice_reference` (`invoice_reference`),
  ADD KEY `payment_reference` (`payment_reference`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_code` (`role_code`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `drinks`
--
ALTER TABLE `drinks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `item_orders`
--
ALTER TABLE `item_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `meals`
--
ALTER TABLE `meals`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `menu_meals`
--
ALTER TABLE `menu_meals`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `item_orders`
--
ALTER TABLE `item_orders`
  ADD CONSTRAINT `item_orders_ibfk_3` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `item_orders_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `item_orders_ibfk_2` FOREIGN KEY (`order_reference`) REFERENCES `orders` (`reference`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `menu_meals`
--
ALTER TABLE `menu_meals`
  ADD CONSTRAINT `menu_meals_ibfk_2` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `menu_meals_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_admin_validation`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`id_admin_paid`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`invoice_reference`) REFERENCES `invoices` (`reference`);

--
-- Contraintes pour la table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD CONSTRAINT `payment_receipts_ibfk_2` FOREIGN KEY (`payment_reference`) REFERENCES `payments` (`payment_reference`),
  ADD CONSTRAINT `payment_receipts_ibfk_1` FOREIGN KEY (`invoice_reference`) REFERENCES `invoices` (`reference`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `roles` (`code`);
