select * from 
CST324_Lake_Robert.Profiles as P
join CST324_Lake_Robert.ProfileProgress as PP
on P.ProfileID = PP.ProfileID
join CST324_Lake_Robert.ProfileProgressHistory as PPH
on P.ProfileID = PPH.ProfileID
join CST324_Lake_Robert.ProfileAnimals as PA
on P.ProfileID = PA.ProfileID
join CST324_Lake_Robert.Animals as A
on PA.AnimalID = A.AnimalID
join CST324_Lake_Robert.Users as U
on P.UserID = U.UserID
