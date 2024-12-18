-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE isaeva_225_film_film_id_seq;

CREATE SEQUENCE isaeva_225_film_film_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE isaeva_225_film_film_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE isaeva_225_film_film_id_seq TO postgres;

-- DROP SEQUENCE isaeva_225_hall_id_hall_seq;

CREATE SEQUENCE isaeva_225_hall_id_hall_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE isaeva_225_hall_id_hall_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE isaeva_225_hall_id_hall_seq TO postgres;

-- DROP SEQUENCE isaeva_225_screening_screening_id_seq;

CREATE SEQUENCE isaeva_225_screening_screening_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 32767
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE isaeva_225_screening_screening_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE isaeva_225_screening_screening_id_seq TO postgres;
-- public."Badirdinov_225_film" определение

-- Drop table

-- DROP TABLE "Badirdinov_225_film";

CREATE TABLE "Badirdinov_225_film" (
	film_id int2 DEFAULT nextval('isaeva_225_film_film_id_seq'::regclass) NOT NULL,
	"name" varchar NOT NULL,
	description varchar(150) NULL,
	CONSTRAINT isaeva_225_film_pk PRIMARY KEY (film_id)
);

-- Permissions

ALTER TABLE "Badirdinov_225_film" OWNER TO postgres;
GRANT ALL ON TABLE "Badirdinov_225_film" TO postgres;


-- public."Badirdinov_225_hall" определение

-- Drop table

-- DROP TABLE "Badirdinov_225_hall";

CREATE TABLE "Badirdinov_225_hall" (
	id_hall int2 DEFAULT nextval('isaeva_225_hall_id_hall_seq'::regclass) NOT NULL,
	"name" varchar NULL,
	CONSTRAINT isaeva_225_hall_pk PRIMARY KEY (id_hall)
);

-- Permissions

ALTER TABLE "Badirdinov_225_hall" OWNER TO postgres;
GRANT ALL ON TABLE "Badirdinov_225_hall" TO postgres;


-- public."Badirdinov_225_hall_row" определение

-- Drop table

-- DROP TABLE "Badirdinov_225_hall_row";

