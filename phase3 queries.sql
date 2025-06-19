1. Retrieving customer info along with their active plan name
SELECT c.Name, c.Email, s.PlanName, sub.Status
FROM Customer c
JOIN Subscription sub ON c.CustomerID = sub.CustomerID
JOIN ServicePlan s ON s.PlanID = sub.PlanID
WHERE sub.Status = 'Active';

2. Finding the usage history for each customer including total data and call minutes used
SELECT c.Name, SUM(u.DataUsed) AS TotalDataUsedMB, SUM(u.CallMinutesUsed) AS TotalCallMinutes
FROM Customer c
JOIN Subscription sub ON c.CustomerID = sub.CustomerID
JOIN UsageRecord u ON u.SubscriptionID = sub.SubscriptionID
GROUP BY c.Name;

3. Calculating the billing summary for each customer for January 2024
SELECT c.Name, b.TotalAmount, b.AmountPaid, b.PaymentDate
FROM Customer c
JOIN Subscription sub ON c.CustomerID = sub.CustomerID
JOIN Billing b ON sub.SubscriptionID = b.SubscriptionID
WHERE b.BillingPeriodStart = '2024-01-01';

4. Listing the high-value customers who used more than 4000MB in a session
SELECT DISTINCT c.Name, u.DataUsed
FROM Customer c
JOIN Subscription sub ON c.CustomerID = sub.CustomerID
JOIN UsageRecord u ON sub.SubscriptionID = u.SubscriptionID
WHERE u.DataUsed > 4000;

5. Analyzing the calling patterns: Avg. call minutes by plan type
SELECT s.PlanType, AVG(u.CallMinutesUsed) AS AvgCallMinutes
FROM ServicePlan s
JOIN Subscription sub ON s.PlanID = sub.PlanID
JOIN UsageRecord u ON sub.SubscriptionID = u.SubscriptionID
GROUP BY s.PlanType;

6. Showing the unresolved support tickets with customer details
SELECT c.Name, s.IssueType, s.Description, s.Status
FROM SupportTicket s
JOIN Customer c ON c.CustomerID = s.CustomerID
WHERE s.Status != 'Resolved';

7. Subquery: Customers who have paid more than average bill amount
SELECT c.Name, b.TotalAmount
FROM Customer c
JOIN Subscription sub ON c.CustomerID = sub.CustomerID
JOIN Billing b ON sub.SubscriptionID = b.SubscriptionID
WHERE b.TotalAmount > (
    SELECT AVG(TotalAmount) FROM Billing
);
