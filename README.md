
* [Source-Insight-Macro](#Source-Insight-Macro)
* [一、简介](#一、简介)
    * [1.自定义组织信息](#1.自定义组织信息)
    * [2.Doxygen风格的函数注释以及Todo标签](#2.Doxygen风格的函数注释以及Todo标签)
    * [3.Doxygen格式的单行注释风格](#3.Doxygen格式的单行注释风格)
* [二、FAQ](#二、FAQ)
    * [1.关于SourceInsight版本问题](#1.关于SourceInsight版本问题)
    * [2.关于Doexgen使用问题](#2.关于Doexgen使用问题)
* [三、参考与链接](#三、参考与链接)

<h1 id="Source-Insight-Macro">Source-Insight-Macro</h1>

<h2 id="一、简介">一、简介</h2>

&emsp;&emsp;该仓库旨在为 `C/C++` 的开发人员提供一套符合 [Doxygen][] 注释风格的SourceInsight 宏。具体的宏实现基于 [quicker.em][] 。
&emsp;&emsp;该仓库的具体工作主要是在原有 [quicker.em][] 的基础上，根据 [Source Insight 宏语言][] 语法要求，对其原有功能的扩展，新增功能见下文。

<h3 id="1.自定义组织信息">1. 自定义组织信息</h3>

&emsp;&emsp;允许用户在通过 `config` 进行初始配置的过程中，输入自定义的组织名称。倘若输入为空，则默认为 `XXX` 。

![自定义组织(公司)信息](/doc/CustomOrganization.gif "自定义组织/公司名称")


<h3 id="2.Doxygen风格的函数注释以及Todo标签">2. Doxygen风格的函数注释以及Todo标签</h3>

&emsp;&emsp;按照[Doxygen注释风格][]的要求，修改 `quicker.em` 原有的注释风格。同时添加   `todo` 、`note` 、`bug` 三种标签，用以丰富注释语言。

![函数注释以及标签](/doc/FuncComment.gif "函数注释以及标签")

<h3 id="3.Doxygen格式的单行注释风格">3. Doxygen格式的单行注释风格</h3>

&emsp;&emsp;改功能按照 `Doxygen` 注释风格的要求，为代码添加单行注释，需要为该宏——`DoxygenComment`设置专用的快捷键，本人一般将其绑定为 `Alt + D` 。
![Doxygen风格的单行注释](/doc/LineComment.gif "Doxygen风格的单行注释")



<h2 id="二、FAQ">二、FAQ</h2>
<h3 id="1.关于SourceInsight版本问题">1.关于SourceInsight版本问题</h3>

&emsp;&emsp;本人在测试与开发过程中，主要基于 `Sourceinsight 4.00.0087`,在之前版本上测试时，发现部分宏无法识别；尚未在最新软件上进行测试。

<h3 id="2.关于Doexgen使用问题">2.关于Doexgen使用问题</h3>

&emsp;&emsp;关于[Doxygen的使用方法，可以参见此博客][]。

<h2 id="三、参考与链接"> 三、参考与链接</h2>  

1. quicker.em:https://wenku.baidu.com/view/417e4b34eefdc8d376ee3259.html  

2. Doxygen:https://baike.baidu.com/item/Doxygen/1366536?fr=aladdin  

3. Source Insight 宏语言:https://www.sourceinsight.com/doc/v4/userguide/index.html#t=Manual%2FMacro_Language%2FMacro_Language.htm  

4. Doxygen注释风格:https://my.oschina.net/zhfish/blog/35422  

5. Doxygen的使用方法，可以参见此博客:https://blog.csdn.net/chenyujing1234/article/details/19115319  

[quicker.em]:https://wenku.baidu.com/view/417e4b34eefdc8d376ee3259.html "该宏功能扩展文件是华为的 lushengwen (卢胜文)于 2002 年进行整理和开发的"
[Doxygen]:https://baike.baidu.com/item/Doxygen/1366536?fr=aladdin "Doxygen_百度百科"
[Source Insight 宏语言]:https://www.sourceinsight.com/doc/v4/userguide/index.html#t=Manual%2FMacro_Language%2FMacro_Language.htm

[Doxygen注释风格]:https://my.oschina.net/zhfish/blog/35422
[Doxygen的使用方法，可以参见此博客]:https://blog.csdn.net/chenyujing1234/article/details/19115319 "Doxygen使用教程（个人总结）"


