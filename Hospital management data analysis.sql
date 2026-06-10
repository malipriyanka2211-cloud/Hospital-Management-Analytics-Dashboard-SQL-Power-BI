Create database hospital;

use hospital;

select * from [dbo].[Hospital_Management];

-- Check Total Records
select count(*) as total_records
from hospital_management;

-- Check Duplicate Records
select patientid,
       count(*) as duplicate_count
from hospital_management
group by patientid
having count(*) > 1;


-- Check Null Values
select count(*) as null_count
from hospital_management
where insuranceprovider is null;

-- Percentage of NULL values
select
    count(*) * 100.0 / (select count(*) from hospital_management) as null_percentage
from hospital_management
where insuranceprovider is null;

-- Replace NULL with 'No Insurance' (for analysis only)
update hospital_management
set insuranceprovider = 'No Insurance'
where insuranceprovider is null;



-- Remove Extra Spaces
update hospital_management
set patientname = trim(patientname),
    doctorname = trim(doctorname),
    city = trim(city),
    state = trim(state);

-- Total Patients
select count(*) as total_patients
from hospital_management;

-- Gender Distribution
select gender,
       count(*) as total_patients
from hospital_management
group by gender;

--Average Patient Age
select round(avg(age),2) as average_age
from hospital_management;

-- Patients by state
select state,
       count(*) as total_patients
from hospital_management
group by state
order by total_patients desc;

-- Top 10 cities by patients
select top 10
       city,
       count(*) as patient_count
from hospital_management
group by city
order by patient_count desc;

-- Top doctors by patients handled
select top 10
       doctorname,
       count(*) as total_patients
from hospital_management
group by doctorname
order by total_patients desc;

-- Top 10 revenue generating doctors
select top 10
       doctorname,
       sum(totalbillamount) as revenue
from hospital_management
group by doctorname
order by revenue desc;

--Top 5 diseases with highest revenue
select top 5
       disease,
       sum(totalbillamount) as revenue
from hospital_management
group by disease
order by revenue desc;

-- Patients with highest bills
select top 10
       patientname,
       disease,
       totalbillamount
from hospital_management
order by totalbillamount desc;

-- Average feedback by department
select department,
       round(avg(feedbackrating),2) as avg_rating
from hospital_management
group by department
order by avg_rating desc;

-- Department wise patients
select department,
       count(*) as total_patients
from hospital_management
group by department
order by total_patients desc;

-- Most common diseases
select disease,
       count(*) as total_cases
from hospital_management
group by disease
order by total_cases desc;

-- Total pending amount
select sum(pendingamount) as total_pending_amount
from hospital_management;

-- Insurance provider analysis
select insuranceprovider,
       count(*) as patient_count,
       sum(totalbillamount) as revenue
from hospital_management
group by insuranceprovider
order by revenue desc;

-- Revenue by Department
select department,
       sum(totalbillamount) as revenue
from hospital_management
group by department
order by revenue desc;

-- Revenue by Disease
select disease,
       sum(totalbillamount) as revenue
from hospital_management
group by disease
order by revenue desc;

-- Revenue by Payment Mode
select paymentmode,
       sum(totalbillamount) as revenue
from hospital_management
group by paymentmode
order by revenue desc;

-- Insurance Provider Analysis
select insuranceprovider,
       count(*) as patients,
       sum(totalbillamount) as revenue
from hospital_management
group by insuranceprovider
order by revenue desc;

-- Doctor Rating Analysis
select doctorname,
       round(avg(feedbackrating),2) as avg_rating
from hospital_management
group by doctorname
order by avg_rating desc;

-- Monthly Revenue Trend
select month(admissiondate) as month_no,
       sum(totalbillamount) as revenue
from hospital_management
group by month(admissiondate)
order by month_no;

-- Revenue by room type
select roomtype,
       sum(totalbillamount) as revenue
from hospital_management
group by roomtype
order by revenue desc;

-- Patients with pending payments
select count(*) as pending_payment_patients
from hospital_management
where pendingamount > 0;

-- Surgery Analysis
select surgeryrequired,
       count(*) as total_cases
from hospital_management
group by surgeryrequired;

-- Age Group Analysis
select
    case
        when age < 18 then 'children'
        when age between 18 and 35 then 'young adults'
        when age between 36 and 60 then 'adults'
        else 'senior citizens'
    end as age_group,
    count(*) as total_patients
from hospital_management
group by
    case
        when age < 18 then 'children'
        when age between 18 and 35 then 'young adults'
        when age between 36 and 60 then 'adults'
        else 'senior citizens'
    end;

    -- Patients admitted each month
select month(admissiondate) as month_no,
       count(*) as total_patients
from hospital_management
group by month(admissiondate)
order by month_no;

-- Rank doctors by revenue
select
    doctorname,
    sum(totalbillamount) as revenue,
    rank() over(order by sum(totalbillamount) desc) as revenue_rank
from hospital_management
group by doctorname;






