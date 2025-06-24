#import "@preview/cetz:0.4.0": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/hydra:0.6.1": hydra

#set document(
  title: "椭圆曲线 - 数论与密码学（第二版）",
)
#set par(first-line-indent: (amount: 2em, all: true))
#let sans-fonts = (
  (name: "New Computer Modern", covers: regex("[a-zA-Z0-9’—]")),
  "Source Han Serif SC",
  "JiangChengXieSong 400W",
)
#set text(font: sans-fonts, size: 13pt)

#set heading(outlined: false, supplement: none)
#show heading.where(level: 1): it => [
  #set text(size: 20pt)
  #align(center)[
    #block(it, above: 2em, below: 2em)
  ]
]
#show heading.where(level: 2): it => [
  #set text(size: 16pt)
  #block(it, above: 1.5em, below: 1.5em)
]

#set figure(supplement: "图")
#show outline.entry: set text(fill: red)
#show link: set text(fill: red)
#show ref: set text(fill: red)
#show footnote: set text(fill: red)

#let conjecture-counter = counter("conjecture")
#show: sectioned-counter(conjecture-counter)
#let conjecture = thmbox.with(
  counter: conjecture-counter,
  variant: "猜想",
  color: colors.orange,
  title-fonts: sans-fonts,
  sans-fonts: sans-fonts,
)

/// https://typst-doc-cn.github.io/guide/FAQ/math-equation.html
#set math.equation(
  numbering: "(1.1)", /// FIXME: Only show the number
)
#show math.equation.where(block: true): it => {
  if not it.has("label") {
    let fields = it.fields()
    let _ = fields.remove("body")
    fields.numbering = none
    [#counter(math.equation).update(v => v - 1)#math.equation(..fields, it.body)<math-equation-without-label>]
  } else {
    it
  }
}

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

#counter(page).update(0)
#set page(numbering: "I")

= 前言

在过去的 20 或 30 年里，椭圆曲线在数论和其相关领域如密码学中都扮演着越来越重要的角色。比如在 1980 年代，椭圆曲线开始应用于密码学中，椭圆曲线技术被用于因式分解和素性检验。在 1980 和 1990 年代，椭圆曲线在费马大定理的证明中起到了重要作用。本书的目标是在仅具备初等数论以及群与域方面基础知识的前提下，建立起椭圆曲线的理论。这些基础知识大致相当于优秀本科生或初级研究生的抽象代数课程所涵盖的内容。特别地，我们并不假设读者具备代数几何的背景。除了少数可以选择性跳过的独立章节外，我们也不要求读者了解伽罗瓦理论。尽管我们在有限域的情形下隐含地使用了伽罗瓦理论，但在这种情况下，一切都可以通过弗罗贝尼乌斯映射显式地完成，因此不需要用到一般性的理论。相关的知识已在附录中进行了说明。

本书介绍了椭圆曲线在密码学和数论两个方面的内容。正因如此，我们在本书较早的部分，也就是第 4 章，就讨论了定义在有限域上的椭圆曲线。这一内容很自然地引出了第 5、6、7 章中的离散对数问题与密码学。只对密码学感兴趣的读者可以随后跳到第 11 章和第 13 章，了解魏尔配对、Tate-Lichtenbaum 配对以及超椭圆曲线的相关内容。但当然，任何真正专注于密码学应用的专家，多少也会对椭圆曲线在数论中的用途感到好奇。同样地，不关注实际应用的读者也可以跳过第 5 至第 7 章，直接进入第 8 章及之后的数论部分。但事实上，密码学应用本身也颇具趣味，并且提供了理论如何实际运用的范例。

