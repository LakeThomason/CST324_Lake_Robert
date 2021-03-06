CREATE VIEW Profiles_Simple as
Select ProfileName, MathDifficultyLevel, ReadingDifficultyLevel, SubjectFilter
From CST324_Lake_Robert.Profiles;

create view animals_view as
select p.ProfileID, ProfileName, Sound, Images
from CST324_Lake_Robert.Profiles p
join CST324_Lake_Robert.ProfileAnimals pa
on p.ProfileID = pa.ProfileID
join CST324_Lake_Robert.Animals a
on a.AnimalID = pa.AnimalID
join CST324_Lake_Robert.Images i
on i.ImageID = a.ImageID
join CST324_Lake_Robert.Sounds s
on s.SoundID = a.SoundID;

create view names_view as
select p.ProfileName, u.Username
from CST324_Lake_Robert.Profiles p
join CST324_Lake_Robert.Users u 
on p.UserID = u.UserID;

create view minigame_Media_view
select MiniGameID, MiniGameName, MiniGameMedia, GameCategoryName
from CST324_Lake_Robert.MiniGames m
join CST324_Lake_Robert.GameCategories g
on m.MiniGameCategoryID = g.MinigameCategoryID
join CST324_Lake_Robert.MiniGameMedia mm
on m.MiniGameID = mm.MiniGameID;