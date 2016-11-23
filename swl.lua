tafla = {}

for line in io.lines("por2.txt") do
  for tod in line:gmatch("[-.%d]+") do
      if tod ~= "-" then
        table.insert(tafla, tod)
      end
   end
end


--byrjun á eyði-svæði = 32, endir er 45 eyðisvæði eru = 13 index löng
--20 index per team stats, 13 index langar hrínur sem þarf að eyða
--local switch = true
local modulo1 = 13
local modulo2 = 33
local tp = 1
local tt = 1
    --[[       --(13 + 19)*tp     if i  and i < 13 + 19 + (13*tp) then
for i = 1, #tafla do
  if i%modulo1 == 0 then
    switch = false
    modulo1 = modulo1 + (20*tp)
    tp = tp + 1
  if i%modulo2 == 0 then
    switch = true  --Swith = true þýðir eyða út element, false = ekki eyða element
    modulo2 = modulo2 + (12*tt)
    tt = tt + 1
  end
end

  if switch == true then
    tafla[i] = nil
  end
end
]]
local tp = 0
local auk = 1
local switch = false
local swit = 4


for i = 1, #tafla do

  --if tp%2 == 1 then
    --auk = 13

    --tp = tp + 1
    --switch = true
  --else
    --auk = 20
    --tp = tp + 1
    --switch = false
  --end

  --if switch == true then
    --tafla[i] = nil
  --end
  --print(auk)

end

local tel = 1

repeat
  --tel = i
  tafla[tel] = nil
  tel = tel + 1
until tel == 5

for i = 1, #tafla do
  print(tafla[i])
end

print(#tafla)
print(tafla[38])
