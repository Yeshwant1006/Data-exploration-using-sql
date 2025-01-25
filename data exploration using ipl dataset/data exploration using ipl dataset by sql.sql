create database  Ipl2023;

describe teams;
describe team_captains;
describe seasons;
describe players;
describe player_transfers;
describe player_performance;
describe matches;
describe match_performances;

select * from teams;
select * from team_captains;
select * from seasons;
select * from players;
select * from player_transfers;
select * from player_performance;
select * from matches;
select * from match_performances;

/* A. Team Performance Analysis */
/* 1. Which team had the most wins in the 2023 season? */
select t.team_name, count(m.match_id) as total_wins
from matches m
join teams t on m.winning_team_id = t.team_id
where m.season = 2023
group by t.team_name
order by total_wins desc
limit 1;

/* 2. What was the win percentage of each team in the 2023 season? */
select t.team_name, (count(case when m.winning_team_id = t.team_id then 1 end) / count(m.match_id)) * 100 as win_percentage
from matches m
join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id
where m.season = 2023
group by t.team_name
order by win_percentage desc;

/* 3. Which team had the highest number of runs in a single match in the 2023 season? */
select t.team_name, max(mp.runs) as highest_runs
from matches m
join teams t on m.team1_id = t.team_id
join match_performances mp on m.match_id = mp.match_id
where m.season = 2023
group by t.team_name
order by highest_runs desc
limit 1;

/* 4. What is the average number of runs scored by each team per match in the 2023 season? */
select t.team_name, avg(mp.runs) as average_runs
from matches m
join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id
join match_performances mp on m.match_id = mp.match_id
where m.season = 2023
group by t.team_name
order by average_runs desc;

/* 5. Which team had the lowest economy rate in the 2023 season? */
select t.team_name, avg(pp.economy_rate) as average_economy_rate
from player_performance pp
join match_performances mp on pp.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id 
where pp.season = 2023
group by t.team_name
order by average_economy_rate asc
limit 1;

/* 6. What is the correlation between the toss winner and the match winner in IPL 2023? */
select toss_winner_id, winning_team_id, count(*) as win_count
from matches
where season = 2023
group by toss_winner_id, winning_team_id
having toss_winner_id = winning_team_id;

/* 7.  Which team had the best bowling performance (lowest bowling average) in the 2023 season? */
select t.team_name, avg(pp.bowling_average) as avg_bowling_average
from player_performance pp
join match_performances mp on pp.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = team_id
where pp.season = 2023
group by t.team_name
order by avg_bowling_average asc
limit 1;

/* 8. Which team had the highest number of catches in the 2023 season? */
select t.team_name, sum(pp.total_catches) as total_catches
from player_performance pp
join match_performances mp on pp.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = team_id
where pp.season = 2023
group by t.team_name
order by total_catches desc
limit 1;

/* 9. Which team had the highest number of wickets in the 2023 season? */
select t.team_name, sum(pp.total_wickets) as total_wickets
from player_performance pp
join match_performances mp on pp.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = team_id
where pp.season = 2023
group by t.team_name
order by total_wickets desc
limit 1;

/* 10. Which team hit the most sixes and fours in IPL 2023? */
select t.team_name, sum(pp.total_fours) as total_fours, sum(pp.total_sixes) AS total_sixes
from player_performance pp
join players p on pp.player_id = p.player_id
join teams t on p.team_id = t.team_id
join matches m on m.team1_id = p.team_id or m.team2_id = p.team_id
where m.season = 2023
group by t.team_name
limit 1;

/* B. Player Performance Analysis */
/* 1. Top 5 Players with the Most Runs in a Season */
select p.first_name, p.last_name, pp.season, sum(pp.total_runs) as total_runs
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_runs desc
limit 5;

/* 2. Top 5 Players with the Most Wickets in a Season */
select p.first_name, p.last_name, pp.season, sum(pp.total_wickets) as total_wickets
from player_performance pp
join players p ON pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_wickets desc
limit 5;

/* 3. Players with the Best Batting to Bowling Average in a Season */
select p.first_name, p.last_name, pp.season, (pp.batting_average / pp.bowling_average) as batting_to_bowling_avg_ratio
from player_performance pp
join players p on pp.player_id = p.player_id
where pp.bowling_average > 0 and pp.batting_average > 0
order by batting_to_bowling_avg_ratio desc
limit 5;

/* 4. Players with the Highest Strike Rate in a Season */
select p.first_name, p.last_name, pp.season, max(pp.strike_rate) as highest_strike_rate
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by highest_strike_rate desc
limit 5;

/*5. Players with the Most Catches in a Season */
select p.first_name, p.last_name, pp.season, sum(pp.total_catches) as total_catches
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_catches desc
limit 5;