关于椭圆曲线的优秀著作在文献中已有多种。本书并无意取代 Silverman 所著的两卷经典作品 @silverman1986arithmetic、@silverman1994advancedtopics，后者已成为椭圆曲线数论方面的标准参考资料。相反，本书从更基础的视角出发，涵盖了部分相同内容，并加入了对密码学应用的讨论。我们希望读者在阅读本书之后，能更容易理解 Silverman 的著作，并欣赏其略显进阶的处理方式。对于更偏解析方法的椭圆曲线算术研究，建议参考 Knapp @knapp1992elliptic 和 Koblitz @koblitz1993ellipticmodular 的著作，它们在这方面的处理比本书或 Silverman 的 @silverman1986arithmetic 更为深入。在椭圆曲线密码学方面，Blake 等人近期的著作 @blake2000elliptic 提供了多个算法的更详尽细节，尽管其中几乎没有证明，仍是学习椭圆曲线密码学的重要资料。本书旨在为理解该书中所用的数学提供良好的入门与解释。此外，Enge @enge1999elliptic、Koblitz @koblitz1998algebraiccrypto @koblitz1994course 以及 Menezes @menezes1993eccpubkey 等人的著作也从密码学角度探讨了椭圆曲线，值得深入阅读。

#thmbox(
  variant: "符号说明",
  numbering: none,
  title-fonts: sans-fonts,
)[
  符号 $ZZ, FF_q, QQ, RR, CC$ 分别表示整数域、有 $q$ 个元素的有限域、有理数域、实数域和复数域。我们使用 $ZZ_n$（而不是 $ZZ \/ n ZZ$）来表示模 $n$ 的整数。然而，当 $p$ 是素数，并且我们将 $ZZ_p$ 作为域而不是作为群或环来使用时，我们使用 $FF_p$，以与 $FF_q$ 的记号保持一致。注意，$ZZ_p$ 并不表示 $p$ 进整数。我们之所以这样选用，主要出于排版的考虑，因为模 $p$ 的整数频繁出现，而 $p$ 进整数的符号仅在第 13 章的少数几个例子中出现（其中我们用 $cal(O)_p$ 表示）。$p$ 进有理数表示为 $QQ_p$。

  如果 $K$ 是一个域，那么 $overline(K)$ 表示其代数闭包。如果 $R$ 是一个环，则 $R^times$ 表示 $R$ 中的可逆元素。当 $K$ 是域时，$K^times$ 因此表示 $K$ 的非零元素所构成的乘法群。在全书中，字母 $K$ 和 $E$ 通常分别用来表示一个域和一条椭圆曲线（但在第 9 章中，$K$ 有几处用来表示椭圆积分）。
]

#thmbox(
  variant: "致谢",
  numbering: none,
  title-fonts: sans-fonts,
)[
  作者感谢 CRC Press 的 Bob Stern 提议撰写本书并给予鼓励，也感谢 CRC Press 编辑团队在本书准备过程中提供的帮助。

  Ed Eikenberg、Jim Owings、Susan Schmoyer、Brian Conrad 和 Sam Wagstaff 提出了许多建议，使得手稿得到了极大的改进。当然，仍有提升的空间。欢迎将建议和勘误发送至 #link("mailto:lcw@math.umd.edu")[作者邮箱]。勘误列表将发布在 #link("www.math.umd.edu/~lcw/ellipticcurves.html")[本书的网站] 上。
]

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

#enum(
  numbering: "I.",
  enum.item[密码学路径：继续阅读第 5、6、7 章，然后跳转到第 11 章和第 13 章],
  enum.item[数论路径：阅读第 8、9、10、11、12、14、15 章，之后建议回头阅读先前跳过的章节，以了解该领域在实际应用中的用法],
  enum.item[复分析路径：阅读第 9、10 章以及第 12.1 节],
)

#pagebreak()
#outline(title: "目录", indent: 2em)

#set page(numbering: "1", header: context {
  if calc.odd(here().page()) {
    return align(right, emph(hydra()))
  }
  let section = hydra(2)
  if section != none {
    return align(left, emph(section))
  }
  align(left, emph(hydra()))
})
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

#figure(caption: "炮弹金字塔")[
  #canvas(length: 2em, {
    import draw: *

    circle((2, 0), fill: white)
    circle((2, 2), fill: white)
    circle((0, 2), fill: white)
    circle((-2, 2), fill: white)
    circle((-2, 0), fill: white)
    circle((-2, -2), fill: white)
    circle((0, -2), fill: white)
    circle((2, -2), fill: white)
    circle((1, 1), fill: white)
    circle((-1, 1), fill: white)
    circle((-1, -1), fill: white)
    circle((1, -1), fill: white)
    circle((0, 0), fill: white)
  })
]

