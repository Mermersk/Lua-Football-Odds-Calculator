print("Please write in: home team, away team, number of teams in the league")
hometeam = io.read()
awayteam = io.read()
--fjoldi_lida = io.read()
fjoldi_lida = 18

local columns_selector = {1, 2, 3, 4, 5, 6}
fjoldi_lida = fjoldi_lida - 1    --Fjoldi lida og columns selector gilda um bæði töflurnar
-- -1 við fjoldi lida þar sem við byrjum á 0

--Hlaða inn Home töfluna
h_tafla = {} --Hometafla

--Kóði til að fjarlægja spesial characters
--[[
new = ""
str = "Hallo hér öll ŃuneŚ"
for i = 1, #str do  --Kóði til að fjarlægja spesial tákn
  swiss = string.byte(str, i) --Breyti hverjum bókstaf i unicode tölu
  print(swiss)
  if swiss < 123 then --Normal stafróf i unicode er frá 0 uppi sirka 123
    unicode_letter = string.char(swiss) --Breyti unicode tölunni i staf aftur en bara ef unicode gildið er minni en 127, þar með tek ég bara inn normal stafi
    new = new .. unicode_letter --Bý til nýan streng án spés stöfunum.
  end
end
print(new)
]]
str = "Hallo hér öll ŃuneŚ"
print(string.match(str , "%W"))
for line in io.lines("hometable.txt") do
  for tod in line:gmatch("[ .`%a]+") do --"[-.%d]+" %d er tala, . þýðit taka in kommur lika, "-" þýðir taka inn þetta merki lika
    --if tod:match("%W") == nil then
      --tod =
    table.insert(h_tafla, tod)
    --print(tod)
   end
   for num in line:gmatch("[-%d]+") do
     table.insert(h_tafla, num)
   end
end
new = ""
for i = 1, #h_tafla do
  for v = 1, #h_tafla[i] do
    --swiss = string.byte(h_tafla[i], v)
    --if swiss < 123 then
      --string.sub()
    --swiss_one_letter = string.char(swiss)
    --if swiss_one_letter == "%w" then
      --print(swiss_one_letter)
      --string.gsub(swiss_one_letter, swiss_one_letter, "t")
      --unicode_letter = string.char(swiss)
      --h_tafla[i] = h_tafla[i] .. new
    --end
  end
end
print(h_tafla[2])
h_pos = {}  --Position
h_team_name = {}
h_gp = {}  --Games played
h_wins = {}
h_draws = {}
h_loss = {}

for t = 0, fjoldi_lida do
  table.insert(h_pos, h_tafla[columns_selector[1]+(10*t)])
  table.insert(h_team_name, h_tafla[columns_selector[2]+(10*t)])
  table.insert(h_gp, h_tafla[columns_selector[3]+(10*t)])
  table.insert(h_wins, h_tafla[columns_selector[4]+(10*t)])
  table.insert(h_draws, h_tafla[columns_selector[5]+(10*t)])
  table.insert(h_loss, h_tafla[columns_selector[6]+(10*t)])
end


-----------Halað inn away töfluna

a_tafla = {} --Awaytafla

for line2 in io.lines("awaytable.txt") do
  for tod2 in line2:gmatch("[ .`%a]+") do --"[-.%d]+" %d er tala, . þýðit taka in kommur lika, "-" þýðir taka inn þetta merki lika
    table.insert(a_tafla, tod2)
   end
   for num2 in line2:gmatch("[-%d]+") do
     table.insert(a_tafla, num2)
   end
end

a_pos = {}  --Position
a_team_name = {}
a_gp = {}  --Games played
a_wins = {}
a_draws = {}
a_loss = {}


for t = 0, fjoldi_lida do
  table.insert(a_pos, a_tafla[columns_selector[1]+(10*t)])
  table.insert(a_team_name, a_tafla[columns_selector[2]+(10*t)])
  table.insert(a_gp, a_tafla[columns_selector[3]+(10*t)])
  table.insert(a_wins, a_tafla[columns_selector[4]+(10*t)])
  table.insert(a_draws, a_tafla[columns_selector[5]+(10*t)])
  table.insert(a_loss, a_tafla[columns_selector[6]+(10*t)])
