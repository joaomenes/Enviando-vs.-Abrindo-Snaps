SELECT age_breakdown.age_bucket,
Round(SUM(CASE WHEN activities.activity_type = 'send' THEN activities.time_spent ELSE 0 END) / 
(SUM(CASE WHEN activities.activity_type IN ('send', 'open') THEN activities.time_spent ELSE 0 END)) * 100, 2) AS send_perc,
Round(SUM(CASE WHEN activities.activity_type = 'open' THEN activities.time_spent ELSE 0 END) / 
(SUM(CASE WHEN activities.activity_type IN ('send', 'open') THEN activities.time_spent ELSE 0 END)) * 100, 2) AS open_perc
FROM activities
JOIN age_breakdown 
ON activities.user_id = age_breakdown.user_id
group by age_breakdown.age_bucket