#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games;")"

# Total goals from both teams
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games;")"

# Average goals by winning teams
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"

# Rounded average goals by winning teams
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games;")"

# Average goals in all games
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;")"

# Highest goals scored in a single game
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"

# Count of games where winning team scored more than two goals
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")"

# Winner of the 2018 tournament
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams JOIN games ON teams.team_id = games.winner_id WHERE year = 2018 AND round = 'Final';")"

# Teams who played in 2014 'Eighth-Final' round
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT name FROM teams JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year = 2014 AND round = 'Eighth-Final' ORDER BY name;")"

# Unique winning team names
echo -e "\nList of unique winning team names in the whole dataset:"
echo "$($PSQL "SELECT DISTINCT name FROM teams JOIN games ON teams.team_id = games.winner_id ORDER BY name;")"

# Year and team name of all champions
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM teams JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year;")"

# Teams that start with 'Co'
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%';")"
