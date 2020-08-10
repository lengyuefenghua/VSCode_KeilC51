# KeilC51_VsCode
本人参考GitHub项目[https://github.com/kcqnly/VSCode-C511](https://github.com/kcqnly/VSCode-C51)中的.vscode部分进行了VsCode环境下C51开发的构建，主要参考了其中的C51关键字处理方法（曾在visual studio上进行C51开发环境构建，奈何本人才学疏浅，无法解决C51关键字问题，遂放弃），本项目使用起来非常简单，编译处理程序会自动获取Keil的路径，无需修改，打开即用。
##   效果展示
*   编译成功
[![asspQA.png](https://s1.ax1x.com/2020/08/05/asspQA.png)](https://imgchr.com/i/asspQA)
*   编译失败
![as5LwQ.th.png](https://s1.ax1x.com/2020/08/05/as5LwQ.png)
##  使用说明
*   1.安装KeilC51（注：安装时请选择英文路径或者拼音，最好不要有中文路径和空格，防止意外；Keil未注册会有代码量限制，若编写较大工程，则需要注册，具体注册方法请自行百度）。
*   2.安装VsCode并安装C/C++插件。
*   3.下载本项目。
[点击下载(GitHub)](https://github.com/liaoweijia/KeilC51_VsCode/archive/master.zip)
[点击下载(蓝奏云)](https://lengyuefenghua.lanzous.com/iehvdfbnoha)
*   4.在VsCode中打开文件夹，点击终端-运行生成任务（或者按下快捷键Ctrl+Shift+B），开始编译。
*   5.开始你的项目。
##  文件夹说明
*   .vscode 工程配置
*   lib 用户库文件（.h）
*   lib/inc 51单片机标准库文件、启动文件、静态库文件(.h、.lib、.A51)
*   output 编译结果输出(.obj、.lst、.hex、···)
*   src 用户源文件(.c)
##  说明
在使用过程中出现任何问题，请留言！