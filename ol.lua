
tafla = {}

for line in io.lines("tstats") do

   for num in line:gmatch("[-.%a]+") do --[-.%d]+
      table.insert(tafla, num)
   end

   for tod in line:gmatch("[-.%d]+") do
      table.insert(tafla, tod)
   end
end

for i = 1, #tafla do
  if tafla[i] == "-" then
    table.remove(tafla, i, nil)
  end
  --print(tafla[i])
end
nofn = {"Braunschweig", "Stuttgart", "Heidenheim", "Hannover", "Union", "Kickers", "fortuna", "Dresden", "Nurnberg", "Sandhausen", "Bochum", "Kaiserslautern", "Greuther", "Munchen", "Karlsruher", "Aue", "Bielefeld", "Pauli"}
navn = {}
for i = 1, #tafla, 16 do
  table.insert(navn, {name = tafla[i]})
end
for lykill, gildi in pairs(navn) do
  print(gildi.name)
end

print("Heisann! Welcome to the Bundesliga 2 odds project. Current functions you can try: allStats(), homegoals(), DNB()")
  --table.insert(index, i)  --table.insert(table, position, value)


print(tafla[1+(6*16)])

statMeta = {"Played: ", "Home wins: ", "Home draws: ", "Home losses: ", "Home Goals for: ", "Home goals against: ", "Away wins: ", "Away draw: ", "Away losses", "Away goals for: ", "Away goals against: ", "Total goals for: ", "Total goals against: ", "Goal difference: ", "Points: "}
--print(#statMeta)



function allStats()

  print("What team in Bundesliga 2 would you like to see?")
  print("Write in one of these: ")
  for i = 1, #tafla, 16 do --16 hvert sæti eru liðsnöfnin!
    print(tafla[i])
  end
  teamName = io.read()  --Tekur inn input frá user i terminal

  local teamPosition = -1 --Byrjar á - 1 því að braunschweig byrjar á 0
  local leit = true

  for i = 1, #tafla, 16 do
    if leit == true then
      teamPosition = teamPosition + 1
    end
    if teamName == tafla[i] then  --Ef input finnst i töflunni þá hættir teamPosition að hækka
      leit = false
    end
  end

  if leit == true then --Ef ekkert af liðsnöfnum fannst i töflunni þá er teamPosition 32 og prentar út no valid input i stað töflurnar
    print("That is not a valid input!")
  else
  for i = 1, 16 do
    print(statMeta[i - 1])
    print(tafla[i + (16 * teamPosition)])
  end --Nota math.floor þar sem að það fiksar table position. Kannski er teamPosition tala,tala, ss ekki heil tala
    print("Position in table: " .. math.floor(teamPosition+1))  --Printa þennan hér þar sem "position int table" er ekki i töflunni statMeta
  end -- " .. " tengir saman tvær ólikar breytur. Þessi operator breytir tölunni i string fyrir prentun
end
--allStats(io.read())


function homegoals()
  local biggest = 1
  local tp = -1

  for i = 6, #tafla, 16 do
    if tonumber(tafla[i]) > tonumber(biggest) then
      biggest = tafla[i]
      tp = i
    end
  end
  print("Goals scored at home: " .. biggest)
  print(tafla[tp - 5])  --Prenta hér út nafnið á liðinu með flest heimamörk. Geri -5til þess að fara frá homegoals tölunni til nafn liðsins en það eru 5 sæti!
end
--print(tafla[249])
function DNB()
    local homeGD --HOme team goaldifference
    local awayGD --Away team goaldifference
    local resultWin = 1.3
    local resultDraw = 1.2
    local resultLoss = 0.9
    local increment = 0.22
    local plass = 0

    local loopholder
    plassering = {}
    for i = 1, 11 do
      loopholder = io.read()
      table.insert(plassering, loopholder)
    end
    --for i = 6, #tafla, 16 do
    homeGD = tafla[i]

end

--[[
Frá neðsta sæti til efsta er margföldunarstuðullinn á milli, 1.1 fyrir lægsta uppi 1.5 fyrir hæsta. Hækkar þá um 0.022 fyrir hvert sæti upp. 18: 1.1  17: 1.12  16: 1.144   formúla 1.1+(0.022*18)  Byrjendastuðull+(hækkun per sæti * sæti liðsins i reverse)* stuðull fyrir win/draw/loss

ATH: Þegar ég margfalda tapleik þá svissast röðin i (sæti liðsins i reverse) --reverse dettur þá út. Þetta er gert til að það að tapa á móti liði neðar i deildinni er verra stigalega séð en að tapa á móti toppliðunum

]]






--flokkar fyrir stats
--1. played   played matches so far(home and away)  8
--2. HWins    Home wins   9
--3. HDraw    home draw  10
--4. HLoss    home losses   11
--5. HGoalsFor   Goals scored at home  12
--6. HGoalsAgainst   Goals conceded at home  13
--7. AWins    away wins  14
--8. ADraw    Away draw  15
--9. ALoss    away losses  16
--10. AGoalsFor   Goals scored at away games  17
--11. AGoalsAgainst   Goals conceded at away games   18
--12. TGoalsFor   Total goals home and away scored   19
--13. TGoalsAgainst   Total goals home and away conceded   20
--14. GD   Goal difference  21
--15. PTS Points in the league table  22

-------------------------------Gamall kóði, geymi til minna mig á

--[[for lykill, gildi in pairs(nofn) do
  for i = 1, #tafla do
    --if gildi == tafla[i] then
      --table.insert(tafla, {gildi})
    --end
    --if gildi == "[-.%d]+" then
      --tafla[3][2] = gildi .. gildi
    --end
  end
  --if gildi == "[-.%d]+" then
    --for i = 1, 18 do
      --tafla[i][2] = gildi
    --end
  --end
end

-- a full stærð fyrir minkunn:88
a = 250  --Virkar að fjarlæga elements með því að byrja aftast en ekki fremst, tengt hvernig tableþremove vinnur
--repeat
  --table.remove(tafla, a)

--until(a == 0) -- < i staðinn fyrir == svo að index nr 1 fjarlægist lika!
--for i = 1, #tafla do

-- aa index nr 32 byrjar lidin (fyrsta er braunschweig)
for i = 1, #tafla do
    --print(tafla[i])
end
braun = {
  {navn = tafla[32]},
  {played = tafla[33]},
  {HWins = tafla[34]},
  {HDraw = tafla[35]},
  {HLoss = tafla[36]},
  {HGoalsFor = tafla[37]},
  {HGoalsAgainst = tafla[38]},
  {AWins = tafla[39]},
  {ADraw = tafla[40]},
  {ALoss = tafla[41]},
  {AGoalsFor = tafla[42]},
  {AGoalsAgainst = tafla[43]},
  {TGoalsFor = tafla[44]},
  {TGoalsAgainst = tafla[45]},
  {GD = tafla[46]},
  {PTS = tafla[47]}
}
table.insert(braun, 1, {tafla[48]})
--print(braun[1][1])

for lykill, gildi in pairs(braun) do
  --print(gildi.navn)
    --[[print(gildi.navn)
    print(gildi.played)
    print(gildi.HWins)
    print(gildi.HDraw)
    print(gildi.HLoss)
    print(gildi.HGoalsFor)
    print(gildi.HGoalsAgainst)
    print(gildi.AWins)
    print(gildi.ADraw)
    print(gildi.ALoss)
    print(gildi.AGoalsFor)
    print(gildi.AGoalsAgainst)
    print(gildi.TGoalsFor)
    print(gildi.TGoalsAgainst)
    print(gildi.GD)
    print(gildi.PTS)

end ]]
