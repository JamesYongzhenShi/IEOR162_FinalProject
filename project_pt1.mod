set TEAMS := 1..9;
set DAYS := 1..50;
set SATURDAYS := {5, 10, 15, 24, 29, 34, 39, 44};


var x{TEAMS, TEAMS, DAYS} binary;

subject to

Schedule_Constraint {i in TEAMS, j in TEAMS: i != j}:
  sum {t in DAYS} (x[i, j,t] + x[j, i, t]) = 2;
  
Total_Output_Constraint:
  sum {i in TEAMS, j in TEAMS, t in DAYS} x[i, j, t] = 72;

One_Game_Per_Weekday_Constraint {t in DAYS diff SATURDAYS}:
  sum {i in TEAMS, j in TEAMS: i != j} x[i,j,t] <= 1;

Four_Day_Period_Constraint {i in TEAMS, d in {1, 6, 11, 16, 20, 25, 30, 35, 40, 45, 49}}:
  sum {j in TEAMS, t in d..min(d+3, 50): j != i} (x[i,j,t] + x[j,i,t]) <= 1;

Saturday_Competition_Constraint1 {t in SATURDAYS}:
  sum {i in TEAMS, j in TEAMS: i != j} x[j,i,t] = 4;

Non_Overlap_Constraint1 {i in TEAMS, j in TEAMS, k in TEAMS, t in DAYS: i != j && j != k && i != k}:
  x[i,k,t] + x[j,k,t] <= 1;

Non_Overlap_Constraint2 {i in TEAMS, j in TEAMS, k in TEAMS, t in DAYS: i != j && j != k && i != k}:
  x[k,i,t] + x[k,j,t] <= 1;
  
Non_Overlap_Constraint3 {i in TEAMS, j in TEAMS, t in DAYS: i != j}:
  x[i,j,t] + x[j,i,t] <= 1;
  
solve;


