CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `customer_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `coupon` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cart_status` enum('paid','unpaid','payment_initiated','failed') COLLATE utf8_unicode_ci DEFAULT 'unpaid',
  `creation_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_time` timestamp NULL DEFAULT NULL,
  `updation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `expiration_days` int(11) DEFAULT '30',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_id` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci


CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cart_id` int(11) NOT NULL,
  `name` varchar(253) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` varchar(253) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `extra_details` json DEFAULT NULL,
  `status` enum('active','success','failed') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'active',
  `is_deleted` enum('Y','N') DEFAULT 'N',
  `creation_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_item_cart` (`cart_id`),
  CONSTRAINT `fk_item_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