end



for lykill, gildi in pairs(a_loss) do
  --print(gildi)
end

----------------------Matches flokkurinn

matches = {}
for line3 in io.lines("matches.txt") do
  for tod3 in line3:gmatch("[ .`%a]+-[ .`%a]+") do  --i gmatch: Tekur inn: string - string. string er eitt orð og getur innihaldið "." og "`", + stenfur fyrir allt orðið
      table.insert(matches, tod3)
    end
end
for i = 1, #matches do
  for lykill, gildi in pairs(matches) do
    if gildi == " - " then --Eyða út öllum space-bilum
      table.remove(matches, lykill)
    end
  end
end

for lykill, gildi in pairs(matches) do
  --print(gildi)
end


-- Hlaða inn scores
scores = {}
for line4 in io.lines("scores.txt") do
  for tod4 in line4:gmatch("[%d]+") do
      table.insert(scores, tod4)
    end
end

for i = 1, #scores do
  --print(scores[i])
end

-- Reikna út past matches með input frá home/away team efst uppi i forritinu
home_team_all_matches = {}

for lykill, gildi in pairs(matches) do
  if string.find(gildi, hometeam) ~= nil  then --String.find gefur tilbaka númer ef strengur finnst og nil ef ekkert finnst
    table.insert(home_team_all_matches, gildi)
    table.insert(home_team_all_matches, scores[(lykill*2)-1])--Finnur scorið hjá hometeam
    table.insert(home_team_all_matches, scores[lykill*2])-- Hér finnur hann scorið hjá awayteam!
  end

end