如果金字塔有三层的话，那么这是做不到的，因为这一共有 $1 + 4 + 9 = 14$ 颗炮弹，而这不是一个完全平方数。当然，如果只有一颗球，它能构筑起一个一层高的金字塔，同时也是一个 $1 times 1$ 的正方形。如果没有球，那我们就有一个零层高的金字塔和一个 $0 times 0$ 的正方形。除了这些显然的情况外，还有其他的吗？我们提议使用一个可以追溯到丢番图时期（约公元前 250 年）的数学方法来找到另一个解。

设金字塔高 $x$，那么一共有 $ 1^2 + 2^2 + 3^3 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 颗球（见 @exercise:1-1）。我们期望这是一个完全平方数，也就是我们想要找到关于正整数 $x, y$ 的方程 $ y^2 = frac(x(x + 1)(2x + 1), 6) $ 的解。这样的方程给出了一个 *椭圆曲线*。图像如 @fig:pyramid-elliptic-curve 所示。

#figure(caption: $y^2 = x(x + 1)(2x + 1) \/ 6$)[
  #canvas(length: 6em, {
    import draw: *

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

    line((-1.05, 0), (1, 0))
    line((0, -1), (0, 1))
  })
] <fig:pyramid-elliptic-curve>

丢番图的方法使用我们已经知道的点来构造新的点。让我们从点 $(0, 0)$ 和 $(1, 1)$ 开始。过该两点的直线方程是 $y = x$，联立曲线方程可以得到 $ x^2 = frac(x(x + 1)(2x + 1), 6) = frac(1, 3) x^3 + frac(1, 2) x^2 + frac(1, 6) x $ 整理得到 $ x^3 - frac(3, 2) x^2 + frac(1, 2) x = 0 $ 幸运的是，我们已经知道了该方程的两个根 $x = 0$ 和 $x = 1$。这是因为这些根就是切线与曲线的交点的横坐标。我们可以通过因式分解这个多项式来找到第三个根，但有一个更好的方法。注意到对任意的数 $a, b, c$ 都有 $ (x - a)(x - b)(x - c) = x^3 - (a + b + c) x^2 + (a b + a c + b c) x - a b c $ 因此当 $x^3$ 的系数为 $1$ 时，$x^2$ 系数的负值就是所有根的和。

在我们这种情况下，我们有根 $0, 1$ 和 $x$，因此 $ 0 + 1 + x = frac(3, 2) $ 解得 $x = 1 \/ 2$。又因为 $y = x$，所以我们也得到 $y = 1 \/ 2$。很难说这对一堆炮弹有什么实际意义，但至少我们找到了这条曲线上的另外一个点。实际上我们因曲线的对称性还自动获得到了另一个点，也就是 $(1 \/ 2, -1 \/ 2)$。

让我们使用点 $(1 \/ 2, -1 \/ 2)$ 和 $(1, 1)$ 重复上述步骤。为什么使用这些点？因为我们正在寻找落在第一象限的交点，而经过这两个点的直线似乎是最合适的选择。很容易得到直线方程为 $y = 3x - 2$，联立曲线方程可以得到 $ (3x - 2)^2 = frac(x(x + 1)(2x + 1), 6) $ 整理得到 $ x^3 - frac(51, 2) x^2 + dots.c = 0 $（使用上述技巧，我们不需要求出低阶）我们已经知道了两个根 $x = 1 \/ 2$ 和 $x = 1$，因此 $ frac(1, 2) + 1 + x = frac(51, 2) $ 解得 $x = 24$。因为 $y = 3x - 2$，所以 $y = 70$。这意味着 $ 1^2 + 2^2 + 3^2 + dots.c + 24^2 = 70^2 $ 如果我们有 4900 个炮弹，我们就可以将它们排列成高为 24 的金字塔，或者一个 $70 times 70$ 的正方形。如果我们继续重复上述步骤，就比如我们使用刚刚得到的点作为我们其一的点，我们将得到这个方程的无穷多个有理数解。然而，可以证明在正整数解中，除了 $x = 1$ 的那个平凡解外，$(24, 70)$ 是这个问题的唯一非平凡解。这需要更加高深的技巧，故在此隐去细节，见 @anglin1990puzzle。

