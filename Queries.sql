# Task 1: Display the states, gender affected and the confirmed cases in their respective states where confirmed cases are more than 100.

select distinct d.State, d.Gender, s.Confirmed
from death_and_recovery d join statewisedata s
on d.State = s.State_UT
where s.Confirmed>100;


# Task 2: Which states have collected more than 1000 samples in a day? Provide the serial number, state name, and the total number of samples tested for each state, using data from the 'icmrtestingdata' and 'statewisedata' tables.

select i.sno, s.State_UT, i.TotalSamplesTested
from icmrtestingdata i join statewisedata s
on i.sno = s.sno
where i.TotalSamplesTested>1000;


# Task 3: Display the patient status in each state from the death_and_recovery table

select d1.Patient_status AS Patient_status, d2.City AS City, d1.Age AS Age
from death_and_recovery AS d1
join (
select State, City, Age
from death_and_recovery
) AS d2 ON d1.State = d2.State
order by d1.State ASC, d2.Age ASC, d1.City DESC;


# Task 4: Display the hospital beds along with their location where patients have recovered from covid-19 and those beds are made available to the needy patients waiting in the queue to get admitted.

select d.Patient_status, d.City, d.State, h.Beds_Available
from death_and_recovery d inner join hospitalbeds h
on d.State = h.State_UT
WHERE d.Patient_Status = 'Recovered';


# Task 5: Display the total number of people in Assam who have recovered.

select count(*)
from death_and_recovery
where Patient_status='Recovered' and State="Assam";


#Task 6: Show the state, hospitals and beds available where population beds and hospitals available are more than 1000.

select State_UT, Hospitals_Available, Beds_Available
from hospitalbeds
where Hospitals_Available>1000 and Population_beds>1000;


# Task 7: Show states where active cases are less than 50

select State_UT
from statewisedata
where Active<50;


# Task 8: Which dates are associated with the availability of beds, as captured in the 'datewisepatients' and 'hospitalbeds' tables?

SELECT DISTINCT dwp.Date, hb.Beds_Available
FROM datewisepatients dwp JOIN hospitalbeds hb 
WHERE hb.Beds_Available > 0;


# Task 9: Show the details of the number of samples tested across each timestamp

select UpdatedTimeStamp, TotalSamplesTested
from icmrtestingdata;


# Task 10: Display the number of males and females who have recovered

select Gender, count(*)
from death_and_recovery
where Patient_status = 'Recovered'
group by Gender;


# Task 11: List the states where the population is greater than the number of beds available in descending order of serial number

select State_UT, Beds_Available
from hospitalbeds
where Population_beds > Beds_Available
order by sno DESC;


# Task 12: What is the total number of samples tested, total number of positive cases, and the difference between the total samples tested and total positive cases in the 'icmrtestingdata' table?

select TotalSamplesTested, TotalPositiveCases, (TotalSamplesTested - TotalPositiveCases) as difference
from icmrtestingdata;


# Task 13: Find the number of hospital beds available in each state

select h1.Beds_Available, h2.State_UT
from hospitalbeds h1 JOIN hospitalbeds h2
on h1.sno = h2.sno;


# Task 14:  Display the total number of beds available in Tamil Nadu

select Beds_Available from hospitalbeds where State_UT='Tamil Nadu';


# Task 15: Display the total number of beds available in India.

select SUM(Beds_Available) from hospitalbeds;


# Task 16: What are the distinct values of 'TotalSamplesTested', 'TotalPositiveCases', and 'UpdatedTimeStamp' in the 'icmrtestingdata' table?

select distinct TotalSamplesTested, TotalPositiveCases, UpdatedTimeStamp from icmrtestingdata;


# Task 17: Display the total confirmed cases till 31-March in Maharashtra

Select Maharashtra
from datewisepatients
where Status = "Confirmed" and STR_TO_DATE(Date, '%d-%b-%y') < '2020-03-30';


# Task 18: Calculate the summing distribution of males and females aged 0 to 49 who have been impacted by COVID-19.

Select sum(Male), sum(Female)
from agedistribution_2016_estimates
where
Age_group REGEXP '^[0-9]+-[0-9]+$'
AND CAST(SUBSTRING(Age_group, 1, LOCATE('-', Age_group) - 1) AS UNSIGNED) >= 0 
AND CAST(SUBSTRING(Age_group, LOCATE('-', Age_group) + 1) AS UNSIGNED) <= 49
AND CAST(SUBSTRING(Age_group, LOCATE('-', Age_group) + 1) AS UNSIGNED) != 14;


# Task 19: Find out the recovery rate among the states and display it along with the names of the states and the number of recovered & active cases.

select Recovered, Active, State_UT, Recovered*100/Active
from statewisedata
group by State_UT;


# Task 20: Display the states along with the ratio of Beds available against the total population beds

select State_UT, Beds_Available, Population_beds, Beds_Available/Population_beds
from hospitalbeds;


# Task 21: What are the different patient statuses and the corresponding cities recorded in the 'death_and_recovery' table, after joining it with the 'statewisedata' table based on the matching State_UT values?

select distinct d.Patient_status, d.City
from death_and_recovery d join statewisedata s
on d.State = s.State_UT
where d.Age in (Select distinct Age from death_and_recovery);