

-- Create Users Table
CREATE TABLE user1 (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT CHECK (age > 0)
);

-- Insert Users Data (no need to specify user_id because IDENTITY auto-generates)
SET IDENTITY_INSERT user1 ON;

INSERT INTO user1 (user_id, name, email, age) VALUES
(1, 'Nitish Kumar', 'nitish@example.com', 30),
(2, 'Rakesh', 'rakesh@example.com', 28),
(3, 'Senthil Kumar', 'senthil@example.com', 35),
(4, 'Logesh', 'logesh@example.com', 40),
(5, 'Rahul Majumdar', 'rahul@example.com', 25);

select * from user1;

SET IDENTITY_INSERT users OFF;

-- Create Exercises Table
CREATE TABLE exercises (
    exercise_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES user1(user_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    muscle_group VARCHAR(50),
    equipment VARCHAR(50)
);

-- Insert Exercises Data
INSERT INTO exercises (exercise_id, user_id, name, category, muscle_group, equipment) VALUES
(101,1, 'Bench Press', 'Strength', 'Chest', 'Barbell'),
(102,2, 'Squat', 'Strength', 'Legs', 'Barbell'),
(103,3, 'Deadlift', 'Strength', 'Back', 'Barbell'),
(104,4, 'Pull-ups', 'Strength', 'Back', 'Bodyweight'),
(105,5, 'Bicep Curls', 'Strength', 'Arms', 'Dumbbell'),
(106,1, 'Running', 'Cardio', 'Legs', 'Treadmill'),
(107,2, 'Cycling', 'Cardio', 'Legs', 'Stationary Bike'),
(108,3, 'Plank', 'Core', 'Abs', 'Bodyweight'),
(109,4, 'Lunges', 'Strength', 'Legs', 'Dumbbell'),
(110,5, 'Overhead Press', 'Strength', 'Shoulders', 'Barbell'),
(111,1, 'Leg Press', 'Strength', 'Legs', 'Machine'),
(112,2, 'Dips', 'Strength', 'Triceps', 'Bodyweight'),
(113,3, 'Rowing', 'Cardio', 'Full Body', 'Rowing Machine'),
(114,4, 'Jump Rope', 'Cardio', 'Full Body', 'Rope'),
(115,5, 'Hanging Leg Raises', 'Core', 'Abs', 'Bodyweight');

select * from exercises;

-- Create Workout Sessions Table
CREATE TABLE workout_sessions (
    session_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES user1(user_id) ON DELETE CASCADE,
    workout_date DATE NOT NULL,
    duration_minutes INT CHECK (duration_minutes > 0),
    calories_burned INT CHECK (calories_burned >= 0),
    notes TEXT,
    intensity_level VARCHAR(20)
);

-- Insert Workout Sessions Data
INSERT INTO workout_sessions (session_id, user_id, workout_date, duration_minutes, calories_burned, notes, intensity_level) VALUES
(01,1, '2025-03-01', 60, 500, 'Great workout!', 'High'),
(02,2, '2025-03-02', 45, 400, 'Felt strong today.', 'Medium'),
(03,3, '2025-03-03', 30, 300, 'Quick but effective.', 'Low'),
(04,4, '2025-03-04', 90, 700, 'Pushed my limits.', 'High'),
(05,5, '2025-03-05', 50, 450, 'Solid session.', 'Medium'),
(06,1, '2025-03-06', 70, 600, 'Endurance training.', 'High'),
(07,2, '2025-03-07', 40, 350, 'Focused on form.', 'Low'),
(08,3, '2025-03-08', 55, 480, 'Great pump.', 'Medium'),
(09,4, '2025-03-09', 75, 650, 'Pushed hard.', 'High'),
(010,5, '2025-03-10', 60, 500, 'Solid gains.', 'Medium');

select * from workout_sessions;

--1) retrieve all users.
SELECT name
FROM users;

--2) get all workout sessions for user id -2
SELECT * 
FROM workout_sessions
WHERE user_id = 2;

--3)Count the number of workouts each user has completed
SELECT 
    u.name AS UserName,
    COUNT(ws.session_id) AS Total_Workouts
FROM users u
LEFT JOIN workout_sessions ws ON u.user_id = ws.user_id
GROUP BY u.name
ORDER BY Total_Workouts DESC;

--4) Find the average duration of workouts
SELECT 
    AVG(duration_minutes) AS Average_Duration
FROM workout_sessions;

--5) List all exercises in the 'Strength' category
SELECT * 
FROM exercises
WHERE category = 'Strength';

--6) Get the top 3 users who burned the most total calories
SELECT TOP 3
    u.name AS UserName,
    SUM(ws.calories_burned) AS Total_Calories_Burned
FROM users u
JOIN workout_sessions ws ON u.user_id = ws.user_id
GROUP BY u.name
ORDER BY Total_Calories_Burned DESC;

--7) Find the shortest and longest workout duration
SELECT 
    MIN(duration_minutes) AS Shortest_Workout,
    MAX(duration_minutes) AS Longest_Workout
FROM workout_sessions;

--8) Identify the youngest and oldest user
SELECT 
    MIN(age) AS Youngest_Age,
    MAX(age) AS Oldest_Age
FROM users;

--9) List users who have performed 'Squat'
SELECT DISTINCT 
    u.name AS UserName
FROM user1 u
JOIN exercises e ON u.user_id = e.user_id
WHERE e.name = 'Squat';

--10) Get all workouts on '2025-03-06'
SELECT * 
FROM workout_sessions
WHERE workout_date = '2025-03-06';