这还有另一个丢番图方法的例子 —— 是否存在一个直角三角形三条都是有理边，且面积为 5？最小的毕达哥拉斯三元组（勾股数）是 $(3, 4, 5)$，面积为 6，所以我们知道我们不能只把注意力放在整数上。现在再来看看边为 $(8, 15, 17)$ 的三角形，它的面积为 60。如果我们将边除以 2，我们得到一个边为 $(4, 15 \/ 2, 17 \/ 2)$ 的面积为 15 的三角形。所以有可能得到一个边不是整数，但面积是整数的三角形。

#figure(caption: "面积为 5 的有理边三角形")[
  #canvas(length: 2.5em, {
    import draw: *
    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ a $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ b $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ c $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-abc>

令我们所找的三角形三条边为 $a, b, c$，如 @fig:triangle-area-5-with-abc 所示。因为面积 $a b \/ 2 = 5$，我们所找的有理数 $a, b, c$ 就有 $ a^2 + b^2 = c^2, quad a b = 10 $ 简单的变形得到 $ (frac(a + b, 2))^2 = frac(a^2 + 2a b + b^2, 4) = frac(c^2 + 20, 4) = (frac(c, 2))^2 + 5 \ (frac(a - b, 2))^2 = frac(a^2 - 2a b + b^2, 4) = frac(c^2 - 20, 4) = (frac(c, 2))^2 - 5 $ 令 $x = (c \/ 2)^2$，得到 $ x - 5 = (frac(a - b, 2))^2 quad 和 quad x + 5 = (frac(a + b, 2))^2 $ 因此，我们正在寻找一个有理数 $x$，使得 $ x − 5, quad x, quad x + 5 $ 都是有理数的平方。换句话说，我们希望三个有理数的平方构成一个公差为 5 的等差数列。

假设我们能找到这样的 $x$，那么它们的乘积 $(x - 5)(x)(x + 5) = x^3 - 25x$ 也将必是一个有理数的平方，所以我们需要找方程 $ y^2 = x^3 - 25x $ 的有理解。

正如上面所说的，这是椭圆曲线的方程。当然，即使我们找到了一个这样的有理数解，也不能保证它对应一个有理边三角形（见 @exercise:1-2）。不过，一旦我们找到了一个满足 $y != 0$ 的有理数解，就可以利用它构造出另一个确实对应有理边三角形的解（见 @exercise:1-2）。这正是我们接下来要做的事情。

以备未来需要，我们记 $ x = (c/2)^2, quad y = sqrt((x - 5)(x)(x + 5)) = frac((a - b)(c)(a + b), 8) = frac((a^2 - b^2) c, 8) $

该曲线上有三个“显然”的点：$(-5, 0), (0, 0), (5, 0)$，这些点对我们帮助不大。它们不能构成三角形，并且连接其中任意两个点的直线都会与曲线在剩下的那点相交。简单搜索我们可以找到点 $(-4, 6)$，然而这个点与上述三个点任一的连线都无法给出有效的信息。唯一剩下的可能就是考虑过点 $(-4, 6)$ 与它自身，也就是曲线在这点的切线。隐函数求导可得 $ 2y y' = 3x^2 - 25, quad y' = frac(3x^2 - 25, 2y) = 23/12 $

因而切线方程为 $ y = 23/12 x + 41/3 $

与曲线联立得 $ (23/12 x + 41/3)^2 = x^3 - 25x $

整理得到 $ x^3 - (23/12)^2 x^2 + dots.c = 0 $

因为该直线是过点 $(-4, 6)$ 的切线，所以根 $x = -4$ 是重根，因而根的和为 $ -4 - 4 + x = (23/12)^2 $

解得 $x = 1681 \/ 114 = (41 \/ 12)^2$，再由直线方程可得 $y = 62279 \/ 1728$。

因为 $x = (c \/ 2)^2$，所以 $c = 41 \/ 6$，因此 $ 62279/1728 = y = frac((a^2 - b^2)c, 8) = frac(41(a^2 - b^2), 48) $

因此 $ a^2 - b^2 = 1519/36 $

又因为 $ a^2 + b^2 = c^2 = (41/6)^2 $

我们解得 $a^2 = 400 \/ 36$ 和 $b^2 = 9 \/ 4$，于是我们得到一个面积为 5 的有理边三角形（见 @fig:triangle-area-5-with-num），其边长分别为 $ a = 20 \/ 3, b = 3 \/ 2, c = 41 \/ 6 $

