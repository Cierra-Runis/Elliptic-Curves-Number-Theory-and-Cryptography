#import "@preview/cetz:0.4.0"

#set document(
  title: "椭圆曲线 - 数论与密码学（第二版）",
)
#set par(first-line-indent: (amount: 2em, all: true))
#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"),
    "Source Han Serif SC",
    "JiangChengXieSong 400W",
  ),
  size: 12pt,
)
#show emph: text.with(font: (
  (name: "New Computer Modern", covers: "latin-in-cjk"),
  "Kaiti",
))

#show heading.where(level: 1): it => [
  #pagebreak()
  #set text(size: 20pt)
  #align(center)[
    #block(it, above: 2em, below: 2em)
  ]
]
#show link: set text(fill: red)
#show ref: set text(fill: red)
#show footnote: set text(fill: red)

#align(center)[
  #v(10%)

  #set text(weight: "bold", size: 38pt, features: ("smcp",))
  Elliptic Curves

  #set text(weight: "regular", size: 28pt)
  Number Theory and Cryptography

  #set text(size: 16pt)
  Second Edition

  椭圆曲线 数论与密码学 第二版

  #image("/assets/Simple_Torus.svg")

  #set text(size: 20pt)
  LAWRENCE C. WASHINGTON

  #set text(size: 12pt)
  University of Maryland

  College Park, Maryland, U.S.A.
]

#set page(numbering: "I")
#counter(page).update(1)

= 前言

在过去的 20 或 30 年里，椭圆曲线在数论和其相关领域如密码学中都扮演着越来越重要的角色。比如在 1980 年代，椭圆曲线开始应用于密码学中，椭圆曲线技术被用于因式分解和素性检验。在 1980 和 1990 年代，椭圆曲线在费玛最后定理的证明中起到了重要作用。本书的目标是在……仅具备初等数论以及群与域方面基础知识的前提下，建立起椭圆曲线的理论。这些基础知识大致相当于优秀本科生或初级研究生的抽象代数课程所涵盖的内容。特别地，我们并不假设读者具备代数几何的背景。除了少数可以选择性跳过的独立章节外，我们也不要求读者了解伽罗瓦理论。尽管我们在有限域的情形下隐含地使用了伽罗瓦理论，但在这种情况下，一切都可以通过弗罗贝尼乌斯映射显式地完成，因此不需要用到一般性的理论。相关的知识已在附录中进行了说明。

本书介绍了椭圆曲线在密码学和数论两个方面的内容。正……因如此，我们在本书较早的部分，也就是第 4 章，就讨论了定义在有限域上的椭圆曲线。这一内容很自然地引出了第 5、6、7 章中的离散对数问题与密码学。只对密码学感兴趣的读者可以随后跳到第 11 章和第 13 章，了解魏尔配对、Tate-Lichtenbaum 配对以及超椭圆曲线的相关内容。但当然，任何真正专注于密码学应用的专家，多少也会对椭圆曲线在数论中的用途感到好奇。同样地，不关注实际应用的读者也可以跳过第 5 至第 7 章，直接进入第 8 章及之后的数论部分。但事实上，密码学应用本身也颇具趣味，并且提供了理论如何实际运用的范例。

关于椭圆曲线的优秀著作在文献中已有多种。本书并无意取代 Silverman 所著的两卷经典作品 @silverman1986arithmetic、@silverman1994advancedtopics，后者已成为椭圆曲线数论方面的标准参考资料。相反，本书从更基础的视角出发，涵盖了部分相同内容，并加入了对密码学应用的讨论。我们希望读者在阅读本书之后，能更容易理解 Silverman 的著作，并欣赏其略显进阶的处理方式。对于更偏解析方法的椭圆曲线算术研究，建议参考 Knapp @knapp1992elliptic 和 Koblitz @koblitz1993ellipticmodular 的著作，它们在这方面的处理比本书或 Silverman 的 @silverman1986arithmetic 更为深入。在椭圆曲线密码学方面，Blake 等人近期的著作 @blake2000elliptic 提供了多个算法的更详尽细节，尽管其中几乎没有证明，仍是学习椭圆曲线密码学的重要资料。本书旨在为理解该书中所用的数学提供良好的入门与解释。此外，Enge @enge1999elliptic、Koblitz @koblitz1998algebraiccrypto @koblitz1994course 以及 Menezes @menezes1993eccpubkey 等人的著作也从密码学角度探讨了椭圆曲线，值得深入阅读。

= 第二版前言

读者在阅读第二版前言时最常提出的问题就是“有什么新内容”，主要增加了以下内容：

+ 新增关于同源映射的章节

+ 新增关于双曲线的章节，该主题在许多领域，尤其是密码学中日益受到关注

+ 新增对替代坐标系（如射影坐标、Jacobian 坐标、Edwards 坐标）及其相关计算问题的讨论

+ 对 Weil 配对 和 Tate-Lichtenbaum 配对 提供更完整的处理，包括 Tate-Lichtenbaum 配对的初等定义、其非退化性的证明，以及 Weil 配对两种常见定义相等的证明

+ 加入 Doud 提出的用于计算有理数域上椭圆曲线扭点的解析方法

+ 补充了一些用于确定有限域上椭圆曲线点群的新技术

+ 新增关于如何在一些流行的计算机代数系统中进行椭圆曲线计算的讨论

+ 增加了若干新习题

我要感谢许多人，特别是 Susan Schmoyer、Juliana Belding、Tsz Wo Nicholas Sze、Enver Ozdemir、Qiao Zhang 和 Koichiro Harada，他们提出了许多有益的建议。许多读者对第一版提供了意见和勘误，我们对此深表感激。我们已将其中大部分内容纳入本版。当然，我们也欢迎对本版 #link("mailto:lcw@math.umd.edu")[提出意见和勘误]。相关更正将会列在 #link("https://math.umd.edu/~lcw/ellipticcurves.html")[本书的网站] 上。#footnote("译者注：中文版将遵从该网址的勘误更新")

= 读者建议

本书面向至少两类读者。一类是希望了解椭圆曲线的计算机科学家和密码学家，另一类是希望了解椭圆曲线的数论与几何的数学家。当然，这两类人群之间有一定的重叠。作者自然希望读者能通读全书，但对于只希望从部分章节入手的读者，提出以下阅读建议：

所有读者：第 1、2、3、4 章提供了该主题的基础介绍，所有人都应阅读这些章节。

I. 密码学路径
继续阅读第 5、6、7 章，然后跳转到第 11 章和第 13 章。

II. 数论路径
阅读第 8、9、10、11、12、14、15 章。之后建议回头阅读先前跳过的章节，以了解该领域在实际应用中的用法。

III. 复分析路径
阅读第 9、10 章以及第 12.1 节。

= 译者的话

#outline(
  title: "目录",
  indent: 2em,
)

#set heading(numbering: (..num) => {
  if num.pos().len() == 1 {
    numbering("第 1 章", num.pos().at(0))
  } else {
    numbering("1.1", ..num)
  }
})

#set page(numbering: "1")
#counter(page).update(1)

= 引入

== 练习

= 理论基础

== 魏尔斯特拉斯方程

== 群运算

#bibliography("/references.bib", title: "参考文献")
