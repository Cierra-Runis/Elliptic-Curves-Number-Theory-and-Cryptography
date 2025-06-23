#import "@preview/cetz:0.4.0"
#import "@preview/thmbox:0.2.0": *


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

#set heading(outlined: false)
#show heading.where(level: 1): it => [
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

#set page(numbering: "1")
#counter(page).update(1)

#show: thmbox-init()
#set heading(outlined: true)
#show heading.where(level: 1): it => [
  #pagebreak()
  #set text(size: 20pt)
  #align(center)[
    #block(it, above: 2em, below: 2em)
  ]
]
#set heading(numbering: (..num) => {
  if num.pos().len() == 1 {
    numbering("第 1 章", num.pos().at(0))
  } else {
    numbering("1.1", ..num)
  }
})

= 引入

假定有一堆球形炮弹以金字塔的形状堆放，并顶层有一颗，第二层有四颗，第三层有九颗，依此类推。如果这堆炮弹倒塌，是否有可能将这些炮弹重新排列成为一个正方形？

#figure(caption: "炮弹1金字塔")[
  #cetz.canvas(length: 1.9em, {
    import cetz.draw: *

    circle((2, 0), fill: yellow)
    circle((2, 2), fill: yellow)
    circle((0, 2), fill: yellow)
    circle((-2, 2), fill: yellow)
    circle((-2, 0), fill: yellow)
    circle((-2, -2), fill: yellow)
    circle((0, -2), fill: yellow)
    circle((2, -2), fill: yellow)
    circle((1, 1), fill: orange)
    circle((-1, 1), fill: orange)
    circle((-1, -1), fill: orange)
    circle((1, -1), fill: orange)
    circle((0, 0), fill: red)
  })
]

如果金字塔有三层的话，那么这是做不到的，因为这一共有 $1 + 4 + 9 = 14$ 颗炮弹，而这不是一个完全平方数。当然，如果只有一颗球，它能构筑起一个一层高的金字塔，同时也是一个 $1 times 1$ 的正方形。如果没有球，那我们就有一个零层高的金字塔和一个 $0 times 0$ 的正方形。除了这些显然的情况外，还有其他的吗？我们提议使用一个可以追溯到丢番图时期（约公元前 250 年）的数学方法来找到另一个解。

设金字塔高 $x$，那么一共有 $ 1^2 + 2^2 + 3^3 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 颗球（见 @exercise:1）。我们期望这是一个完全平方数，也就是我们想要找到关于正整数 $x, y$ 的方程 $ y^2 = frac(x(x + 1)(2x + 1), 6) $ 的解。这样的方程给出了一个 *椭圆曲线*。图像如 @fig:pyramid-elliptic-curve 所示。

#figure(caption: $y^2 = x(x + 1)(2x + 1) \/ 6$)[
  #cetz.canvas(length: 6em, {
    import cetz.draw: *

    let y(x) = {
      let y2 = x * (x + 1) * (2 * x + 1) / 6
      if y2 < 0 {
        return ()
      }
      let y = calc.sqrt(y2)
      return ((x, y), (x, -y))
    }

    for i in range(-100, 100) {
      let p = y(i / 100)
      let p2 = y((i + 1) / 100)
      if p.len() == 0 or p2.len() == 0 {
        continue
      }
      line(p.at(0), p2.at(0))
      line(p.at(1), p2.at(1))
    }

    grid(
      (-1, -1),
      (1, 1),
      help-lines: true,
    )
  })
] <fig:pyramid-elliptic-curve>

丢番图的方法使用我们已经知道的点来构造新的点。让我们从点 $(0, 0)$ 和 $(1, 1)$ 开始。过该两点的直线方程是 $y = x$，联立曲线方程可以得到 $ x^2 = frac(x(x + 1)(2x + 1), 6) = frac(1, 3) x^3 + frac(1, 2) x^2 + frac(1, 6) x $ 整理得到 $ x^3 - frac(3, 2) x^2 + frac(1, 2) x = 0 $ 幸运的是，我们已经知道了该方程的两个根 $x = 0$ 和 $x = 1$。这是因为这些根就是切线与曲线的交点的横坐标。我们可以通过因式分解这个多项式来找到第三个根，但有一个更好的方法。注意到对任意的数 $a, b, c$ 都有 $ (x - a)(x - b)(x - c) = x^3 - (a + b + c) x^2 + (a b + a c + b c) x - a b c $ 因此当 $x^3$ 的系数为 $1$ 时，$x^2$ 系数的负值就是所有根的和。

在我们这种情况下，我们有根 $0, 1$ 和 $x$，因此 $ 0 + 1 + x = frac(3, 2) $ 解得 $x = 1 \/ 2$。又因为 $y = x$，所以我们也得到 $y = 1 \/ 2$。很难说这对一堆炮弹有什么实际意义，但至少我们找到了这条曲线上的另外一个点。实际上我们因曲线的对称性还自动获得到了另一个点，也就是 $(1 \/ 2, -1 \/ 2)$。