当然，这是由边为 $(40, 9, 41)$ 的三角形缩小 6 倍得到的。

#figure(caption: "面积为 5 的有理边三角形")[
  #canvas(length: 2.5em, {
    import draw: *
    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ 20 / 3 $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ 3 / 2 $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ 41 / 6 $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-num>

实际上还有无穷多的其他解，可由不断重复上述步骤得到。比如就使用我们刚刚发现的点（见 @exercise:1-4）。

哪些整数 $n$ 能作为具有有理数边的直角三角形的面积，这个问题被称为 *同余数问题*。如我们上面所看到的另一种表述方式就是：是否存在三个有理数平方数构成公差为 $n$ 的等差数列。这一问题最早出现在大约公元 900 年左右的阿拉伯手稿中。Tunnell 在 20 世纪 80 年代对该问题提出了一个猜想性答案，并加以证明 @tunnell1983diophantine。

我们知道，如果一个整数 $n$ 不是除了 1 以外的任何完全平方数的倍数，那么就称 $n$ 是无平方因子数。例如，5 和 15 是无平方因子数，而 24 和 75 则不是。

#conjecture[
  设 $n$ 是一个正奇无平方因子数。则当且仅当满足以下条件时，$n$ 可以表示为有理边直角三角形的面积：

  方程 $ 2x^2 + y^2 + 8z^2 = n $ 的整数解中，满足 $z$ 为偶数的解的个数等于满足 $z$ 为奇数的解的个数。

  若 $n = 2m$，其中 $m$ 是正奇无平方因子数，则当且仅当满足以下条件时，$n$ 可以表示为有理边直角三角形的面积：

  方程 $ 4x^2 + y^2 + 8z^2 = m $ 的整数解中，满足 $z$ 为偶数的解的个数等于满足 $z$ 为奇数的解的个数。
]

Tunnel @tunnell1983diophantine 证明了该猜想的充分性：如果存在一个面积为 $n$ 的直角三角形，则满足奇数解的个数等于偶数解的个数。然而，必要性 —— 即“解的个数条件成立则必定存在面积为 $n$ 的直角三角形”—— 依赖于尚未被证明的 Birch 和 Swinnerton-Dyer 猜想（见 @chap:zeta-functions[]）。

比如考虑 $n = 5$，此时没有满足 $2x^2 + y^2 + 8z^2 = 5$ 的整数解，故 $0 = 0$，条件显然成立，于是预测存在面积为 5 的有理边直角三角形。再考虑 $n = 1$，此时 $2x^2 + y^2 + 8z^2 = 1$ 的整数解为 $(0, 1, 0)$ 和 $(0, -1, 0)$，两者都是 $z$ 为偶数，故由 $2 != 0$ 得不存在面积为 1 的有理边直角三角形。这最早由费曼通过它的无穷下降法证明（见 @sec:fermat-infinite-descent[]）。

举一个非平凡的例子，考虑 $n = 41$。方程 $2x^2 + y^2 + 8z^2 = 41$ 的整数解为

$
  (plus.minus 4, plus.minus 3, 0), quad (plus.minus 4, plus.minus 1, plus.minus 1), quad (plus.minus 2, plus.minus 5, plus.minus 1), quad (plus.minus 2, plus.minus 1, plus.minus 2), quad (0, plus.minus 3, plus.minus 2)
$

（所有加减号的组合均允许）。一共有 32 个解，其中 $z$ 为偶数的有 16 个，$z$ 为奇数的也有 16 个。因此，我们预期存在面积为 41 的有理边直角三角形。按照前文提到的方法，利用曲线 $y^2 = x^3 - 41^2 x$ 上点 $(-9, 120)$ 处的切线，可以得到边长为 $(40 \/ 3, 123 \/ 20, 881 \/ 60)$ 的直角三角形，其面积为 41。

关于同余数问题的更多内容，见 @koblitz1993ellipticmodular。

