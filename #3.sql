SELECT
		 c."Patient ID",
		 c."First Owner Assigned",
		 c."First Owner Assigned Date",
		 COUNT(st."Id") AS "Total Records",
         
		 ROUND(SUM(CASE WHEN st."Status" = 'NR' THEN 1 ELSE 0 END) / 3.0, 2) AS "Total NR Count (Divided)",
         
		 MIN(CASE
				 WHEN st."Status"  = 'NR' THEN st."Call Date and Time"
			 END) AS "First NR Time",
		 MAX(CASE
				 WHEN st."Status"  = 'NR' THEN st."Call Date and Time"
			 END) AS "Last NR Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Virgin Lead' THEN st."Call Date and Time"
			 END) AS "Virgin Lead Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Waiting For Details' THEN st."Call Date and Time"
			 END) AS "Waiting Details Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Waiting For Diagnosis' THEN st."Call Date and Time"
			 END) AS "Waiting Diagnosis Time",
		 MIN(CASE
				 WHEN st."Status"  = 'More Details Needed' THEN st."Call Date and Time"
			 END) AS "More Details Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Negotiation' THEN st."Call Date and Time"
			 END) AS "Negotiation Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Deposit Received' THEN st."Call Date and Time"
			 END) AS "Deposit Time",
		 MIN(CASE
				 WHEN st."Status"  = 'Pre-Sold' THEN st."Call Date and Time"
			 END) AS "Pre-Sold Time"
FROM  "Contacts" c
LEFT JOIN "Sales Tracking" st ON st."Parent ID"  = c."Id"
	 AND	st."Sales Name"  = c."First Owner Assigned"  
WHERE	 c."First Owner Assigned"  IS NOT NULL
GROUP BY c."Patient ID",
	 c."First Owner Assigned",
	  c."First Owner Assigned Date" 
ORDER BY c."First Owner Assigned Date" DESC 
