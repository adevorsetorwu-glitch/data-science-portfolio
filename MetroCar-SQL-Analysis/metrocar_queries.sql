/* ============================================================
   METROCAR SQL DATA ANALYSIS PROJECT
   ============================================================ */


/* ============================================================
   QUERY 1
   What percentage of app downloads successfully convert
   into user signups?
   ============================================================ */

SELECT
    (SELECT COUNT(*) FROM signups) AS total_signups,
    (SELECT COUNT(*) FROM app_downloads) AS total_downloads,
    ROUND(
        (SELECT COUNT(*) FROM signups) * 100.0 /
        (SELECT COUNT(*) FROM app_downloads),
        2
    ) AS signup_conversion_rate;


/* ============================================================
   QUERY 2
   At which stage of the customer funnel do most users
   drop off?
   ============================================================ */

SELECT
    COUNT(*) AS requested_rides,
    COUNT(accept_ts) AS accepted_rides,
    COUNT(pickup_ts) AS picked_up_rides,
    COUNT(dropoff_ts) AS completed_rides
FROM ride_requests;


/* ============================================================
   QUERY 3
   What factors contribute most to ride cancellations
   and incomplete trips?
   ============================================================ */

SELECT
    COUNT(*) AS total_requests,
    COUNT(cancel_ts) AS cancelled_rides,
    ROUND(
        COUNT(cancel_ts) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM ride_requests;


/* ============================================================
   QUERY 4A
   During which hours does MetroCar experience
   peak ride demand?
   ============================================================ */

SELECT
    EXTRACT(HOUR FROM request_ts) AS request_hour,
    COUNT(*) AS total_requests
FROM ride_requests
GROUP BY request_hour
ORDER BY total_requests DESC;


/* ============================================================
   QUERY 4B
   During which days does MetroCar experience
   peak ride demand?
   ============================================================ */

SELECT
    TO_CHAR(request_ts, 'Day') AS day_of_week,
    COUNT(*) AS total_requests
FROM ride_requests
GROUP BY day_of_week
ORDER BY total_requests DESC;


/* ============================================================
   QUERY 5A
   What is the overall ride completion rate?
   ============================================================ */

SELECT
    COUNT(*) AS total_requests,
    COUNT(dropoff_ts) AS completed_rides,
    ROUND(
        COUNT(dropoff_ts) * 100.0 / COUNT(*),
        2
    ) AS completion_rate
FROM ride_requests;


/* ============================================================
   QUERY 5B
   Revenue generated from completed rides
   ============================================================ */

SELECT
    COUNT(DISTINCT r.ride_id) AS completed_rides,
    ROUND(SUM(t.purchase_amount_usd)::numeric, 2) AS revenue_generated
FROM ride_requests r
JOIN transactions t
    ON r.ride_id = t.ride_id
WHERE r.dropoff_ts IS NOT NULL
  AND t.charge_status = 'Approved';


/* ============================================================
   QUERY 6A
   How do customer ratings reflect service quality?
   Average customer rating
   ============================================================ */

SELECT
    ROUND(AVG(rating), 2) AS average_rating
FROM reviews;


/* ============================================================
   QUERY 6B
   Rating distribution
   ============================================================ */

SELECT
    rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY rating
ORDER BY rating;


/* ============================================================
   QUERY 7
   Which customer behaviors or operational patterns
   are associated with lower customer satisfaction?
   ============================================================ */

SELECT
    CASE
        WHEN r.cancel_ts IS NOT NULL THEN 'Cancelled'
        WHEN r.dropoff_ts IS NOT NULL THEN 'Completed'
        ELSE 'Incomplete'
    END AS ride_status,
    ROUND(AVG(rv.rating), 2) AS avg_rating
FROM ride_requests r
JOIN reviews rv
    ON r.ride_id = rv.ride_id
GROUP BY ride_status;


/* ============================================================
   QUERY 8
   What trends exist in transaction revenue
   across different time periods?
   ============================================================ */

SELECT
    DATE_TRUNC('month', transaction_ts) AS month,
    ROUND(SUM(purchase_amount_usd)::numeric, 2) AS revenue
FROM transactions
WHERE charge_status = 'Approved'
GROUP BY month
ORDER BY month;


/* ============================================================
   QUERY 9
   Which platform generates the most downloads?
   ============================================================ */

SELECT
    platform,
    COUNT(*) AS total_downloads
FROM app_downloads
GROUP BY platform
ORDER BY total_downloads DESC;


/* ============================================================
   QUERY 10
   Which age group signs up the most?
   ============================================================ */

SELECT
    age_range,
    COUNT(*) AS total_signups
FROM signups
GROUP BY age_range
ORDER BY total_signups DESC;


/* ============================================================
   SUPPORTING ANALYSIS 1
   How many completed rides resulted in a review?
   ============================================================ */

SELECT
    COUNT(DISTINCT rv.ride_id) AS rides_with_reviews
FROM reviews rv;


/* ============================================================
   SUPPORTING ANALYSIS 2
   What percentage of completed rides received a review?
   ============================================================ */

SELECT
    ROUND(
        COUNT(DISTINCT rv.ride_id) * 100.0 /
        COUNT(DISTINCT r.ride_id),
        2
    ) AS review_rate
FROM ride_requests r
LEFT JOIN reviews rv
    ON r.ride_id = rv.ride_id
WHERE r.dropoff_ts IS NOT NULL;
