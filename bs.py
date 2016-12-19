import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from bs4 import BeautifulSoup
soup = BeautifulSoup(open("hometable.html"), "html.parser")
soup2 = BeautifulSoup(open("awaytable.html"), "html.parser")
soup3 = BeautifulSoup(open("matches.html"), "html.parser")

text = soup.get_text()
text2 = soup2.get_text()
text3 = soup3.get_text()
print(text3)


fill = open("hometable.txt", "w")
fill2 = open("awaytable.txt", "w")
fill3 = open("matches.txt", "w")
fill.write(text)
fill2.write(text2)
fill3.write(text3)
lis = []
scores = soup3.find_all("b")
fill4 = open("scores.txt", "w")
print(scores)
fill4.write(str(scores))

tp = soup3.find_all("td", " ")

#print(len(tp))
#print(lis[0])
for index in range(len(tp)):
    if len(str(tp[index])) <= 35 and len(str(tp[index])) >= 30 :
        lis.insert(index, str(tp[index]))

#for index in range(len(lis)):
    #print(lis[index])
#stp = ["Hallo her eru", "eitthverjar"]
#print(len(stp[0]))

#strengur = "HalloHer"
#print(strengur.isalnum())