CREATE TABLE "Badirdinov_225_hall_row" (
	hall_id int2 NOT NULL,
	"number" int4 NULL,
	capasity int4 NULL,
	CONSTRAINT isaeva_225_hall_row_isaeva_225_hall_fk FOREIGN KEY (hall_id) REFERENCES "Badirdinov_225_hall"(id_hall) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE "Badirdinov_225_hall_row" OWNER TO postgres;
GRANT ALL ON TABLE "Badirdinov_225_hall_row" TO postgres;


-- public."Badirdinov_225_screening" определение

-- Drop table

-- DROP TABLE "Badirdinov_225_screening";

CREATE TABLE "Badirdinov_225_screening" (
	screening_id int2 DEFAULT nextval('isaeva_225_screening_screening_id_seq'::regclass) NOT NULL,
	hall_id int2 NOT NULL,
	film_id int2 NOT NULL,
	"time" time NULL,
	CONSTRAINT isaeva_225_screening_pk PRIMARY KEY (screening_id),
	CONSTRAINT isaeva_225_screenin_isaeva_225_hall_fk FOREIGN KEY (hall_id) REFERENCES "Badirdinov_225_hall"(id_hall) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT isaeva_225_screening_isaeva_225_film_fk FOREIGN KEY (film_id) REFERENCES "Badirdinov_225_film"(film_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE "Badirdinov_225_screening" OWNER TO postgres;
GRANT ALL ON TABLE "Badirdinov_225_screening" TO postgres;


-- public."Badirdinov_225_tickets" определение

-- Drop table

-- DROP TABLE "Badirdinov_225_tickets";

CREATE TABLE "Badirdinov_225_tickets" (
	id_screening int2 NOT NULL,
	"row" int4 NOT NULL,
	seat int4 NOT NULL,
	"cost" int4 NULL,
	CONSTRAINT isaeva_225_tickets_pk PRIMARY KEY (id_screening),
	CONSTRAINT isaeva_225_tickets_unique UNIQUE ("row", seat),
	CONSTRAINT isaeva_225_tickets_isaeva_225_screening_fk FOREIGN KEY (id_screening) REFERENCES "Badirdinov_225_screening"(screening_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE "Badirdinov_225_tickets" OWNER TO postgres;
GRANT ALL ON TABLE "Badirdinov_225_tickets" TO postgres;


-- public.cinema исходный текст

CREATE OR REPLACE VIEW cinema
AS SELECT "Badirdinov_225_hall".name AS "Зал",
    "Badirdinov_225_film".name AS "Название фильма",
    "Badirdinov_225_screening"."time" AS "Воемя начада фильма"
   FROM "Badirdinov_225_screening"
     JOIN "Badirdinov_225_hall" ON "Badirdinov_225_hall".id_hall = "Badirdinov_225_screening".hall_id
     JOIN "Badirdinov_225_film" ON "Badirdinov_225_film".film_id = "Badirdinov_225_screening".film_id
  WHERE "Badirdinov_225_screening".film_id = 4;

-- Permissions

ALTER TABLE cinema OWNER TO postgres;
GRANT ALL ON TABLE cinema TO postgres;


-- public.film__ исходный текст

CREATE OR REPLACE VIEW film__
AS SELECT "Badirdinov_225_hall".name AS "Зал",
    "Badirdinov_225_film".name AS "Название ",
    "Badirdinov_225_screening"."time" AS "начало фильма"
   FROM "Badirdinov_225_screening"
     JOIN "Badirdinov_225_hall" ON "Badirdinov_225_hall".id_hall = "Badirdinov_225_screening".hall_id
     JOIN "Badirdinov_225_film" ON "Badirdinov_225_film".film_id = "Badirdinov_225_screening".film_id
  WHERE "Badirdinov_225_screening".hall_id = 3;

-- Permissions

ALTER TABLE film__ OWNER TO postgres;
GRANT ALL ON TABLE film__ TO postgres;


-- public.hall_three_row_two исходный текст

CREATE OR REPLACE VIEW hall_three_row_two
AS SELECT "Badirdinov_225_hall".name AS "Номер зала",
    "Badirdinov_225_hall_row".number AS "Номер ряда",
    "Badirdinov_225_hall_row".capasity AS "Количество мест"
   FROM "Badirdinov_225_hall_row"
     JOIN "Badirdinov_225_hall" ON "Badirdinov_225_hall".id_hall = "Badirdinov_225_hall_row".hall_id
  WHERE "Badirdinov_225_hall".name::text = 'детский'::text AND "Badirdinov_225_hall_row".number = 2;

-- Permissions

ALTER TABLE hall_three_row_two OWNER TO postgres;
GRANT ALL ON TABLE hall_three_row_two TO postgres;


-- public.late_movies исходный текст

CREATE OR REPLACE VIEW late_movies
AS SELECT "Badirdinov_225_film".name AS "Название фильма",
    "Badirdinov_225_screening"."time" AS "Время показа фильма"
   FROM "Badirdinov_225_screening"
     JOIN "Badirdinov_225_film" ON "Badirdinov_225_film".film_id = "Badirdinov_225_screening".film_id
  WHERE "Badirdinov_225_screening"."time" > '11:00:00'::time without time zone;

-- Permissions

ALTER TABLE late_movies OWNER TO postgres;
GRANT ALL ON TABLE late_movies TO postgres;



-- DROP FUNCTION public.salary_check();

CREATE OR REPLACE FUNCTION public.salary_check()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin 
	new.salary = new.price_reception * (new.percentage_salary/100) * 0.87;
return new;
end
$function$
;

-- Permissions

ALTER FUNCTION public.salary_check() OWNER TO postgres;
GRANT ALL ON FUNCTION public.salary_check() TO postgres;


-- Permissions

GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT USAGE ON SCHEMA public TO public;

INSERT INTO public."Badirdinov_225_film" (film_id,name,description) VALUES
	 (2,'Атака титанов','злые титаны убивать людей'),
	 (3,'Клинок рассекающий демонов','демоны злые убивать людей'),
	 (4,'Твое имя','прошлое и будущее обменялись телами'),
	 (5,'Дитя погоды','дождь колдуют'),
	 (6,'Наруто','мальчик котрый выжил'),
	 (7,'Тетрадь смерти','Геноцид на минималках'),
	 (8,'Покемоны','Пикачу, я выбираю тебя!!!!'),
	 (1,'Мстители','чели добрые и герои');
INSERT INTO public."Badirdinov_225_hall" (id_hall,name) VALUES
	 (1,'Мужской'),
	 (2,'женский'),
	 (3,'общий'),
	 (4,'гомогейный'),
	 (5,'детский'),
	 (6,'Комфортный'),
	 (7,'Вип'),
	 (8,'Вип+');
INSERT INTO public."Badirdinov_225_hall_row" (hall_id,"number",capasity) VALUES
	 (3,1,250),
	 (4,2,225),
	 (2,3,200),
	 (1,4,300),
	 (5,5,275),
	 (6,7,100),
	 (7,8,50),
	 (8,9,65),
	 (5,6,400);
INSERT INTO public."Badirdinov_225_screening" (screening_id,hall_id,film_id,"time") VALUES
	 (2,1,1,'13:00:00'),
	 (3,2,2,'21:00:00'),
	 (4,3,4,'11:00:00'),
	 (5,5,5,'14:00:00'),
	 (6,4,3,'09:00:00'),
	 (7,7,7,'20:00:00'),
	 (8,8,6,'12:00:00'),
	 (9,6,8,'19:00:00');
INSERT INTO public."Badirdinov_225_tickets" (id_screening,"row",seat,"cost") VALUES
	 (5,1,11,150),
	 (4,4,22,200),
	 (6,2,4,250),
	 (2,6,5,100),
	 (3,8,1,150),
	 (7,10,17,500),
	 (9,17,5,200),
	 (8,20,8,800);