/* 6. Player with the Highest Economy Rate in a Season */
select p.first_name, p.last_name, pp.season, max(pp.economy_rate) as highest_economy_rate
from player_performance pp
join players p on pp.player_id = p.player_id
where pp.total_wickets > 0
group by pp.season, p.player_id
order by highest_economy_rate desc
limit 1;

/* 7. Players with the Most Fours Hit in a Season */
select p.first_name, p.last_name, pp.season, sum(pp.total_fours) as total_fours
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_fours desc
limit 5;

/* 8. Top Players with the Highest Total Contribution (Runs + Wickets) in a Season */
select p.first_name, p.last_name, pp.season,
       (sum(pp.total_runs) + sum(pp.total_wickets)) as total_contribution
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_contribution desc
limit 5;

/* 9. Top 3 Players by Batting Average in a Season */
select p.first_name, p.last_name, pp.season, pp.batting_average
from player_performance pp
join players p on pp.player_id = p.player_id
order by pp.batting_average desc
limit 3;

/* 10. Players Who Hit the Most Sixes in a Season */
select p.first_name, p.last_name, pp.season, sum(pp.total_sixes) as total_sixes
from player_performance pp
join players p on pp.player_id = p.player_id
group by pp.season, p.player_id
order by total_sixes desc
limit 5;

/* C. Captaincy Impact on Team Success */
/* 1. Which teams had the most successful captains in terms of trophies won? */
select tc.captain_name, t.team_name, t.trophies_won
from team_captains tc
join teams t on tc.team_id = t.team_id
order by t.trophies_won desc;

/* 2. Did a change in captaincy influence team performance in terms of wins? */
select t.team_name, count(m.match_id) as total_matches,
       sum(case when m.winning_team_id = t.team_id then 1 else 0 end) as total_wins,
		(sum(case when m.winning_team_id = t.team_id then 1 else 0 end) * 100) / count(m.match_id) as win_percentage
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on m.team1_id = t.team_id or m.team2_id = t.team_id
where tc.start_year < m.season and (tc.end_year is null or tc.end_year >= m.season)
group by t.team_name
order by win_percentage desc;

/* 3. Which captains have led their teams to the most final appearances? */
select tc.captain_name, count(distinct s.season_id) as finals_appearances
from team_captains tc
join seasons s on s.winner_team_id = tc.team_id or s.runner_up_team_id = tc.team_id
group by tc.captain_name
order by finals_appearances desc;

/* 4. What is the win percentage of teams with the longest-serving captains? */
select tc.captain_name, t.team_name, 
       (count(case when m.winning_team_id = t.team_id then 1 else null end) * 100) / count(m.match_id) as win_percentage
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on (m.team1_id = t.team_id OR m.team2_id = t.team_id)
where tc.end_year is null or tc.end_year >= m.season
group by tc.captain_name, t.team_name
order by win_percentage desc;

/* 5. What impact did captaincy have on the performance of the team's key players? */
select tc.captain_name, p.first_name, p.last_name, sum(pp.total_runs) as total_runs, sum(pp.total_wickets) as total_wickets
from team_captains tc
join players p on p.team_id = tc.team_id
join player_performance pp on pp.player_id = p.player_id
where pp.season between tc.start_year and coalesce(tc.end_year, year(current_date))
group by tc.captain_name, p.first_name, p.last_name
order by total_runs desc, total_wickets desc;

/* 6. Did changing captains impact the team's success in playoff stages (semi-finals or finals)? */
select tc.captain_name, count(s.season_id) as playoff_appearances, 
       sum(case when s.winner_team_id = tc.team_id then 1 else 0 end) as playoff_wins,
       (sum(case when s.winner_team_id = tc.team_id then 1 else 0 end) * 100) / count(s.season_id) as playoff_win_percentage
from team_captains tc
join seasons s on (s.winner_team_id = tc.team_id or s.runner_up_team_id = tc.team_id)
where s.year >= tc.start_year and (s.year <= coalesce(tc.end_year, year(current_date)))
group by tc.captain_name
order by playoff_win_percentage desc;

/* 7. Which captains had the highest win percentage in IPL finals? */
select tc.captain_name,  
       sum(case when s.winner_team_id = tc.team_id then 1 else 0 end) as finals_wins, 
       (sum(case when s.winner_team_id = tc.team_id then 1 else 0 end) * 100) / count(s.season_id) as finals_win_percentage
from team_captains tc
join seasons s on s.winner_team_id = tc.team_id or s.runner_up_team_id = tc.team_id
group by tc.captain_name
order by finals_win_percentage desc;

/* 8. How often did the captain win the toss? */
select tc.captain_name, count(m.match_id) as total_matches, 
       sum(case when m.toss_winner_id = tc.team_id then 1 else 0 end) as toss_wins,
       (sum(case when m.toss_winner_id = tc.team_id then 1 else 0 end) * 100) / count(m.match_id) as toss_win_percentage
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on m.team1_id = t.team_id or m.team2_id = t.team_id
group by tc.captain_name
order by toss_win_percentage desc;

