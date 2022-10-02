-- Create the tables
CREATE TEMP TABLE countries (id serial primary key, name varchar(99));
CREATE TEMP TABLE population(id serial primary key, year int, total_population_in_millions numeric, country_id int references countries(id));

-- Insert some data into it
INSERT INTO countries (name) values ('Ethiopia');
INSERT INTO countries (name) values ('Germany');

INSERT INTO population(year, total_population_in_millions, country_id) values(2019, 112.1, 1);
INSERT INTO population(year, total_population_in_millions, country_id) values(2020, 115, 1);
INSERT INTO population(year, total_population_in_millions, country_id) values(2021, 117.88, 1);
INSERT INTO population(year, total_population_in_millions, country_id) values(2019, 83.09, 2);
INSERT INTO population(year, total_population_in_millions, country_id) values(2021, 83.90, 2);

-- Normal join
SELECT c.name, p.year, p.total_population_in_millions AS "population (in millions)"
         FROM countries c JOIN population p ON c.id = p.country_id;

-- Add tablefunc module
CREATE EXTENSION tablefunc;

-- crosstab(text sql)
SELECT * FROM crosstab('SELECT c.name, p.year, p.total_population_in_millions AS "population (in millions)"
         FROM countries c JOIN population p ON c.id = p.country_id order by 1, 2')
		    as ct(country_name varchar(99), "2019" numeric, "2020" numeric, "2021" numeric)

-- crosstab(text source_sql, text category_sql)
SELECT * FROM crosstab('SELECT c.name, p.year, p.total_population_in_millions AS "population (in millions)"
         FROM countries c JOIN population p ON c.id = p.country_id order by 1, 2', 'values (''2019''), (''2020''), (''2021'')' )
		    as ct(country_name varchar(99), "2019" numeric, "2020" numeric, "2021" numeric)
