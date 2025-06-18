-- BEGINNER QUERIES

-- 1. View the First 5 Rows of Data

-- SELECT * 
-- FROM introvert_extrovert_db.personality_dataset
-- LIMIT 5;

-- 2. Count of Each Personality Type

-- SELECT Personality, COUNT(*) 
-- FROM introvert_extrovert_db.personality_dataset
-- GROUP BY Personality;

-- 3. Average Time Spent Alone By Personality

-- SELECT Personality, AVG(Time_spent_alone)
-- FROM introvert_extrovert_db.personality_dataset
-- GROUP BY Personality;

-- 4. Average Social Event Attendance Per Person

-- SELECT Personality, AVG(Social_event_attendance)
-- FROM introvert_extrovert_db.personality_dataset
-- GROUP BY Personality;

-- 5. Friend Circle Size Distribution

-- SELECT Friends_circle_size, COUNT(*)
-- FROM introvert_extrovert_db.personality_dataset
-- GROUP BY Friends_circle_size
-- ORDER BY Friends_circle_size;

-- 6. Top 5 Most Frequent Post Frequencies

-- SELECT Post_frequency, COUNT(*) AS count
-- FROM introvert_extrovert_db.personality_dataset
-- GROUP BY Post_frequency
-- ORDER BY count DESC
-- LIMIT 5;

-- 7. People Who Go Outside Less Than 2x (Low Activity)

-- SELECT *
-- FROM introvert_extrovert_db.personality_dataset
-- WHERE Going_outside < 2;


-- 8. Correlation Proxy: Time Spent Alone v. Friend Circle Size

-- SELECT Time_spent_alone, friend_circle_size
-- FROM introvert_extrovert_db.personality_dataset
-- ORDER BY Time_spent_alone DESC;

-- ADVANCED QUERIES

-- 1. Group Individuals Based On Combined Traits (Introver-Like v. Extrovert-Like):

-- SELECT *,
--   CASE
--     WHEN Time_spent_alone > 6 AND Drained_after_socializing = 'Yes' AND Friends_circle_size < 3 THEN 'Likely Introvert'
--     WHEN Social_event_attendance > 6 AND Going_outside > 6 AND Post_frequency > 5 THEN 'Likely Extrovert'
--     ELSE 'Mixed Traits'
--   END AS Personality_Cluster
-- FROM introvert_extrovert_db.personality_dataset;

-- 2. Rank People By Social Engagement Within Personality Types

-- SELECT *,
--   RANK() OVER (PARTITION BY Personality ORDER BY Social_event_attendance DESC) AS social_rank
-- FROM introvert_extrovert_db.personality_dataset;

-- 3. Compare Average 'Drained_after_socializing' To The Overall Average

-- SELECT *,
--   (SELECT AVG(Drained_after_socializing) FROM introvert_extrovert_db.personality_dataset) AS overall_avg,
--   CASE
--     WHEN Drained_after_socializing > (SELECT AVG(Drained_after_socializing) FROM introvert_extrovert_db.personality_dataset)
--     THEN 'Above Average'
--     ELSE 'Below Average'
--   END AS drained_comparison
-- FROM introvert_extrovert_db.personality_dataset;

-- 4. Correlation Approximation Using Normalized Z-Scores

-- WITH stats AS (
--   SELECT
--     AVG(Time_spent_alone) AS mean_time,
--     STDDEV(Time_spent_alone) AS std_time,
--     AVG(Friends_circle_size) AS mean_friends,
--     STDDEV(Friends_circle_size) AS std_friends
--   FROM introvert_extrovert_db.personality_dataset
-- ),
-- z_scores AS (
--   SELECT *,
--     (Time_spent_alone - s.mean_time) / s.std_time AS z_time,
--     (Friends_circle_size - s.mean_friends) / s.std_friends AS z_friends
--   FROM introvert_extrovert_db.personality_dataset, stats s
-- )
-- SELECT AVG(z_time * z_friends) AS correlation_estimate
-- FROM z_scores;

-- 5. Compare People With Similar Time Spent Alone With Different Social Behavior

-- WITH numbered_data AS (
--   SELECT *, ROW_NUMBER() OVER () AS row_id
--   FROM introvert_extrovert_db.personality_dataset
-- )
-- SELECT a.*, b.*
-- FROM numbered_data a
-- JOIN numbered_data b
--   ON ABS(a.Time_spent_alone - b.Time_spent_alone) <= 1
--   AND a.row_id <> b.row_id
-- WHERE ABS(a.Social_event_attendance - b.Social_event_attendance) >= 4;