/* 9. Which captain has the highest career win percentage, and how long did they captain? */
select tc.captain_name, 
       (count(m.match_id) * 100) / count(case when m.winning_team_id = t.team_id then 1 else 0 end) as career_win_percentage,
       (year(current_date) - min(tc.start_year)) as captaincy_duration
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on (m.team1_id = t.team_id OR m.team2_id = t.team_id)
where (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by career_win_percentage desc;

/* 10. How does the win percentage differ for teams led by captains with different career durations? */
select tc.captain_name, 
       (count(m.match_id) * 100) / count(case when m.winning_team_id = t.team_id then 1 else 0 end) as career_win_percentage,
       (year(current_date) - min(tc.start_year)) as captaincy_duration
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on (m.team1_id = t.team_id OR m.team2_id = t.team_id)
where (tc.end_year is null or tc.end_year >= m.season)
group by  tc.captain_name
having captaincy_duration > 3  
order by career_win_percentage desc;

/* D. Analyzing Match Performance Trends and Their Impact on Team Success Across Seasons */
/* 1. How does a team’s batting performance in individual matches (runs scored) correlate with match outcomes (win/loss) across seasons? */
select m.season, t.team_name, sum(mp.runs) as total_runs_scored, m.result as match_outcome
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id
group by m.season, t.team_name, m.result
order by m.season, t.team_name;

/* 2. How do individual player match performances (e.g., runs and wickets) correlate with a team's success in a season? */
select m.season, t.team_name, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets, 
       count(case when m.winning_team_id = t.team_id then 1 end) as wins
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t on t.team_id = m.team1_id or t.team_id = m.team2_id
group by m.season, t.team_name
order by m.season, total_runs desc;

/* 3. What is the relationship between the number of wickets taken by a team and match outcomes (win/loss) in a specific season? */
select m.season, t.team_name, sum(mp.wickets) as total_wickets_taken, m.result as match_outcome
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t on m.team1_id = t.team_id or m.team2_id = t.team_id
where m.season = '2023'  
group by m.season, t.team_name, m.result
order by  m.season, t.team_name;

/* 4. Does a team's bowling performance (economy rate, wickets taken) impact their win rate across seasons?  */
select m.season, t.team_name, avg(pp.economy_rate) as avg_economy_rate, sum(mp.wickets) as total_wickets, 
       count(case when m.winning_team_id = t.team_id then 1 end) as wins
from matches m
join match_performances mp on m.match_id = mp.match_id
join player_performance pp on mp.player_id = pp.player_id
join teams t on t.team_id = m.team1_id or t.team_id = m.team2_id
where pp.bowling_average is not null
group by m.season, t.team_name
order by m.season, avg_economy_rate asc;

/* 5. How do individual player batting averages correlate with their team's success in each season? */
select m.season, t.team_name, p.first_name, p.last_name, pp.batting_average
from player_performance pp
join players p on pp.player_id = p.player_id
join teams t on p.team_id = t.team_id
join matches m on t.team_id = m.team1_id or t.team_id = m.team2_id
where pp.batting_average is not null
group by m.season, t.team_name, p.first_name, p.last_name, pp.batting_average
order by m.season, t.team_name;

/* 6.  What is the impact of a team’s economy rate on match outcomes (win/loss) in 2023 season? */
select m.season, t.team_name, sum(mp.runs) as total_runs_conceded, sum(mp.balls_bowled) as total_balls_bowled,
      (sum(mp.runs) / sum(mp.balls_bowled) * 6) as economy_rate, m.result as match_outcome
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t on t.team_id = m.team1_id or t.team_id = m.team2_id
where m.season = '2023'  
group by m.season, t.team_name, m.result
order by m.season, t.team_name;

/* 7. How do fielding performances (catches) influence a team's ability to win matches over multiple seasons? */
select m.season, t.team_name, sum(mp.catches) as total_catches, 
       count(case when m.winning_team_id = t.team_id then 1 end) as wins
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t on t.team_id = m.team1_id or t.team_id = m.team2_id
group by m.season, t.team_name
order by m.season;

/* 8. Which player contributed most in terms of match-winning performances (e.g., Man of the Match awards) during a particular season? */
select s.season_id, p.first_name, p.last_name, count(s.man_of_the_match_by_team) as man_of_the_match_count
from seasons s
join players p on p.team_id = s.winner_team_id  
where s.year = '2023' and s.man_of_the_match_by_team is not null  
group by s.season_id, p.first_name, p.last_name
order by man_of_the_match_count desc
limit 1;  

/* 9. How does the impact of player performance in key matches (e.g., finals or knockout matches) affect the team’s championship success? */
select m.season, t.team_name, sum(mp.runs) AS total_runs_in_key_matches, sum(mp.wickets) as total_wickets_in_key_matches, 
       count(case when m.match_type in ('final', 'semi-final') then 1 end) AS key_matches_played,
       count(case when m.winning_team_id = t.team_id and m.match_type in ('final', 'semi-final') then 1 end) as wins_in_key_matches
from matches m
join match_performances mp on m.match_id = mp.match_id
join teams t ON t.team_id = m.team1_id or t.team_id = m.team2_id
group by m.season, t.team_name
order by m.season, total_runs_in_key_matches desc;

/* 10. What impact does a team’s performance in away matches have on their overall success across seasons? */
select m.season, t.team_name, 
       count(case when m.venue != 'home' and m.winning_team_id = t.team_id then 1 end) as away_wins, 
       count(case when m.venue != 'home' then 1 end) as away_matches,
       count(case when m.winning_team_id = t.team_id then 1 end) as total_wins,
       count(*) as total_matches
from matches m
join teams t on t.team_id = m.team1_id or t.team_id = m.team2_id
group by m.season, t.team_name
order by m.season, away_wins desc;

/* E. Impact of Captaincy on Team and Player Performance Over Time */
/* 1. Which captains had the most successful seasons in terms of team victories, factoring in match performance? */
select tc.captain_name, count(m.match_id) as successful_seasons
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on m.winning_team_id = t.team_id
join seasons s on m.season = s.year
join match_performances mp on m.match_id = mp.match_id
where tc.start_year <= s.year and (tc.end_year is null or tc.end_year >= s.year)
group by tc.captain_name
order by successful_seasons desc;

/* 2. How did the batting and bowling performance of players under different captains impact match outcomes? */
select tc.captain_name, avg(mp.runs) as avg_runs, avg(mp.wickets) as avg_wickets, count(m.match_id) as matches_played
from team_captains tc
join players p on tc.team_id = p.team_id
join match_performances mp on p.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by matches_played desc;

/* 3. How did captaincy changes influence individual player performances (runs, wickets, etc.) in key matches? */
select tc.captain_name, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets
from team_captains tc
join players p on tc.team_id = p.team_id
join match_performances mp on p.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name, p.player_id
order by total_runs desc, total_wickets desc;

/* 4. How did a captain’s leadership affect their team's performance in high-pressure matches (finals, semi-finals)? */
select tc.captain_name, count(m.match_id) as high_pressure_matches, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on (m.team1_id = t.team_id or m.team2_id = t.team_id)
join match_performances mp on m.match_id = mp.match_id
where m.match_type in ('Final', 'Semi-Final')
and tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by high_pressure_matches desc;

/* 5. How did captaincy affect the total number of player performances (runs, wickets) in the matches won by their teams? */
select tc.captain_name, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on m.winning_team_id = t.team_id
join match_performances mp on m.match_id = mp.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by total_runs desc, total_wickets desc;

/* 6. What was the captain’s impact on the team’s overall performance in a season, considering both batting and bowling? */
select tc.captain_name, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets, count(m.match_id) as matches_played
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on (m.team1_id = t.team_id or m.team2_id = t.team_id)
join match_performances mp on m.match_id = mp.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by total_runs desc, total_wickets desc;

/* 7.  Which captains saw the best individual match performances (runs, wickets) from their players? */
select tc.captain_name, MAX(mp.runs) as max_runs, MAX(mp.wickets) as max_wickets
from team_captains tc
join players p on tc.team_id = p.team_id
join match_performances mp on p.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name, p.player_id
order by max_runs desc, max_wickets desc;

/* 8. How did the performance of players in matches won compare under different captains? */
select tc.captain_name, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets
from team_captains tc
join players p on tc.team_id = p.team_id
join match_performances mp on p.player_id = mp.player_id
join matches m ON m.winning_team_id = tc.team_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name, p.player_id
order by total_runs desc, total_wickets desc;

/* 9. How did a change in captaincy correlate with the number of successful matches won by the team over time? */
select tc.captain_name, count(m.match_id) as matches_won, avg(mp.runs) as avg_runs
from team_captains tc
join teams t on tc.team_id = t.team_id
join matches m on m.winning_team_id = t.team_id
join match_performances mp on m.match_id = mp.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name
order by matches_won desc;

/* 10. How did individual player match performances (runs, wickets) fluctuate under different captains over time? */
select tc.captain_name, m.season, sum(mp.runs) as total_runs, sum(mp.wickets) as total_wickets
from team_captains tc
join players p on tc.team_id = p.team_id
join match_performances mp on p.player_id = mp.player_id
join matches m on mp.match_id = m.match_id
where tc.start_year <= m.season and (tc.end_year is null or tc.end_year >= m.season)
group by tc.captain_name, p.player_id, m.season
order by total_runs desc, total_wickets desc;








