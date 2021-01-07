-- SELECT basics
SELECT population FROM world
  WHERE name = 'Germany'

SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000
  
  -- SECOND :

-- 1
SELECT name, continent, population FROM world

-- 2
  SELECT name
  FROM world
 WHERE population > 200000000

-- 3
 SELECT name, gdp/population 
FROM world
WHERE population  >= 200000000

-- 4
SELECT name, population/1000000
FROM world 
WHERE continent  = 'South America'

-- 5
SELECT name, population
 FROM world
 WHERE name IN ( 'France' , 'Germany' , 'Italy' )
-- 6
 SELECT name 
FROM world
WHERE name LIKE '%United%'

-- 7
SELECT name, population,area
FROM world
WHERE area > 3000000 OR population > 250000000

-- 8
SELECT name, population,area
FROM world
WHERE area > 3000000 AND population < 250000000 
OR area < 3000000  AND population > 250000000 

-- 9
SELECT name,ROUND(population/1000000,2),ROUND(gdp/1000000000,2)
FROM world
WHERE continent = 'South America'

-- 10
SELECT name, ROUND(gdp/population,-3)
FROM world
WHERE gdp >= 1000000000000

-- 11
SELECT name,capital
 FROM world
 WHERE LENGTH(name) = LENGTH(capital)

-- 12
 SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) 
AND name <> capital

-- 13
SELECT name
   FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %'

-- Third:

  -- 1
  SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

--  2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

  --  3
  SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

-- 4
SELECT winner
FROM nobel
WHERE yr >= 2000 AND subject =  'Peace'

-- 5
SELECT * FROM nobel 
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

-- 6
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- 7
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- 8
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Physics' AND yr = 1980
OR subject = 'Chemistry' AND yr = 1984

-- 9
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980
AND subject NOT IN ( 'Chemistry' , 'Medicine')

-- 10
SELECT yr, subject, winner
FROM nobel
WHERE yr < 1910 AND subject =  'Medicine'
OR yr >= 2004 AND  subject =  'Literature'

-- 11
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG'

-- 12
SELECT * FROM nobel
WHERE winner = "EUGENE O\'NEILL"

-- 13
SELECT winner , yr , subject
FROM nobel
WHERE winner LIKE 'Sir%' 

-- 14
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject,winner
 
 
 -- Fourth:

-- 1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2
SELECT name FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom' )

-- 3
SELECT name, continent 
FROM world
WHERE continent IN ( 
SELECT continent
FROM world 
WHERE name = 'Argentina' OR name = 'Australia') ORDER BY name

-- 4

SELECT name , population
FROM world
WHERE population> (
SELECT population FROM world
WHERE name = 'Canada') AND population < (
SELECT population FROM world
WHERE name = 'Poland')

-- 5
SELECT name , CONCAT(ROUND((population/(
SELECT population FROM world WHERE name = 'Germany'
)) * 100,0),'%')
FROM world
WHERE continent = 'Europe' 

-- 6
SELECT name FROM world
WHERE gdp > ( SELECT MAX(gdp) FROM world
WHERE continent = 'Europe' )


-- 7
  SELECT continent, name, area FROM world x
    WHERE area >= ALL
      (SELECT area FROM world y
          WHERE y.continent=x.continent
            AND area>0)


-- 8
  SELECT continent, name FROM world x
    WHERE name <= ALL
      (SELECT name FROM world y
          WHERE x.continent=y.continent)

-- 9
SELECT name , continent , population FROM world x
WHERE population <= ALL ( SELECT name FROM world y
WHERE x.continent = y.continent AND population >=
25000000)

-- 10
      SELECT name, continent FROM world x
            WHERE population / 3  > ALL
             (SELECT population FROM world y
                  WHERE x.continent=y.continent and population > 0 and y.name NOT LIKE x.name)
                  
                  
-- Fifth:

-- 1
SELECT SUM(population)
FROM world

 
-- 2
SELECT DISTINCT continent FROM world

-- 3
SELECT SUM(gdp) FROM world
WHERE continent = 'Africa'

-- 4
SELECT COUNT(name) FROM world
WHERE area >= 1000000

-- 5
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

-- 6
SELECT DISTINCT continent , COUNT(name) FROM world
GROUP BY continent

-- 7
SELECT continent , COUNT(name) FROM world
WHERE population >= 10000000 
GROUP BY continent

-- 8
SELECT continent FROM world 
GROUP BY continent
HAVING SUM(population) >= 100000000

-- Sixth:

-- 1
SELECT matchid , player 
 FROM goal 
  WHERE teamid = 'GER'

-- 2
SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012

-- 3
SELECT  player, teamid, stadium , mdate
  FROM game
 JOIN goal
 ON (game.id=goal.matchid)
WHERE goal.teamid= 'GER'

-- 4
SELECT team1 , team2 , player
FROM game
JOIN goal
ON (game.id=goal.matchid)
WHERE goal.player LIKE 'Mario%'

-- 5
SELECT player, teamid, coach, gtime
  FROM goal 
JOIN eteam
ON goal.teamid = eteam.id
 WHERE gtime<=10

--  6
SELECT mdate , teamname
FROM game JOIN eteam ON (team1 = eteam.id)
WHERE eteam.coach = 'Fernando Santos'

-- 7
SELECT player
FROM goal
JOIN game
ON goal.matchid = game.id 
WHERE stadium  = 'National Stadium, Warsaw'

-- 8
 SELECT DISTINCT player
 FROM game 
 JOIN goal
 ON matchid = id 
 WHERE ((team1='GER' or team2='GER') and teamid != 'GER') 

--  9

SELECT teamname, count(player)
FROM eteam JOIN goal ON id=teamid
group BY teamname

-- 10
SELECT stadium , COUNT(player)
FROM game
JOIN goal
ON id = goal.matchid
GROUP BY stadium

-- 11
SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid ,mdate

-- 12
SELECT matchid,mdate, count(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE ( teamid = 'GER') GROUP BY matchid, mdate

--  13
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate,matchid,team1,team2
