####安装
```
pod install --no-repo-update
```
####注意事项
#####由于项目尚未完成，接口未提交到服务器，因此需要在本地127.0.0.1:5000挂载接口 
数据获取  
先执行
```python
import urllib
content = urllib.urlopen('http://www.objccn.io').read()
with open('master.txt','w') as file:
    file.write(content)
```
htmlHandler.py
```python
#encoding:utf8
from bs4 import BeautifulSoup


def getSoup():
    with open('/Users/Ferris/PycharmProjects/SIMObjc/static/master.txt','r') as file:
        html = file.read()
        soup=BeautifulSoup(html,'html5lib',from_encoding='utf-8')
        return soup
#[{id:name,issues:[{name:url},{name:url}]}]
def getMasters():
    soup = getSoup()
    master = soup.find_all('h2','at_post_title')
    rs = []
    for h2 in master:
        issues = []
        origin = h2.a.string[1:]
        info = origin.split()
        div = h2.parent.find_next('div')
        ases = div.find_all('a')
        mastername = ''
        for i in range(1,len(info)-1):
            mastername = mastername+info[i]+' '
        mastername = mastername+info[len(info)-1]
        for a in ases:
            href = a['href']
            if (not href[-3:]=='-0/') and (not href[:1]=='/'):
                name = a.string
                url = a['href']
                issues.append({name:url})
        rs.append({info[0]:mastername,'issues':issues})
    return rs

```
SIMObjc.py
```
import htmlHandler
from flask import Flask,jsonify
import  json
app = Flask(__name__)



@app.route('/')
def welcome():
    return "Welcome to Ferris's Blog"
@app.route('/objc')
def getMasters():
    html = htmlHandler.getMasters()
    html.reverse()
    return  json.dumps(html)

if __name__ == '__main__':
    app.run(debug=True)
```
也可以给我发送邮件`xwh826529092@icloud.co`m来获取数据库文件。

