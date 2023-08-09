--Cleanig the Data
Select *
From [GD Analytics].[dbo].[dailyActivity]

-- Finding Nulls and clearing or filling them in if information is available
select *
From [GD Analytics].[dbo].[dailyActivity]
Where TotalDistance is null

--Creating a proper fromat for the Activity Date as "New Activity Date"

Select ActivityDate Convert(Date,ActivityDate)
From [GD Analytics].[dbo].[dailyActivity]

Update [GD Analytics].[dbo].[dailyActivity]
set ActivityDate = Convert(Date,ActivityDate)

Alter Table [GD Analytics].[dbo].[dailyActivity]
Add NewActivitydate = Convert(Date,ActivityDate)

--Combining very active minutes and Faily active minutes as Active minutes 


Select Veryactiveminutes, FairlyActiveMinutes,
Veryactiveminutes + FairlyActiveMinutes As ActivityMins
From [GD Analytics].[dbo].[dailyActivity] 

-- Creating a new colum of Combined activity minutes
Select *
From [GD Analytics].[dbo].[dailyActivity]
--Adding a new Colum

Alter Table [GD Analytics].[dbo].[dailyActivity]
Add ActivityMins Varchar (50) Null 

-- Updating new Colum
Update [GD Analytics].[dbo].[dailyActivity]
set ActivityMins = Veryactiveminutes + FairlyActiveMinutes

--Combinging VeryActive Distance and ModeratelyActive Distance
Alter Table [GD Analytics].[dbo].[dailyActivity]
Add Active_Distance Varchar (50) Null 

Update [GD Analytics].[dbo].[dailyActivity]
set Active_Distance = VeryactiveDistance + ModeratelyActiveDistance

-- Combining all the minutes to find how many minutes in the day customers use the tracker
--Adding a column
Alter Table [GD Analytics].[dbo].[dailyActivity]
Add TotalUsageMins Varchar (50) Null 

--Updating the column

Update [GD Analytics].[dbo].[dailyActivity]
set TotalUsageMins = VeryactiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes

Select Veryactiveminutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes,
Veryactiveminutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes As TotalUsageMins
From [GD Analytics].[dbo].[dailyActivity] 
------------------------------------------------------

Select *
From [GD Analytics].[dbo].[dailyActivity]

Select Distinct ID,NewActivitydate,Totalsteps,Active_Distance,Activitymins
From [GD Analytics].[dbo].[dailyActivity]
Order By Totalsteps

