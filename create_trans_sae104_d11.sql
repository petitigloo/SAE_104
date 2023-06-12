-- Initialisation du schéma
DROP SCHEMA IF EXISTS transmusicales CASCADE; 
CREATE SCHEMA transmusicales;
SET SCHEMA 'transmusicales';

--
-- Table _annee
--

create table _annee (
    an						int 		primary key
);


-- 
-- Table _edition 
-- 

create table _edition (
	nom_edition				char(30)	primary key, 
	an						int			not null, 
	no_concert				char(30)	not null,
	
	constraint _edition_fk_annee foreign key (an)
		references _annee
); 


--
-- Table _formation
--

create table _formation (
	libelle_formation		char(30)	primary key
);


--
-- Table _type_musique
--

create table _type_musique (
    type_m	 				char(30)	primary key
); 


--
-- Table _pays
--

create table _pays (
    nom_p	 				char(30)	primary key
); 


--
-- Table _ville
--

create table _ville (
    nom_v	 				char(30)	primary key, 
    nom_p					char(30)	not null, 
    
    constraint _ville_fk_pays foreign key (nom_p)
		references _pays
); 


--
-- Table _lieu
--

create table _lieu (
    id_lieu	 				char(30)	primary key, 
    nom_lieu				char(30)	not null, 
    accesPMR				boolean		not null, 
    capacite_max			int			not null, 
    type_lieu				char(30)	not null,
    nom_v					char(30) 	not null,
    
    constraint _lieu_fk_ville foreign key (nom_v)
		references _ville(nom_v)
); 



--
-- Table _groupe_artiste
--

create table _groupe_artiste (
    id_groupe_artiste		char(30)	primary key, 
    nom_groupe_artiste		char(30)	not null, 
    site_web				char(30),
    an_debut				int		not null, 
    an_sortie_discographie	int		not null, 
    nom_p					char(30)	not null, 
    libelle_formation		char(30), 
    type_m_principal		char(30)	not null, 
    type_m_ponctuel			char(30),
    
    constraint _groupe_artiste_fk1_annee foreign key (an_debut)
		references _annee, 
	constraint _groupe_artiste_fk2_annee foreign key (an_sortie_discographie)
		references _annee, 
	constraint _groupe_artiste_fk_pays foreign key (nom_p)
		references _pays, 
	constraint _groupe_artiste_fk_formation foreign key (libelle_formation)
		references _formation, 
	constraint _groupe_artiste_fk1_type_musique foreign key (type_m_principal)
		references _type_musique, 
	constraint _groupe_artiste_fk2_type_musique foreign key (type_m_ponctuel)
		references _type_musique
); 


--
-- Table _concert
--

create table _concert (
	no_concert				char(30)	primary key, 
	titre					char(30)	not null, 
	resume					char(50)	not null, 
	duree					int			not null, 
	tarif					float		not null, 
	type_m					char(30)	not null, 
	nom_edition				char(30) 	not null,
	
	constraint _concert_fk_type foreign key (type_m)
		references _type_musique, 
	constraint _concert_fk_edition foreign key (nom_edition)
		references _edition(nom_edition)
);


--
-- Modification de la table _edition
--

alter table _edition
	add constraint _edition_fk_concert
		foreign key (no_concert) references _concert(no_concert); 


--
-- Table _representation
--

create table _representation (
	numero_representation	char(30)	primary key, 
	heure					char(5)		not null, 
	date_representation		char(10)	not null, 
	id_groupe_artiste		char(30)	not null, 
	id_lieu					char(30)	not null, 
	no_concert				char(30)	not null, 

	constraint _representation_fk_groupe_artiste foreign key (id_groupe_artiste)
		references _groupe_artiste(id_groupe_artiste), 
	constraint _representation_fk_lieu foreign key (id_lieu)
		references _lieu(id_lieu), 
	constraint _representation_fk_concert foreign key (no_concert)
		references _concert(no_concert)
);


commit; /* Rendre permanante les tables ; Valide la creation */
