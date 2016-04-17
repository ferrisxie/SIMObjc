####安装Install
- 第一步
```
pod install --no-repo-update
```
- 第二步:由于拓展了了JBWebViewController,原作者还没有merge我的请求，因此需要手动替换新的代码，保证编译成功。
```
到这里https://github.com/XFerris/JBWebViewController，替换pod文件夹里JBWebcontroller的实现文件和头文件。
```
####说明
* 项目内容objccn.io 上的所有文章。
* 通过python爬取数据制作的接口。
* 接口地址`objc.xferris.me/objc`