让我们使用点 $(1 \/ 2, -1 \/ 2)$ 和 $(1, 1)$ 重复上述步骤。为什么使用这些点？因为我们正在寻找落在第一象限的交点，而经过这两个点的直线似乎是最合适的选择。很容易得到直线方程为 $y = 3x - 2$，联立曲线方程可以得到 $ (3x - 2)^2 = frac(x(x + 1)(2x + 1), 6) $ 整理得到 $ x^3 - frac(51, 2) x^2 + dots.c = 0 $（使用上述技巧，我们不需要求出低阶）我们已经知道了两个根 $x = 1 \/ 2$ 和 $x = 1$，因此 $ frac(1, 2) + 1 + x = frac(51, 2) $ 解得 $x = 24$。因为 $y = 3x - 2$，所以 $y = 70$。这意味着 $ 1^2 + 2^2 + 3^2 + dots.c + 24^2 = 70^2 $ 如果我们有 4900 个炮弹，我们就可以将它们排列成高为 24 的金字塔，或者一个 $70 times 70$ 的正方形。如果我们继续重复上述步骤，就比如我们使用刚刚得到的点作为我们其一的点，我们将得到这个方程的无穷多个有理数解。然而，可以证明在正整数解中，除了 $x = 1$ 的那个平凡解外，$(24, 70)$ 是这个问题的唯一非平凡解。这需要更加高深的技巧，故在此隐去细节，参见 @anglin1990puzzle。

这还有另一个丢番图方法的例子 —— 是否存在一个直角三角形三条都是有理边，且面积为 5？最小的毕达哥拉斯三元组（勾股数）是 $(3, 4, 5)$，面积为 6，所以我们知道我们不能只把注意力放在整数上。现在再来看看边为 $(8, 15, 17)$ 的三角形，它的面积为 60。如果我们将边除以 2，我们得到一个边为 $(4, 15 \/ 2, 17 \/ 2)$ 的面积为 15 的三角形。所以有可能得到一个边不是整数，但面积是整数的三角形。

#figure(caption: "面积为 5 的有理边三角形")[
  #cetz.canvas(length: 2.5em, {
    import cetz.draw: *
    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ a $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ b $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ c $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-abc>

令我们所找的三角形三条边为 $a, b, c$，如图 @fig:triangle-area-5-with-abc 所示。因为面积 $a b \/ 2 = 5$，我们所找的有理数 $a, b, c$ 就有 $ a^2 + b^2 = c^2, quad a b = 10 $ 简单的变形得到 $ (frac(a + b, 2))^2 = frac(a^2 + 2a b + b^2, 4) = frac(c^2 + 20, 4) = (frac(c, 2))^2 + 5 \ (frac(a - b, 2))^2 = frac(a^2 - 2a b + b^2, 4) = frac(c^2 - 20, 4) = (frac(c, 2))^2 - 5 $ 令 $x = (c \/ 2)^2$，得到 $ x - 5 = (frac(a - b, 2))^2 quad 和 quad (frac(a + b, 2))^2 $ 因此，我们正在寻找一个有理数 $x$，使得 $ x − 5, quad x, quad x + 5 $ 都是有理数的平方。换句话说，我们希望三个有理数的平方构成一个公差为 5 的等差数列。

假设我们能找到这样的 $x$，那么它们的乘积 $(x - 5)(x)(x + 5) = x^3 - 25x$ 也将必是一个有理数的平方，所以我们需要找方程 $ y^2 = x^3 - 25x $ 的有理解。

正如上面所说的，这是椭圆曲线的方程。当然，即使我们找到了一个这样的有理数解，也不能保证它对应一个有理数三角形（参见 @exercise:2）。不过，一旦我们找到了一个满足 $y != 0$ 的有理数解，就可以利用它构造出另一个确实对应有理边三角形的解（参见 @exercise:2）。这正是我们接下来要做的事情。

/// TODO: Keep translate here...

#figure(caption: "面积为 5 的有理边三角形")[
  #cetz.canvas(length: 2.5em, {
    import cetz.draw: *
    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ frac(20, 3) $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ frac(3, 2) $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ frac(41, 6) $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-num>

== 练习

#exercise[
  使用数学归纳法证明 $ 1^2 + 2^2 + 3^2 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 对于所有的正整数 $x$ 都成立。
] <exercise:1>

#exercise[
  + 证明若 $x, y$ 是满足 $y^2 = x^3 - 25x$ 的有理数，且 $x$ 是一个有理数的平方，则这无法推出 $x + 5$ 和 $x - 5$ 都是有理数的平方。 /// TODO: Check meaning

  + $n$ 为整数，证明若 $x, y$ 是满足 $y^2 = x^3 - n^2x$ 的有理数，且 $x != 0, plus.minus n$，那么在曲线上作点 $(x, y)$ 的切线与曲线的交点 $(x_1, y_1)$ 满足 $x_1, x_1 - n, x_1 + n$ 都是有理数的平方。（更一般的见定理 8.14）这说明如果我们能找到一个起始点使得 $x != 0, plus.minus n$，那么使用文中的方法就一定能构造出一个面积为 $n$ 的有理数三角形。
] <exercise:2>

= 理论基础

== 魏尔斯特拉斯方程

== 群运算

#bibliography("/references.bib", title: "参考文献")
