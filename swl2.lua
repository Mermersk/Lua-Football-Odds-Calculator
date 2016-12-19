tafla = {}
--Þegar maður kópiar frá soccerway er mikilvægt að nota chrome til að eyða örvunum
for line in io.lines("ita3gb.txt") do
  for tod in line:gmatch("[-%d]+") do --"[-.%d]+" %d er tala, . þýðit taka in kommur lika, "-" þýðir taka inn þetta merki lika
    table.insert(tafla, tod)
    print(tod)
   end
end


--table.remove(tafla, 107+17) --  Aðeins fyrir dönsku 2. deild


maxnumber = 80  --Maxnumber er hæsta einstaka talan sem finnst i töflunni

for i = 1, #tafla do
  for lykill, gildi in ipairs(tafla) do
    if gildi == "-"  then
      table.remove(tafla, lykill)
    end

    --if tonumber(gildi) == nil then
      --table.remove(tafla, lykill)
    --end

    --if tonumber(gildi) > maxnumber then
      --table.remove(tafla, lykill)
    --end

  end
end



for i = 1, #tafla do
  for lykill, gildi in pairs(tafla) do
    if tonumber(gildi) > 50 then
      table.remove(tafla, lykill)
    end
  end
end

for i = 1, #tafla do
  print(tafla[i])
end


hwins = {}  --HOme wins
hdraw = {}
hloss = {}
awins = {}  --Away wins
adraw = {}
aloss = {}

hplayed = {} --Home matches played
aplayed = {} --Away matches played

position  = {}
--print(tafla)
local columns_selector = {9, 10, 11, 15, 16, 17, 8, 14, 1} --columns_selector Velur hvaða tölur i töflunni á að safna saman lóðrétt niður.
for t = 0, 21 do
  --print(tafla[9+(21*t)]) --Hér er columns_selector = 9 því að ég ætla taka bara homewins og setja i sér töflu
  table.insert(hwins, tafla[columns_selector[1]+(21*t)]) --Næ í þr töflur sem þarf fyrir dc() function
  table.insert(hdraw, tafla[columns_selector[2]+(21*t)])
  table.insert(hloss, tafla[columns_selector[3]+(21*t)])

  table.insert(awins, tafla[columns_selector[4]+(21*t)])
  table.insert(adraw, tafla[columns_selector[5]+(21*t)])
  table.insert(aloss, tafla[columns_selector[6]+(21*t)])

  table.insert(hplayed, tafla[columns_selector[7]+(21*t)])
  table.insert(aplayed, tafla[columns_selector[8]+(21*t)])

  table.insert(position, tafla[columns_selector[9]+(21*t)])


end
for i = 1, #hplayed do
  print(hplayed[i])
end


print("type in this order: Position Home team, position away team, Home team win number p-calc, home team draw number p-calc, home team loss number p-calc, away team same as process as home team.")
print("DC is ready for calculation when 8 values are registrered")
local inputFerdig = false
local loopholder
u_input = {} --User input


for i = 1, 100 do --HUndrað bara til að hafa nogu mikið space i töflunni. Taflan sem ég set i verður samt ekki 100 index löng
  if inputFerdig == false then
    loopholder = io.read()
  end
  if #u_input >= 8 then
     inputFerdig = true
     break --break: fer út úr loopuni sem er i gangi og heldur áfram með kóðan fyrir neð loopin sem hann fer út úr
  end
    table.insert(u_input, loopholder) --Setur in input, 2 nofn fyrst og svo töflustaða liðanna sem keppt hefur verið við
  end

for i = 1, #u_input do
  print(u_input[i])
end



a_team = tonumber(u_input[1])
b_team = tonumber(u_input[2])
a_played = tonumber(hplayed[a_team])
b_played = tonumber(aplayed[b_team])
print(a_played)

local highest_multiplier_a = 0  --Highest multiplier táknar lélegasta/besta multiplier factor sem finnst.
--Finnst með því númerið a_played og fara niður töfluna. Svo t.d. i donsku 1 töflunni er a_played = 8 og það
--eru 12 lið i töflunni, þá er multiplier = lélegasta position til hæsta á meðan við erum undir tölunni 8
--Svo þá er það: 12+11+10+9+8+7+6+5 = eitthver tala. Þetta eru 8 tölur, sami fjöldi og spilaðir hafa verið so far
local highest_multiplier_b = 0
for i = 1, #position do
  if #position - a_played < i  then
    highest_multiplier_a = highest_multiplier_a + position[i] --Setur seinustu position i töflunni saman i eina tölu, gerir þetta svo oft sem gildi a_played er
  end
  if #position - b_played < i  then
    highest_multiplier_b = highest_multiplier_b + position[i]
  end
end


a_team_score = (hwins[a_team] * u_input[3]) + (hdraw[a_team] * u_input[4]) - (hloss[a_team] * u_input[5])
b_team_score = (awins[b_team] * u_input[6]) + (adraw[b_team] * u_input[7]) - (aloss[b_team] * u_input[8])

worst_score_a = 0 + 0 - (a_played*highest_multiplier_a)
best_score_a = (a_played*highest_multiplier_a) + 0 - 0
worst_score_b = 0 + 0 - (b_played*highest_multiplier_b)
best_score_b = (b_played*highest_multiplier_b) + 0 - 0

a_team_score = a_team_score / 100
b_team_score = b_team_score / 100

worst_score_a = worst_score_a / 100
best_score_a = best_score_a / 100
worst_score_b = worst_score_b / 100
best_score_b = best_score_b / 100

-------- Prósentureikningur
--Team A
a_team_prosent = 0
tak_a = 0
prosent_1_a = best_score_a / 50

repeat
  tak_a = tak_a + prosent_1_a
  a_team_prosent = a_team_prosent + 1
until tak_a >= math.abs(a_team_score)

if a_team_score < 0 then
  a_team_prosent = 50 - a_team_prosent
  else
  a_team_prosent = a_team_prosent + 50
end
--  Team B
b_team_prosent = 0
tak_b = 0
prosent_1_b = best_score_b / 50

repeat
  tak_b = tak_b + prosent_1_b
  b_team_prosent = b_team_prosent + 1
until tak_b >= math.abs(b_team_score)

if b_team_score < 0 then
  b_team_prosent = 50 - b_team_prosent
  else
  b_team_prosent = b_team_prosent + 50
end
-----Reikna Munin á milli liðanna i prósentum
difference = a_team_prosent - b_team_prosent

if a_team_prosent > b_team_prosent then
  favorite = "Team A"
  else
  favorite = "Team B"
end

print("Team A toal points: " .. a_team_score .. " Prosent: " .. a_team_prosent .. "%")
print("Team B toal points: " .. b_team_score .. " Prosent: " .. b_team_prosent .. "%")
print("There is a difference of " .. math.abs(difference) .. "%" .. " in favor of " .. favorite)



print("Worst for team A: " .. worst_score_a .. " Best for team A: " .. best_score_a)
print("Worst for team B: " .. worst_score_b .. " Best for team B: " .. best_score_b)
print(highest_multiplier_a)
print(highest_multiplier_b)