最后，让我们考虑费马四次方程。我们想证明 $ a^4 + b^4 = c^4 $ <eq:quartic-fermat-equation> 在 $a, b, c$ 为非零整数时无解。这个方程是费马大定理中最简单的一种情形。该定理断言：当 $n >= 3$ 时，两个非零整数的 $n$ 次幂之和不可能是另一个非零整数的 $n$ 次幂。这个一般性的结论由 Wiles 在 1994 年证明，他结合了 Frey、Ribet、Serre、Mazur、Taylor 等人的工作，使用了椭圆曲线的性质。我们将在 @chap:fermat-last-theorem 讨论这些思想，但现在我们将目光集中在 $n = 4$ 这个简单得多的情形。这个情形下的第一个证明归功于费马本人。

假设存在非零整数 $a$ 使得 $a^4 + b^4 = c^4$。令 $ x = 2 frac(b^2 + c^2, a^2), quad y = 4b frac(b^2 + c^2, a^3) $

（见例 2.2）。直接计算可得：$ y^2 = x^3 - 4x $/// TODO: Ref to Example 2.2

在 @chap:elliptic-curves-over-Q 我们将证明，这个方程的所有有理数解为 $ (x, y) = (0, 0), (2, 0), (-2, 0) $

这些解都对应于 $b = 0$，因此 @eq:quartic-fermat-equation 没有非平凡的整数解。

三次费马方程也可以转换为椭圆曲线。假设 $a^3 + b^3 = c^3$ 且 $a b c != 0$，由于 $a^3 + b^3 = (a + b)(a^2 - a b + b^2)$，我们必须有 $a + b != 0$。令 $ x = 12 frac(c, a + b), quad y = 36 frac(a - b, a + b) $

那么可以得到：$ y^2 = x^3 - 432 $

（这个变量代换从哪里来的？见第 2.5.2 节）

可以证明（但这并不容易）这个方程的唯一有理数解为 $(x, y) = (12, plus.minus 36)$。

当 $y = 36$ 时，$a - b = a + b$，得到 $b = 0$；当 $y = -36$ 时，$a = 0$。

因此，当 $a b c != 0$ 时，方程 $a^3 + b^3 = c^3$ 没有整数解。

#heading(numbering: none, level: 2)[练习]

#exercise[
  使用数学归纳法证明 $ 1^2 + 2^2 + 3^2 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 对于所有的正整数 $x$ 都成立。
] <exercise:1-1>

#exercise[
  (a) 证明若 $x, y$ 是满足 $y^2 = x^3 - 25x$ 的有理数，且 $x$ 是一个有理数的平方，则这无法推出 $x + 5$ 和 $x - 5$ 都是有理数的平方。

  (b) $n$ 为整数，证明若 $x, y$ 是满足 $y^2 = x^3 - n^2x$ 的有理数，且 $x != 0, plus.minus n$，那么在曲线上作点 $(x, y)$ 的切线与曲线的交点 $(x_1, y_1)$ 满足 $x_1, x_1 - n, x_1 + n$ 都是有理数的平方。（更一般的见定理 8.14）这说明如果我们能找到一个起始点使得 $x != 0, plus.minus n$，那么使用文中的方法就一定能构造出一个面积为 $n$ 的有理边三角形。 /// TODO: Ref to Theorem 8.14
] <exercise:1-2>

#exercise[
  盘丢图并没有使用解析几何，更不可能知道如何使用隐函数求导来求切线的斜率。以下是他如何求出过点 $(-4, 6)$ 的 $y^2 = x^3 - 25x$ 的切线方程的。看起来，丢番图只是将其视作一个代数技巧。而牛顿似乎是第一个认识到这与求切线有关的人。

  (a) 令 $x = -4 + t, y = 6 + m t$ 并将这两个表达代入方程 $y^2 = x^3 - 25x$，这将得到一个关于 $t$ 的三次方程，且该方程以 $t = 0$ 为一个根。

  (b) 证明当取 $m = 23 \/ 12$ 时，$t = 0$ 是一个重根。

  (c) 求出该三次方程的另一个非零根 $t$，并据此计算得到
  $x = 1681 \/ 144, y = 62279 \/ 1728$。
] <exercise:1-3>

#exercise[
  使用过点 $(x, y) = (1681 \/ 114, 62279 \/ 1728)$ 的切线找到另一个面积为 5 的直角三角形。

] <exercise:1-4>

= 理论基础

== 魏尔斯特拉斯方程

