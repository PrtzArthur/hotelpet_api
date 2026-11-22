-- Modelagem do banco de dados do HotelPet
-- Um tutor pode ter vários pets (1:N). Cada pet pertence a um único tutor.

CREATE DATABASE IF NOT EXISTS hotelpet
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE hotelpet;

DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS tutores;

CREATE TABLE tutores (
  id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome      VARCHAR(100) NOT NULL,
  telefone  VARCHAR(11)  NOT NULL,          -- somente números (DDD + número)
  email     VARCHAR(100) NULL,
  cpf_cnpj  VARCHAR(14)  NULL,              -- somente números (11 = CPF, 14 = CNPJ)
  PRIMARY KEY (id),
  UNIQUE KEY uq_tutores_cpf_cnpj (cpf_cnpj)
) ENGINE=InnoDB;

CREATE TABLE pets (
  id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome      VARCHAR(100) NOT NULL,
  especie   ENUM('Cachorro', 'Gato') NOT NULL,
  tutor_id  INT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  KEY idx_pets_tutor_id (tutor_id),
  CONSTRAINT fk_pets_tutor
    FOREIGN KEY (tutor_id) REFERENCES tutores (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Dados iniciais (os mesmos do db.json do front-end)
INSERT INTO tutores (id, nome, telefone, email, cpf_cnpj) VALUES
  (1, 'Ana',           '47999990000', NULL, NULL),
  (2, 'Carlos',        '47988880000', NULL, NULL),
  (3, 'Arthur Prants', '47676767676', 'prantsdaresenha67@gmail.com', '90184791758');

INSERT INTO pets (id, nome, especie, tutor_id) VALUES
  (1, 'Safira', 'Cachorro', 1),
  (2, 'Nino',   'Gato',     1);