--print(#scores)
--print(#matches)
--print(scores[6])
--print(matches[7])

motherji_at_home = {}

motherji_at_away = {}
--print(string.match(stf, "Olbia")) --String.match finnur oðið og gefur það tilbaka, string find gerir það sama en gefur tilbaka 2 tölur um hvar orðið er i strengnum

for lykill, gildi in pairs(home_team_all_matches) do


  --print(string.match(gildi, "[%a ]+"))
  fu = string.match(gildi, "[%a ]+")  --Finnur leiki þar sem hometeam er away
  table.insert(motherji_at_home, fu)


  bil = string.find(gildi, "-")
  --print(bil)

  su = string.match(gildi, "[%a ]+", bil) --finnur leiki þar sem hometeam er home
  table.insert(motherji_at_away, su)
  --print(su)

end

for lykill, gildi in pairs(motherji_at_home) do  --Þarf að gera þetta tvisvar fyrir hvor töflu, fjarlægir ekki ef það eru 2 heima/away leikir i röð
  if string.find(gildi, hometeam) ~= nil then  --Eitthvað með hvernig table.remove fúnkar
    table.remove(motherji_at_home, lykill) --1. umferð
  end
end

for lykill, gildi in pairs(motherji_at_home) do --2.umferð
  if string.find(gildi, hometeam) ~= nil then
    table.remove(motherji_at_home, lykill)
  end
end

for lykill, gildi in pairs(motherji_at_away) do --1. umferð
  if string.find(gildi, hometeam) ~= nil then
    table.remove(motherji_at_away, lykill)
  end
end

for lykill, gildi in pairs(motherji_at_away) do  --2.umferð
  if string.find(gildi, hometeam) ~= nil then
    table.remove(motherji_at_away, lykill)
  end
end


 --Hér er kóði til að finna position af mótherja i töflunni
for i = 1, #motherji_at_home do
  for lykill, gildi in pairs(h_team_name) do
    find_pos = string.match(motherji_at_home[i], gildi)
    --print(find_pos)
    if find_pos ~= nil then
      table.insert(motherji_at_home, lykill)
    end
  end
end

for i = 1, #motherji_at_away do
  for lykill, gildi in pairs(a_team_name) do
    find_pos2 = string.match(motherji_at_away[i], gildi)
    --print(find_pos)
    if find_pos2 ~= nil then
      table.insert(motherji_at_away, lykill)
    end
  end
end

opponent_table_pos = {}
for i = 1, #motherji_at_away do
  if string.match(motherji_at_away[i], "%d") then  --I motherji_at_away töflunni eru nöfn liðanna og svo sæti þeirra i away-töflunni
    table.insert(opponent_table_pos, motherji_at_away[i])
  end
end
for lykill, gildi in pairs(opponent_table_pos) do
  print(gildi)
end
--opponent_table_pos inniheldur sæti liðanna sem kept hefur verið. Hér er það sæti þar sem hometeam er home og þar með sætin hjá opponent i away töflunni
--motherji_at_home taflan inniheldur nöfn liðanna sem hometeam hefur spilað gegn á heimavelli
--motherji_at_home_results taflan inniheldur úrslit þessara leika i forminu "D" fyrir draw eða L fyrir loss og W fyrir win

for i = 1, #motherji_at_home do
  print(motherji_at_home[i])
end
for i = 1, #motherji_at_away do
  print(motherji_at_away[i])
end

motherji_at_home_results = {}

htami = 1  --htami = home team away matches index. Finnur alla leiki þar sem hometeam er away
for i = 1, #home_team_all_matches do
if htami <= #motherji_at_away/2 then --Þessi kóði er hér svo að það indexar rétta ammount af leikjum, geri motherji_at_away/2 til að fá rétta tölu. motherji_at_away inniheldur liðsnöfn liðanna sem eru away og staðsetning þeirra í away töflunni
  if string.match(home_team_all_matches[i], motherji_at_away[htami]) then
    print(home_team_all_matches[i])
    print(home_team_all_matches[i+1])
    print(home_team_all_matches[i+2])
    if home_team_all_matches[i+1] == home_team_all_matches[i+2] then
      print("Draw")
      table.insert(motherji_at_home_results, "D")
    end
    if home_team_all_matches[i+1] > home_team_all_matches[i+2] then
      print("Home side wins!")
      table.insert(motherji_at_home_results, "W")
    end
    if home_team_all_matches[i+1] < home_team_all_matches[i+2] then
      print("Away side wins!")
      table.insert(motherji_at_home_results, "L")
    end
    htami = htami + 1
  end
end
end
for lykill, gildi in pairs(motherji_at_home_results) do
  print(gildi)
end
for lykill, gildi in pairs(h_team_name) do
  if string.match(gildi, hometeam) then
    home_team_games_played = h_gp[lykill]
    home_team_wins = h_wins[lykill]  --Finnur home matches played so far hjá hometeam
    home_team_draws = h_draws[lykill]
    home_team_losses = h_loss[lykill]
  end
end

home_team_wins_multiplier = 0
home_team_draws_multiplier = 0
home_team_losses_multiplier = 0
for i = 1, #motherji_at_home_results do
  if motherji_at_home_results[i] == "W" then
    home_team_wins_multiplier = home_team_wins_multiplier + (opponent_table_pos[i]+fjoldi_lida) - (opponent_table_pos[i]*2)+2 --+2 til að offsetja eitthverja skekkju
  end
  if motherji_at_home_results[i] == "D" then
    home_team_draws_multiplier = home_team_draws_multiplier + (opponent_table_pos[i]+fjoldi_lida) - (opponent_table_pos[i]*2)+2 --+2 til að offsetja eitthverja skekkju
  end
  if motherji_at_home_results[i] == "L" then
    home_team_losses_multiplier = home_team_losses_multiplier + opponent_table_pos[i]
  end
end
print(home_team_wins_multiplier .. "  " .. home_team_draws_multiplier .. "   " .. home_team_losses_multiplier)
home_team_score = (home_team_wins * home_team_wins_multiplier) + (home_team_draws * home_team_draws_multiplier) - (home_team_losses * home_team_losses_multiplier)

local highest_multiplier_home_team = 0  --Highest multiplier táknar lélegasta/besta multiplier factor sem finnst.
--Finnst með því númerið a_played og fara niður töfluna. Svo t.d. i donsku 1 töflunni er a_played = 8 og það
--eru 12 lið i töflunni, þá er multiplier = lélegasta position til hæsta á meðan við erum undir tölunni 8
--Svo þá er það: 12+11+10+9+8+7+6+5 = eitthver tala. Þetta eru 8 tölur, sami fjöldi og spilaðir hafa verið so far

for i = 1, #a_pos do
  if #a_pos - home_team_games_played < i  then
    highest_multiplier_home_team = highest_multiplier_home_team + a_pos[i] --Setur seinustu position i töflunni saman i eina tölu, gerir þetta svo oft sem gildi a_played er
  end
  --if #h_pos - b_played < i  then
    --highest_multiplier_b = highest_multiplier_b + h_pos[i]
  --end
end


worst_score_home_team = 0 + 0 - (home_team_games_played*highest_multiplier_home_team)
best_score_home_team = (home_team_games_played*highest_multiplier_home_team) + 0 - 0

-------- Prósentureikningur
--Team A
home_team_prosent = 0
tak_a = 0
prosent_1_home = best_score_home_team / 50

repeat
  tak_a = tak_a + prosent_1_home
  home_team_prosent = home_team_prosent + 1
until tak_a >= math.abs(home_team_score)

if home_team_score < 0 then
  home_team_prosent = 50 - home_team_prosent
  else
  home_team_prosent = home_team_prosent + 50
end


--[[
print(best_score_home_team .. "  " .. worst_score_home_team)
print(home_team_score)
print(home_team_games_played)
print(home_team_wins)
print(home_team_draws)
print(home_team_losses)
print(home_team_prosent .. "%")
]]





-----------------------------LIÐ AWAY BYRJAR HÉR copy paste en breytt nöfn á ollum breytumm........



  away_team_all_matches = {}

  for lykill, gildi in pairs(matches) do
    if string.find(gildi, awayteam) ~= nil  then --String.find gefur tilbaka númer ef strengur finnst og nil ef ekkert finnst
      table.insert(away_team_all_matches, gildi)
      table.insert(away_team_all_matches, scores[(lykill*2)-1])--Finnur scorið hjá hometeam
      table.insert(away_team_all_matches, scores[lykill*2])-- Hér finnur hann scorið hjá awayteam!
    end

  end

  for lykill, gildi in pairs(away_team_all_matches) do
    print(gildi)
  end



  away_team_away_matches = {}
  away_team_home_matches = {}
  --print(string.match(stf, "Olbia")) --String.match finnur oðið og gefur það tilbaka, string find gerir það sama en gefur tilbaka 2 tölur um hvar orðið er i strengnum

  for lykill, gildi in pairs(away_team_all_matches) do


    --print(string.match(gildi, "[%a ]+"))
    fu2 = string.match(gildi, "[%a ]+")  --Finnur leiki þar sem awayteam er away
    table.insert(away_team_away_matches, fu2)
    --print(fu2)

    bil2 = string.find(gildi, "-")
    --print(bil)

    su2 = string.match(gildi, "[%a ]+", bil2) --finnur leiki þar sem awayteam er home
    table.insert(away_team_home_matches, su2)
    --print(su2)

  end

  for lykill, gildi in pairs(away_team_away_matches) do  --Þarf að gera þetta tvisvar fyrir hvor töflu, fjarlægir ekki ef það eru 2 heima/away leikir i röð
    if string.find(gildi, awayteam) ~= nil then  --Eitthvað með hvernig table.remove fúnkar
      table.remove(away_team_away_matches, lykill) --1. umferð
    end
  end

  for lykill, gildi in pairs(away_team_away_matches) do --2.umferð
    if string.find(gildi, awayteam) ~= nil then
      table.remove(away_team_away_matches, lykill)
    end
  end

  for lykill, gildi in pairs(away_team_home_matches) do --1. umferð
    if string.find(gildi, awayteam) ~= nil then
      table.remove(away_team_home_matches, lykill)
    end
  end

  for lykill, gildi in pairs(away_team_home_matches) do  --2.umferð
    if string.find(gildi, awayteam) ~= nil then
      table.remove(away_team_home_matches, lykill)
    end
  end


   --Hér er kóði til að finna position af mótherja i töflunni
  for i = 1, #away_team_away_matches do
    for lykill, gildi in pairs(h_team_name) do
      find_pos3 = string.match(away_team_away_matches[i], gildi)
      --print(find_pos)
      if find_pos3 ~= nil then
        table.insert(away_team_away_matches, lykill)
      end
    end
  end

  for i = 1, #away_team_home_matches do
    for lykill, gildi in pairs(a_team_name) do
      find_pos4 = string.match(away_team_home_matches[i], gildi)
      --print(find_pos)
      if find_pos4 ~= nil then
        table.insert(away_team_home_matches, lykill)
      end
    end
  end

  opponent_table_pos2 = {}
  for i = 1, #away_team_away_matches do
    if string.match(away_team_away_matches[i], "%d") then  --I away_team_away_matches töflunni eru nöfn liðanna og svo sæti þeirra i away-töflunni
        table.insert(opponent_table_pos2, away_team_away_matches[i])
    end
  end
  for lykill, gildi in pairs(opponent_table_pos2) do
    print(gildi)
  end
  --opponent_table_pos2 inniheldur sæti liðanna sem kept hefur verið. Hér er það sæti þar sem hometeam er home og þar með sætin hjá opponent i away töflunni
  --away_team_away_matches taflan inniheldur nöfn liðanna sem hometeam hefur spilað gegn á heimavelli
  --away_team_away_matches_results taflan inniheldur úrslit þessara leika i forminu "D" fyrir draw eða L fyrir loss og W fyrir win

  for i = 1, #away_team_away_matches do
    print(away_team_away_matches[i])
  end
  for i = 1, #away_team_home_matches do
    print(away_team_home_matches[i])
  end

  away_team_away_matches_results = {}

  htami2 = 1  --htami = home team away matches index. Finnur alla leiki þar sem hometeam er away
  for i = 1, #away_team_all_matches do
  if htami2 <= #away_team_away_matches/2 then --Þessi kóði er hér svo að það indexar rétta ammount af leikjum
    if string.match(away_team_all_matches[i], away_team_away_matches[htami2]) then
      print(away_team_all_matches[i])
      print(away_team_all_matches[i+1])
      print(away_team_all_matches[i+2])
      if away_team_all_matches[i+1] == away_team_all_matches[i+2] then

        table.insert(away_team_away_matches_results, "D")
      end
      if away_team_all_matches[i+1] > away_team_all_matches[i+2] then

        table.insert(away_team_away_matches_results, "L")
      end
      if away_team_all_matches[i+1] < away_team_all_matches[i+2] then

        table.insert(away_team_away_matches_results, "W")
      end

      htami2 = htami2 + 1
    end
  end
  end
  for lykill, gildi in pairs(away_team_away_matches_results) do
    print(gildi)
  end

  if #away_team_away_matches_results > #away_team_away_matches/2 then --Plástur. eitthvað með
    --table.remove(away_team_away_matches_results, #away_team_away_matches_results)
  end
  print(#away_team_away_matches_results)


  for lykill, gildi in pairs(a_team_name) do
    if string.match(gildi, awayteam) then
      away_team_games_played = a_gp[lykill]
      away_team_wins = a_wins[lykill]  --Finnur home matches played so far hjá hometeam
      away_team_draws = a_draws[lykill]
      away_team_losses = a_loss[lykill]
    end
  end
  print(opponent_table_pos2[1])
  print(#a_gp)
  away_team_wins_multiplier = 0
  away_team_draws_multiplier = 0
  away_team_losses_multiplier = 0
  for i = 1, #away_team_away_matches_results do
    if away_team_away_matches_results[i] == "W" then
      away_team_wins_multiplier = away_team_wins_multiplier + (opponent_table_pos2[i]+fjoldi_lida) - (opponent_table_pos2[i]*2)+2 --+2 til að offsetja eitthverja skekkju
    end
    if away_team_away_matches_results[i] == "D" then
      away_team_draws_multiplier = away_team_draws_multiplier + (opponent_table_pos2[i]+fjoldi_lida) - (opponent_table_pos2[i]*2)+2 --+2 til að offsetja eitthverja skekkju
    end
    if away_team_away_matches_results[i] == "L" then
      away_team_losses_multiplier = away_team_losses_multiplier + opponent_table_pos2[i]
    end
  end

  print(away_team_wins_multiplier .. "  " .. away_team_draws_multiplier .. "   " .. away_team_losses_multiplier)
  away_team_score = (away_team_wins * away_team_wins_multiplier) + (away_team_draws * away_team_draws_multiplier) - (away_team_losses * away_team_losses_multiplier)
  print(away_team_score)

  local highest_multiplier_away_team = 0  --Highest multiplier táknar lélegasta/besta multiplier factor sem finnst.
  --Finnst með því númerið a_played og fara niður töfluna. Svo t.d. i donsku 1 töflunni er a_played = 8 og það
  --eru 12 lið i töflunni, þá er multiplier = lélegasta position til hæsta á meðan við erum undir tölunni 8
  --Svo þá er það: 12+11+10+9+8+7+6+5 = eitthver tala. Þetta eru 8 tölur, sami fjöldi og spilaðir hafa verið so far

  for i = 1, #h_pos do
    if #h_pos - away_team_games_played < i  then
      highest_multiplier_away_team = highest_multiplier_away_team + h_pos[i] --Setur seinustu position i töflunni saman i eina tölu, gerir þetta svo oft sem gildi a_played er
    end
  end


  worst_score_away_team = 0 + 0 - (away_team_games_played*highest_multiplier_away_team)
  best_score_away_team = (away_team_games_played*highest_multiplier_away_team) + 0 - 0
  print(worst_score_away_team .. " " .. best_score_away_team)

  --Team A
  away_team_prosent = 0
  tak_b = 0
  prosent_1_away = best_score_away_team / 50

  repeat
    tak_b = tak_b + prosent_1_away
    away_team_prosent = away_team_prosent + 1
  until tak_b >= math.abs(away_team_score)

  if away_team_score < 0 then
    away_team_prosent = 50 - away_team_prosent
    else
    away_team_prosent = away_team_prosent + 50
  end


  -- DIfference reikningur

  difference = home_team_prosent - away_team_prosent

  if home_team_prosent > away_team_prosent then
    favorite = hometeam
    else
    favorite = awayteam
  end

  print(hometeam .. " total points: " .. home_team_score .. " Prosent: " .. home_team_prosent .. "%")
  print(awayteam .. " total points: " .. away_team_score .. " Prosent: " .. away_team_prosent .. "%")
  print("There is a difference of " .. math.abs(difference) .. "%" .. " in favor of " .. favorite)



  print("Worst for Home team: " .. worst_score_home_team .. " Best for team A: " .. best_score_home_team)
  print("Worst for Away team: " .. worst_score_away_team.. " Best for team B: " .. best_score_away_team)
  print(highest_multiplier_home_team)
  print(highest_multiplier_away_team)

  --TO Do: Það er eitthvað rangt við hvernig away teamið nær i position af home töflunni, en hinsvegar er allt rétt hjá home teamið með það
  --Það þarf að fixa: það er eitthver feill(serléga hjá awayteam) þegar spilaðir heimalikir og spilaðir away leikir eru ekki sama talan,
  --edit: Sama vandamál með hometeam