在本书的大多数情形中，椭圆曲线 $E$ 是形如 $ y^2 = x^3 + A x + B $ 的方程图像，其中 $A$ 和 $B$ 是常数。这个形式被称为 *椭圆曲线的 Weierstrass 方程*。我们需要明确 $A, B, x$ 和 $y$ 分别属于哪个集合。通常，它们被看作某个域中的元素，例如实数域 $RR$、复数域 $CC$、有理数域 $QQ$、有限域 $FF_p (= ZZ_p)$，其中 $p$ 为素数，或更一般的有限域 $FF_q$，其中 $q = p^k$ 且 $k >= 1$。事实上，在本书几乎所有地方，如果读者对域这个概念不熟悉，也可以直接将其理解为上述这些常见的域之一即可。如果 $K$ 是一个域，且 $A, B in K$，那么我们说椭圆曲线 $E$ 是 *定义在* $K$ *上的*。在本书中，$E$ 和 $K$ 一般默认表示一个椭圆曲线及其定义所在的域。

如果我们希望讨论定义在某个扩域 $L supset.eq K$ 上的点，我们记作 $E(L)$。按照定义，这个集合总是包含一个将在本节后面定义的特殊点 $infinity$：

$ E(L) = {infinity} union {(x, y) in L times L divides y^2 = x^3 + A x + B} $

对于大多数域而言，无法画出直观的椭圆曲线图像。然而，为了形成直觉，考虑定义在实数域 $RR$ 上的曲线图像是很有帮助的。它们有两种基本形状，如图 2.1 所示：

#figure(caption: "椭圆曲线的两种基本形状")[
  #grid(
    columns: (auto, auto),
    rows: (auto, auto),
    column-gutter: 2em,
    canvas({
      import draw: *

      import draw: *

      let y(x) = {
        let y2 = x * x * x - x
        if y2 < 0 { return () }
        let y = calc.sqrt(y2)
        return ((x, y), (x, -y))
      }

      for i in range(-100, 200) {
        let p = y(i / 100)
        let p2 = y((i + 1) / 100)
        if p.len() == 0 or p2.len() == 0 { continue }
        line(p.at(0), p2.at(0))
        line(p.at(1), p2.at(1))
      }
      set-style(mark: (end: "barbed"))
      line((-1, 0), (2, 0))
      line((0, -3), (0, 3))
    }),
    canvas({
      import draw: *

      let y(x) = {
        let y2 = x * x * x + x
        if y2 < 0 {
          return ()
        }
        let y = calc.sqrt(y2)
        return ((x, y), (x, -y))
      }

      for i in range(0, 160) {
        let p = y(i / 100)
        let p2 = y((i + 1) / 100)
        if p.len() == 0 or p2.len() == 0 {
          continue
        }
        line(p.at(0), p2.at(0))
        line(p.at(1), p2.at(1))
      }
      set-style(mark: (end: "barbed"))
      line((-1, 0), (2, 0))
      line((0, -3), (0, 3))
    }),
  )
] <fig:elliptic-curves-shapes>

第一种情况下，方程 $y^2 = x^3 - x$ 的三次项有三个不相等的实数根。第二种情况下，方程 $y^2 = x^3 + x$ 只有一个实根。

---

那么，如果存在*重根*会发生什么呢？我们*不允许这种情况发生*。也就是说，我们假设：

$$
4A^3 + 27B^2 \ne 0
$$

若三次多项式 $x^3 + A x + B$ 的根为 $r_1, r_2, r_3$，则可以证明其判别式（discriminant）为：

$$
((r_1 - r_2)(r_1 - r_3)(r_2 - r_3))^2 = - (4A^3 + 27B^2)
$$

---

这段内容是椭圆曲线基础理论的核心之一。如果你还需要图像辅助说明、进一步数学背景（例如判别式为何如此定义），或者继续翻译接下来的章节，我都可以继续协助。


== 群运算

== Projective Space and the Point at Infinity

== Proof of Associativity

=== The Theorem of Pappus and Pascal

== Other Equations of Elliptic Curves

=== Legendre Equation

=== Cubic Equations

=== Quartic Equations

=== Intersection of Two Quadratic Surfaces

== Other Coordinate Systems

=== Projective Coordinates

=== Jacobian Coordinates

=== Edwards Coordinates

