/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name, membercost
FROM  `Facilities` 
WHERE membercost = 0.0

"""
Badminton Court, table tennis, Snooker table, and Pool table do not charge a fee to members
"""

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(*) 
FROM Facilities
WHERE membercost = 0

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM  `Facilities` 
WHERE membercost < ( 0.2 * monthlymaintenance ) 

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT * 
FROM  `Facilities` 
WHERE facid <6
AND facid !=0
AND facid !=2
AND facid !=3
AND facid !=4

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, 
	monthlymaintenance,
	CASE WHEN monthlymaintenance >= 100 then 'expensive'
	WHEN monthlymaintenance < 99.99 then 'cheap' END AS label
FROM `Facilities` 

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT surname, firstname, MAX( joindate ) AS maxjoindate
FROM  `Members`


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT Facilities.name, Members.surname, Members.firstname
FROM Bookings
JOIN Members
ON Bookings.memid = Members.memid
JOIN Facilities
ON Bookings.facid = Facilities.facid
WHERE Facilities.facid = 0 OR Facilities.facid = 1
group by Members.surname, Members.firstname

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT  concat(Members.firstname, " ", Members.surname) as Guest_Name, Bookings.starttime, Facilities.guestcost, Facilities.membercost,  Facilities.name
FROM Bookings
JOIN Members
ON Bookings.memid = Members.memid
JOIN Facilities
ON Bookings.facid = Facilities.facid
WHERE starttime LIKE  '2012-09-14%' AND Facilities.guestcost > 30 OR Facilities.membercost > 30
ORDER BY Facilities.guestcost DESC

/* Q9: This time, produce the same result as in Q8, but using a subquery. */


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT 
	COUNT(CASE WHEN F.facid=0 AND B.memid = 0 THEN 1 ELSE NULL END) * 25 + COUNT(CASE WHEN F.facid=0 AND B.memid != 0 THEN 1 ELSE NULL END) * 5 AS Fac0_rev,
	COUNT(CASE WHEN F.facid=1 AND B.memid = 0 THEN 1 ELSE NULL END) * 25 + COUNT(CASE WHEN F.facid=1 AND B.memid != 0 THEN 1 ELSE NULL END) * 5 AS Fac1_rev,
	COUNT(CASE WHEN F.facid=2 AND B.memid = 0 THEN 1 ELSE NULL END) * 15.5 + COUNT(CASE WHEN F.facid=2 AND B.memid != 0 THEN 1 ELSE NULL END) * 0 AS Fac2_rev,
	COUNT(CASE WHEN F.facid=3 AND B.memid = 0 THEN 1 ELSE NULL END) * 5 + COUNT(CASE WHEN F.facid=3 AND B.memid != 0 THEN 1 ELSE NULL END) * 0 AS Fac3_rev,
	COUNT(CASE WHEN F.facid=4 AND B.memid = 0 THEN 1 ELSE NULL END) * 80 + COUNT(CASE WHEN F.facid=4 AND B.memid != 0 THEN 1 ELSE NULL END) * 9.9 AS Fac4_rev,
	COUNT(CASE WHEN F.facid=5 AND B.memid = 0 THEN 1 ELSE NULL END) * 80 + COUNT(CASE WHEN F.facid=5 AND B.memid != 0 THEN 1 ELSE NULL END) * 9.9 AS Fac5_rev,
	COUNT(CASE WHEN F.facid=6 AND B.memid = 0 THEN 1 ELSE NULL END) * 17.5 + COUNT(CASE WHEN F.facid=6 AND B.memid != 0 THEN 1 ELSE NULL END) * 3.5 AS Fac6_rev,
	COUNT(CASE WHEN F.facid=7 AND B.memid = 0 THEN 1 ELSE NULL END) * 5 + COUNT(CASE WHEN F.facid=7 AND B.memid != 0 THEN 1 ELSE NULL END) * 0 AS Fac7_rev,
	COUNT(CASE WHEN F.facid=8 AND B.memid = 0 THEN 1 ELSE NULL END) * 5 + COUNT(CASE WHEN F.facid=8 AND B.memid != 0 THEN 1 ELSE NULL END) * 0 AS Fac8_rev
FROM Bookings B
JOIN Facilities F
ON B.facid = F.facid
""" WHERE Fac_rev < 1000  ???  """

/*
assume that we have a table fac_rev with 2 columns: facility and revenue.
Select
	facility, revenue
from fac_rev
where revenue < 1000
sort by revenue

But how do I get here?
*/



