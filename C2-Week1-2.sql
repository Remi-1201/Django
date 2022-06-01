-- 1/ Django Data Models
-- https://docs.google.com/presentation/d/15KWvjF2obSRwOSMO3ytvFfSTBhsx2DtT/ 

-- Exact sqlite3
sqlite3 zip.sqlite3
-- Start & Quit
sqlite3 
.quit

-- Defining a table
CREATE TABLE Users(
   id integer NOT NULL
     PRIMARY KEY  
     AUTOINCREMENT, 
  name VARCHAR(128), 
  email VARCHAR(128)
);

CREATE TABLE Users( 
  name VARCHAR(128), 
  email VARCHAR(128)
);

-- CRUD in SQL

INSERT INTO Users (name, email) VALUES ('Kristin', 'kf@umich.edu'); 

DELETE FROM Users WHERE email='kf@umich.edu';

UPDATE Users SET name="Charles" WHERE email='kf@umich.edu';

SELECT * FROM Users;

SELECT * FROM Users WHERE email='kf@umich.edu';

SELECT * FROM Users ORDER BY email;

-- Compare SQL with ORM

-- SQL
CREATE TABLE Users( 
  name VARCHAR(128), 
  email VARCHAR(128)
);

-- ORM (models.py) - Slide no.9
from django.db import models

class User(models.Model):
    name = models.CharField(max_length=128)
    email = models.CharField(max_length=128)

-- CRUD in the ORM - Slide no.13
sqlite3
u = User(name='Sally', email='a2@umich.edu')
u.save()

User.objects.values()
User.objects.filter(email='csev@umich.edu').values()

User.objects.filter(email='ted@umich.edu').delete()
User.objects.values()

User.objects.filter(email='csev@umich.edu').update(name='Charles')
User.objects.values()

User.objects.values().order_by('email')
User.objects.values().order_by('-name')

-- Checking - Slide no.10
sqlite3 db.sqlite3
    sqlite> .tables
    sqlite> .schema users_user
    sqlite> .quit

-- Inserting a Record - Slide no.11
$ python3 manage.py shell

-- SQL: INSERT INTO Users (name, email) VALUES ('Kristin', 'kf@umich.edu')
from users.models import User
u = User(name='Kristen', email='kf@umich.edu')
u.save()
-- test
print(u.id) 
print(u.email) 

-- Checking SQL - Slide no.12
sqlite3
from django.db import connection
print(connection.queries)
-- result (debug data)
-- [{'sql': 'INSERT INTO "users_user" ("name", "email") VALUES (\'Kristen\', \'kf@umich.edu\')', 'time': '0.052'}]

-- makemigrations
ls */models.py
ls  */migrations/0*.py

-- Re-running makemigrate
rm bookone/migrations/0001_initial.py
python3 manage.py makemigrations

-- Re-running migrate from scratch
rm db.sqlite3
python3 manage.py migrate