== The j-invariant

== Elliptic Curves in Characteristic 2

== Endomorphisms

== Singular Curves

== Elliptic Curves mod n

#heading(numbering: none, level: 2)[练习]

= Torsion Points

== Torsion Points

== Division Polynomials

== The Weil Pairing

== The Tate-Lichtenbaum Pairing

#heading(numbering: none, level: 2)[练习]

= Elliptic Curves over Finite Fields

== Examples

== The Frobenius Endomorphism

== Determining the Group Order

=== Subfield Curves

=== Legendre Symbols

=== Orders of Points

=== Baby Step, Giant Step

== A Family of Curves

== Schoof's Algorithm

== Supersingular Curves

#heading(numbering: none, level: 2)[练习]

= The Discrete Logarithm Problem

== The Index Calculus

== General Attacks on Discrete Logs

=== Baby Step, Giant Step

=== Pollard's $rho$ and $lambda$ Method

== Attacks with Pairings

=== The MOV Attack

=== The Frey-Rück Attack

== Anomalous Curves

== Other Attacks

#heading(numbering: none, level: 2)[练习]

= Elliptic Curves Cryptography

== The Basic Setup

== Diffe-Hellman Key Exchange

== Massey-Omura Encryption

== ElGamal Public Key Encryption

== ElGamal Digital Signatures

== The Digital Signature Algorithm

== ECIES

== A Public Key Scheme Based on Factoring

== A Cryptosystem Based on the Weil Pairing

#heading(numbering: none, level: 2)[练习]

= Other Applications

== Factoring Using Elliptic Curves

== Primality Testing

#heading(numbering: none, level: 2)[练习]

= Elliptic Curves over $QQ$ <chap:elliptic-curves-over-Q>

== The Torsion Subgroup. The Lutz-Nagell Theorem

== Descent and the Weak Mordell-Weil Theorem

== Heights and the Mordell-Weil Theorem

== Examples

== The Height Pairing

== Fermat's Infinite Descent <sec:fermat-infinite-descent>

== 2-Selmer Groups; Shafarevich-Tate Groups

== A Nontrivial Shafarevich-Tate Group

== Galois Cohomology

#heading(numbering: none, level: 2)[练习]

= Elliptic Curves over $CC$

== Doubly Periodic Functions

== Tori are Elliptic Curves

== Elliptic Curves over $CC$

== Computing Periods

=== The Arithmetic-Geometric Mean

== Division Polynomials

== The Torsion Subgroup: Doud's Method

#heading(numbering: none, level: 2)[练习]

= Complex Multiplication

== Elliptic Curves over $CC$

== Elliptic Curves over Finite Fields

== Integrality of j-invariant

== Numerical Examples

== Kronecker's Jugendtraum

#heading(numbering: none, level: 2)[练习]

= Divisors

== Definitions and Examples

== The Weil Pairing

== The Tate-Lichtenbaum Pairing

== Computation of the Pairings

== Genus One Curves and Elliptic Curves

== Equivalence of the Definitions of the Pairings

=== The Weil Pairing

=== The Tate-Lichtenbaum Pairing

== Nondegeneracy of the Tate-Lichtenbaum Pairing

#heading(numbering: none, level: 2)[练习]

= Isogenies

== The Complex Theory

== The Algebraic Theory

== Vélu's Formulas

== Point Counting

== Complements

#heading(numbering: none, level: 2)[练习]

= Hyperelliptic Curves

== Basic Definitions

== Divisors

== Cantor's Algorithm

== The Discrete Logarithm Problem

#heading(numbering: none, level: 2)[练习]

= Zeta Functions <chap:zeta-functions>

== Elliptic Curves over Finite Fields

== Elliptic Curves over $QQ$

#heading(numbering: none, level: 2)[练习]

= Fermat's Last Theorem <chap:fermat-last-theorem>

== Overview

== Galois Representations

== Sketch of Ribet's Proof

== Sketch of Wiles' Proof

#let appendix(body) = {
  set heading(numbering: "A.1", supplement: [Appendix])
  counter(heading).update(0)
  body
}
#show: appendix

= Number Theory

= Groups

= Fields

= Computer Packages

== Pari

== Magma

== SAGE

#bibliography("/references.bib", title: "参考文献")
