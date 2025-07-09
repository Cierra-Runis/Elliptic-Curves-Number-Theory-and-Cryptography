#import "@preview/cetz:0.4.0"
#import "@preview/thmbox:0.2.0": sectioned-counter, thmbox, thmbox-init
#import "@preview/hydra:0.6.1": hydra
#import "@preview/subpar:0.2.2"
#import "theme.typ": theme-init, theme-setup

#set document(
  title: "椭圆曲线 - 数论与密码学（第二版）",
  author: "Lawrence C. Washington",
)
#set par(first-line-indent: (amount: 2em, all: true))

/// START: Fonts
#let serif-fonts = (
  (name: "New Computer Modern", covers: regex("[a-zA-Z0-9’—]")),
  "Source Han Serif SC",
)
#set text(font: serif-fonts, size: 13pt)
#show emph: text.with(font: "LXGW WenKai GB")
#show raw: text.with(font: "Cascadia Code")
#show math.equation: set text(font: (
  "New Computer Modern Math",
  "LXGW WenKai GB",
))
/// END: Fonts

/// START: Colors
#let flavor = theme-init()
#show: theme-setup.with(flavor)
#let colors = flavor.colors

#let link-color = colors.red
#show outline.entry: set text(fill: link-color)
#show link: set text(fill: link-color)
#show ref: set text(fill: link-color)
#show footnote: set text(fill: link-color)
#set footnote.entry(separator: line(length: 30%, stroke: (paint: colors.text, thickness: 0.5pt)))

/// - file (str): The path to the SVG file.
/// - color (color): The color to replace the stroke color with.
#let svg-colorize(file, color) = {
  bytes(read(file).replace(
    regex("stroke=\"[^\"]*\""),
    "stroke=\"" + color.to-hex() + "\"",
  ))
}
/// END: Colors

/// START: Counting and Headings
#set heading(outlined: false, supplement: none)
#show heading.where(level: 1): it => [
  #set text(size: 19pt)
  #counter(math.equation).update(0)
  #counter(figure.where(kind: image)).update(0)
  #align(center)[
    #block(it, above: 2em, below: 2em)
  ]
]
#show heading.where(level: 2): it => [
  #set text(size: 17pt)
  #block(it, above: 1.75em, below: 1.75em)
]
#show heading.where(level: 3): it => [
  #set text(size: 15pt)
  #block(it, above: 1.5em, below: 1.5em)
]

#set figure(supplement: "图", numbering: num => (
  numbering("1-1", counter(heading).get().first(), num)
))
#set figure.caption(separator: h(1em))
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: "thmbox"): set block(breakable: true)

#set table(stroke: none)
#set table.hline(stroke: (paint: colors.text, thickness: 0.5pt))
#set table.vline(stroke: (paint: colors.text, thickness: 0.5pt))

/// https://typst-doc-cn.github.io/guide/FAQ/math-equation.html
#set math.equation(supplement: "式", numbering: num => (
  "(" + str(counter(heading).get().first()) + "." + str(num) + ")"
))
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
/// END: Counting and Headings

/// START: Thmbox
#let conjecture-counter = counter("conjecture")
#show: sectioned-counter(conjecture-counter)
#let conjecture = thmbox.with(
  color: colors.blue,
  counter: conjecture-counter,
  variant: "猜想",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter)
#let exercise = thmbox.with(
  color: colors.sky,
  counter: exercise-counter,
  variant: "练习",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let example-counter = counter("example")
#show: sectioned-counter(example-counter)
#let example = thmbox.with(
  color: colors.green,
  counter: example-counter,
  variant: "示例",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let theorem = thmbox.with(
  color: colors.red,
  variant: "定理",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let lemma = thmbox.with(
  color: colors.lime,
  variant: "引理",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let definition = thmbox.with(
  color: colors.yellow,
  variant: "定义",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let remark = thmbox.with(
  color: colors.text,
  variant: "注记",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let corollary = thmbox.with(
  color: colors.red,
  variant: "推论",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let proposition = thmbox.with(
  color: colors.fuchsia,
  variant: "命题",
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let note = thmbox.with(
  color: colors.text,
  variant: "笔记",
  numbering: none,
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let proof = thmbox.with(
  color: colors.emerald,
  variant: "证明",
  numbering: none,
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let warning = thmbox.with(
  color: colors.orange,
  variant: "警告",
  numbering: none,
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)

#let algorithm = thmbox.with(
  color: colors.purple,
  variant: "算法",
  numbering: none,
  title-fonts: serif-fonts,
  sans-fonts: serif-fonts,
)
/// END: Thmbox


/// START: Title Page
#align(center)[
  #v(10%)

  #set text(weight: "bold", size: 38pt, features: ("smcp",))
  Elliptic Curves

  #set text(weight: "regular", size: 28pt)
  Number Theory and Cryptography

  #set text(size: 16pt)
  Second Edition

  _椭圆曲线#h(1em)数论与密码学#h(1em)第二版_

  #image(svg-colorize("/assets/Torus.svg", colors.text), width: 20em)

  #set text(size: 20pt)
  LAWRENCE C. WASHINGTON

  #set text(size: 12pt)
  University of Maryland

  College Park, Maryland, U.S.A.
]
/// END: Title Page

#counter(page).update(0)
#set page(numbering: "I") // or whatever you want
#set page(footer: context {
  set align(center)
  [#link(<toc>)[#counter(page).display(page.numbering)]]
})


/// START: Front matter
= 前言

在过去的 20 或 30 年里，椭圆曲线在数论和其相关领域如密码学中都扮演着越来越重要的角色。比如在 1980 年代，椭圆曲线开始应用于密码学中，椭圆曲线技术被用于因式分解和素性检验。在 1980 和 1990 年代，椭圆曲线在费马大定理的证明中起到了重要作用。本书的目标是在仅具备初等数论以及群与域方面基础知识的前提下，建立起椭圆曲线的理论。这些基础知识大致相当于优秀本科生或初级研究生的抽象代数课程所涵盖的内容。特别地，我们并不假设读者具备代数几何的背景。除了少数可以选择性跳过的独立章节外，我们也不要求读者了解伽罗瓦理论。尽管我们在有限域的情形下隐含地使用了伽罗瓦理论，但在这种情况下，一切都可以通过弗罗贝尼乌斯映射显式地完成，因此不需要用到一般性的理论。相关的知识已在附录中进行了说明。#footnote[译者注：可先查看 @appendix:number-theory、@appendix:groups 和 @appendix:fields 的内容]

本书介绍了椭圆曲线在密码学和数论两个方面的内容。正因如此，我们在本书较早的部分，也就是 @chap:elliptic-curves-over-finite-fields，就讨论了定义在有限域上的椭圆曲线。这一内容很自然地引出了 @chap:the-discrete-logarithm-problem、@chap:elliptic-curves-cryptography、@chap:other-applications 中的离散对数问题与密码学。只对密码学感兴趣的读者可以随后跳到 @chap:divisors 和 @chap:hyperelliptic-curves，了解魏尔配对、Tate-Lichtenbaum 配对以及超椭圆曲线的相关内容。但当然，任何真正专注于密码学应用的专家，多少也会对椭圆曲线在数论中的用途感到好奇。同样地，不关注实际应用的读者也可以跳过 @chap:the-discrete-logarithm-problem 至 @chap:other-applications，直接进入 @chap:elliptic-curves-over-Q。但事实上，密码学应用本身也颇具趣味，并且提供了理论如何实际运用的范例。

关于椭圆曲线的优秀著作在文献中已有多种。本书并无意取代 Silverman 所著的两卷经典作品 @ref:silverman1986arithmetic、@ref:silverman1994advancedtopics，后者已成为椭圆曲线数论方面的标准参考资料。相反，本书从更基础的视角出发，涵盖了部分相同内容，并加入了对密码学应用的讨论。我们希望读者在阅读本书之后，能更容易理解 Silverman 的著作，并欣赏其略显进阶的处理方式。对于更偏解析方法的椭圆曲线算术研究，建议参考 Knapp @ref:knapp1992elliptic 和 Koblitz @ref:koblitz1993ellipticmodular 的著作，它们在这方面的处理比本书或 Silverman 的 @ref:silverman1986arithmetic 更为深入。在椭圆曲线密码学方面，Blake 等人近期的著作 @ref:blake2000elliptic 提供了多个算法的更详尽细节，尽管其中几乎没有证明，仍是学习椭圆曲线密码学的重要资料。本书旨在为理解该书中所用的数学提供良好的入门与解释。此外，Enge @ref:enge1999elliptic、Koblitz @ref:koblitz1998algebraiccrypto、@ref:koblitz1994course 以及 Menezes @ref:menezes1993eccpubkey 等人的著作也从密码学角度探讨了椭圆曲线，值得深入阅读。

#note(variant: "符号说明")[
  符号 $ZZ, FF_q, QQ, RR, CC$ 分别表示整数集、有 $q$ 个元素的有限域、有理数域、实数域和复数域。我们使用 $ZZ_n$（而不是 $ZZ \/ n ZZ$）来表示模 $n$ 的整数集。然而，当 $p$ 是质数，并且我们将 $ZZ_p$ 视为域而不是作为群或环来使用时，我们使用 $FF_p$ 这个记号，以与 $FF_q$ 的记法保持一致。注意，$ZZ_p$ 并不表示 $p$ 进整数。我们之所以这样选用，主要出于排版的考虑，因为模 $p$ 的整数频繁出现，而 $p$ 进整数的符号仅在 @chap:hyperelliptic-curves 的少数几个例子中出现（其中我们用 $cal(O)_p$ 表示）。$p$ 进有理数表示为 $QQ_p$。

  如果 $K$ 是一个域，那么 $overline(K)$ 表示其代数闭包。如果 $R$ 是一个环，则 $R^times$ 表示 $R$ 中的可逆元素。当 $K$ 是域时，$K^times$ 因此表示 $K$ 的非零元素所构成的乘法群。在全书中，字母 $K$ 和 $E$ 通常分别用来表示一个域和一条椭圆曲线（但在 @chap:elliptic-curves-over-C 中，$K$ 有几处用来表示椭圆积分）。
]

#note(variant: "致谢")[
  作者感谢 CRC Press 的 Bob Stern 提议撰写本书并给予鼓励，也感谢 CRC Press 编辑团队在本书准备过程中提供的帮助。Ed Eikenberg、Jim Owings、Susan Schmoyer、Brian Conrad 和 Sam Wagstaff 提出了许多建议，使得手稿得到了极大的改进。当然，仍有提升的空间。欢迎将建议和勘误发送至 #link("mailto:lcw@math.umd.edu")[作者邮箱]。勘误列表将发布在 #link("www.math.umd.edu/~lcw/ellipticcurves.html")[本书的网站] 上。

]

= 第二版前言

读者在阅读第二版前言时最常提出的问题就是“有什么新内容”，主要增加了以下内容：

+ 新增关于同源映射的章节

+ 新增关于双曲线的章节，该主题在许多领域，尤其是密码学中日益受到关注

+ 新增对替代坐标系（如射影坐标、Jacobian 坐标、Edwards 坐标）及其相关计算问题的讨论

+ 对 Weil 配对 和 Tate-Lichtenbaum 配对 提供更完整的处理，包括 Tate-Lichtenbaum 配对的初等定义、其非退化性的证明，以及 Weil 配对两种常见定义相等的证明

+ 加入 Doud 提出的用于计算有理数域上椭圆曲线挠点的解析方法

+ 补充了一些用于确定有限域上椭圆曲线点群的新技术

+ 新增关于如何在一些流行的计算机代数系统中进行椭圆曲线计算的讨论

+ 增加了若干新习题

我要感谢许多人，特别是 Susan Schmoyer、Juliana Belding、Tsz Wo Nicholas Sze、Enver Ozdemir、Qiao Zhang 和 Koichiro Harada，他们提出了许多有益的建议。许多读者对第一版提供了意见和勘误，我们对此深表感激。我们已将其中大部分内容纳入本版。当然，我们也欢迎对本版 #link("mailto:lcw@math.umd.edu")[提出意见和勘误]。相关更正将会列在 #link("https://math.umd.edu/~lcw/ellipticcurves.html")[本书的网站] 上。#footnote("译者注：中文版将遵从该网址的勘误更新，并以醒目的方式标注")

= 读者建议

本书面向至少两类读者。一类是希望了解椭圆曲线的计算机科学家和密码学家，另一类是希望了解椭圆曲线的数论与几何的数学家。当然，这两类人群之间有一定的重叠。作者自然希望读者能通读全书，但对于只希望从部分章节入手的读者，提出以下阅读建议：

所有读者：@chap:introduction、@chap:the-basic-theory、@chap:torsion-points 和 @chap:elliptic-curves-over-finite-fields 提供了该主题的基础介绍，所有人都应阅读这些章节。

#enum(
  numbering: "I.",

  enum.item[密码学路径：继续阅读 @chap:the-discrete-logarithm-problem、@chap:elliptic-curves-cryptography、@chap:other-applications，然后跳转到 @chap:divisors 和 @chap:hyperelliptic-curves。],

  enum.item[数论路径：阅读 @chap:elliptic-curves-over-Q、@chap:elliptic-curves-over-C、@chap:complex-multiplication、@chap:divisors、@chap:isogenies、@chap:zeta-functions、@chap:fermat-last-theorem，之后建议回头阅读先前跳过的章节，以了解该领域在实际应用中的用法。],

  enum.item[复分析路径：阅读 @chap:elliptic-curves-over-C、@chap:complex-multiplication 以及 @sec:complex-theory。],
)
/// END: Front matter

/// START: TOC
#pagebreak()
#set text(size: 11pt)
#outline(title: [目录 <toc>], indent: 2em)
#set text(size: 13pt)
/// END: TOC

/// START: Main matter setup
#set page(numbering: "1", header: context {
  if calc.odd(here().page()) {
    return align(right, emph(hydra(1)))
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
  #counter(math.equation).update(0)
  #counter(figure.where(kind: image)).update(0)
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
/// END: Main matter setup

/// START: Chapter
= 引入 <chap:introduction>

假定有一堆球形炮弹以金字塔的形状堆放，并顶层有一颗，第二层有四颗，第三层有九颗，依此类推。如果这堆炮弹倒塌，是否有可能将这些炮弹重新排列成为一个正方形？

#figure(caption: "炮弹金字塔")[
  #image(svg-colorize("/assets/A Pyramid of Cannonballs.svg", colors.text), width: 24em)
]

如果金字塔有三层的话，那么这是做不到的，因为这一共有 $1 + 4 + 9 = 14$ 颗炮弹，而这不是一个完全平方数。当然，如果只有一颗球，它能构筑起一个一层高的金字塔，同时也是一个 $1 times 1$ 的正方形。如果没有球，那我们就有一个零层高的金字塔和一个 $0 times 0$ 的正方形。除了这些显然的情况外，还有其他的吗？我们提议使用一个可以追溯到丢番图时期（约公元前 250 年）的数学方法来找到另一个解。

设金字塔高 $x$，那么一共有 $ 1^2 + 2^2 + 3^3 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 颗球（见 @exercise:1-1）。我们期望这是一个完全平方数，也就是我们想要找到关于正整数 $x, y$ 的方程 $ y^2 = frac(x(x + 1)(2x + 1), 6) $ 的解。这样的方程给出了一个 *椭圆曲线*。图像如 @fig:pyramid-elliptic-curve 所示。

#figure(caption: $y^2 = x(x + 1)(2x + 1) \/ 6$)[
  #cetz.canvas(length: 6em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

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

丢番图的方法使用我们已经知道的点来构造新的点。让我们从点 $(0, 0)$ 和 $(1, 1)$ 开始。过该两点的直线方程是 $y = x$，联立曲线方程可以得到 $ x^2 = frac(x(x + 1)(2x + 1), 6) = frac(1, 3) x^3 + frac(1, 2) x^2 + frac(1, 6) x $

整理得到 $ x^3 - frac(3, 2) x^2 + frac(1, 2) x = 0 $

幸运的是，我们已经知道了该方程的两个根 $x = 0$ 和 $x = 1$。这是因为这些根就是直线与曲线的交点的横坐标。我们可以通过因式分解这个多项式来找到第三个根，但有一个更好的方法。注意到对任意的数 $a, b, c$ 都有 $ (x - a)(x - b)(x - c) = x^3 - (a + b + c) x^2 + (a b + a c + b c) x - a b c $ 因此当 $x^3$ 的系数为 $1$ 时，$x^2$ 系数的负值就是所有根的和。

在我们这种情况下，我们有根 $0, 1$ 和 $x$，因此 $ 0 + 1 + x = frac(3, 2) $ 解得 $x = 1 \/ 2$。又因为 $y = x$，所以我们也得到 $y = 1 \/ 2$。很难说这对一堆炮弹有什么实际意义，但至少我们找到了这条曲线上的另外一个点。实际上我们因曲线的对称性还自动获得到了另一个点，也就是 $(1 \/ 2, -1 \/ 2)$。

让我们使用点 $(1 \/ 2, -1 \/ 2)$ 和 $(1, 1)$ 重复上述步骤。为什么使用这些点？因为我们正在寻找落在第一象限的交点，而经过这两个点的直线似乎是最合适的选择。很容易得到直线方程为 $y = 3x - 2$，联立曲线方程可以得到 $ (3x - 2)^2 = frac(x(x + 1)(2x + 1), 6) $ 整理得到 $ x^3 - frac(51, 2) x^2 + dots.c = 0 $（使用上述技巧，我们不需要求出低阶）我们已经知道了两个根 $x = 1 \/ 2$ 和 $x = 1$，因此 $ frac(1, 2) + 1 + x = frac(51, 2) $ 解得 $x = 24$。因为 $y = 3x - 2$，所以 $y = 70$。这意味着 $ 1^2 + 2^2 + 3^2 + dots.c + 24^2 = 70^2 $ 如果我们有 4900 个炮弹，我们就可以将它们排列成高为 24 的金字塔，或者一个 $70 times 70$ 的正方形。如果我们继续重复上述步骤，就比如我们使用刚刚得到的点作为我们其一的点，我们将得到这个方程的无穷多个有理数解。然而，可以证明在正整数解中，除了 $x = 1$ 的那个平凡解外，$(24, 70)$ 是这个问题的唯一非平凡解。这需要更加高深的技巧，故在此隐去细节，见 @ref:anglin1990puzzle。

这还有另一个丢番图方法的示例 —— 是否存在一个直角三角形三条都是有理边，且面积为 5？最小的毕达哥拉斯三元组是 $(3, 4, 5)$，面积为 6，所以我们知道我们不能只把注意力放在整数上。现在再来看看边为 $(8, 15, 17)$ 的三角形，它的面积为 60。如果我们将边除以 2，我们得到一个边为 $(4, 15 \/ 2, 17 \/ 2)$ 的面积为 15 的三角形。所以有可能得到一个边不是整数，但面积是整数的三角形。

#figure(caption: "面积为 5 的有理边三角形")[
  #cetz.canvas(length: 2.5em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ a $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ b $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ c $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-abc>

令我们所找的三角形三条边为 $a, b, c$，如 @fig:triangle-area-5-with-abc 所示。因为面积 $a b \/ 2 = 5$，我们所找的有理数 $a, b, c$ 就有 $ a^2 + b^2 = c^2 quad quad a b = 10 $ 简单的变形得到 $ (frac(a + b, 2))^2 = frac(a^2 + 2a b + b^2, 4) = frac(c^2 + 20, 4) = (frac(c, 2))^2 + 5 \ (frac(a - b, 2))^2 = frac(a^2 - 2a b + b^2, 4) = frac(c^2 - 20, 4) = (frac(c, 2))^2 - 5 $ 令 $x = (c \/ 2)^2$，得到 $ x - 5 = (frac(a - b, 2))^2 quad quad x + 5 = (frac(a + b, 2))^2 $ 因此，我们正在寻找一个有理数 $x$，使得 $ x − 5 quad quad x quad quad x + 5 $ 都是有理数的平方。换句话说，我们希望三个有理数的平方构成一个公差为 5 的等差数列。

假设我们能找到这样的 $x$，那么它们的乘积 $(x - 5)(x)(x + 5) = x^3 - 25x$ 也将必是一个有理数的平方，所以我们需要找方程 $ y^2 = x^3 - 25x $ 的有理解。

正如上面所说的，这是椭圆曲线的方程。当然，即使我们找到了一个这样的有理数解，也不能保证它对应一个有理边三角形（见 @exercise:1-2）。不过，一旦我们找到了一个满足 $y != 0$ 的有理数解，就可以利用它构造出另一个确实对应有理边三角形的解（见 @exercise:1-2）。这正是我们接下来要做的事情。

以备未来需要，我们记 $ x = (c/2)^2 quad quad y = sqrt((x - 5)(x)(x + 5)) = frac((a - b)(c)(a + b), 8) = frac((a^2 - b^2) c, 8) $

该曲线上有三个“显然”的点：$(-5, 0), (0, 0), (5, 0)$，这些点对我们帮助不大。它们不能构成三角形，并且连接其中任意两个点的直线都会与曲线在剩下的那点相交。简单搜索我们可以找到点 $(-4, 6)$，然而这个点与上述三个点任一的连线都无法给出有效的信息。唯一剩下的可能就是考虑过点 $(-4, 6)$ 与它自身，也就是曲线在这点的切线。隐函数求导可得 $ 2y y' = 3x^2 - 25 quad quad y' = frac(3x^2 - 25, 2y) = 23/12 $

因而切线方程为 $ y = 23/12 x + 41/3 $

与曲线联立得 $ (23/12 x + 41/3)^2 = x^3 - 25x $

整理得到 $ x^3 - (23/12)^2 x^2 + dots.c = 0 $

因为该直线是过点 $(-4, 6)$ 的切线，所以根 $x = -4$ 是重根，因而根的和为 $ -4 - 4 + x = (23/12)^2 $

解得 $x = 1681 \/ 114 = (41 \/ 12)^2$，再由直线方程可得 $y = 62279 \/ 1728$。

因为 $x = (c \/ 2)^2$，所以 $c = 41 \/ 6$，因此 $ 62279/1728 = y = frac((a^2 - b^2)c, 8) = frac(41(a^2 - b^2), 48) $

因此 $ a^2 - b^2 = 1519/36 $

又因为 $ a^2 + b^2 = c^2 = (41/6)^2 $

我们解得 $a^2 = 400 \/ 36$ 和 $b^2 = 9 \/ 4$，于是我们得到一个面积为 5 的有理边三角形（见 @fig:triangle-area-5-with-num），其边长分别为 $ a = 20 / 3 quad quad b = 3 / 2 quad quad c = 41 / 6 $

当然，这是由边为 $(40, 9, 41)$ 的三角形缩小 6 倍得到的。

#figure(caption: "面积为 5 的有理边三角形")[
  #cetz.canvas(length: 2.5em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    line((0, 0), (20 / 3, 0), name: "a")
    content("a", $ 20 / 3 $, anchor: "north", padding: .1)
    line((20 / 3, 0), (20 / 3, 3 / 2), name: "b")
    content("b", $ 3 / 2 $, anchor: "west", padding: .1)
    line((20 / 3, 3 / 2), (0, 0), name: "c")
    content("c", $ 41 / 6 $, anchor: "south-east", padding: .1)
  })
] <fig:triangle-area-5-with-num>

实际上还有无穷多的其他解，可由不断重复上述步骤得到。比如就使用我们刚刚发现的点（见 @exercise:1-4）。

哪些整数 $n$ 能作为具有有理数边的直角三角形的面积，这个问题被称为 *同余数问题*。如我们上面所看到的另一种表述方式就是：是否存在三个有理数平方数构成公差为 $n$ 的等差数列。这一问题最早出现在大约公元 900 年左右的阿拉伯手稿中。Tunnell 在 20 世纪 80 年代对该问题提出了一个猜想性答案，并加以证明 @ref:tunnell1983diophantine。

我们知道，如果一个整数 $n$ 不是除了 1 以外的任何完全平方数的倍数，那么就称 $n$ 是无平方因子数。例如，5 和 15 是无平方因子数，而 24 和 75 不是。

#conjecture[
  设 $n$ 是一个正奇无平方因子数。则当且仅当满足以下条件时，$n$ 可以表示为有理边直角三角形的面积：

  方程 $ 2x^2 + y^2 + 8z^2 = n $ 的整数解中，满足 $z$ 为偶数的解的个数等于满足 $z$ 为奇数的解的个数。

  若 $n = 2m$，其中 $m$ 是正奇无平方因子数，则当且仅当满足以下条件时，$n$ 可以表示为有理边直角三角形的面积：

  方程 $ 4x^2 + y^2 + 8z^2 = m $ 的整数解中，满足 $z$ 为偶数的解的个数等于满足 $z$ 为奇数的解的个数。
]

Tunnel @ref:tunnell1983diophantine 证明了该猜想的充分性：如果存在一个面积为 $n$ 的直角三角形，则满足奇数解的个数等于偶数解的个数。然而，必要性 —— 即“解的个数条件成立则必定存在面积为 $n$ 的直角三角形”—— 依赖于尚未被证明的 Birch 和 Swinnerton-Dyer 猜想（见 @chap:zeta-functions）。

比如考虑 $n = 5$，此时没有满足 $2x^2 + y^2 + 8z^2 = 5$ 的整数解，故 $0 = 0$，条件显然成立，于是预测存在面积为 5 的有理边直角三角形。再考虑 $n = 1$，此时 $2x^2 + y^2 + 8z^2 = 1$ 的整数解为 $(0, 1, 0)$ 和 $(0, -1, 0)$，两者都是 $z$ 为偶数，故由 $2 != 0$ 得不存在面积为 1 的有理边直角三角形。这最早由费曼通过它的无穷下降法证明（见 @sec:fermat-infinite-descent）。

举一个非平凡的示例，考虑 $n = 41$。方程 $2x^2 + y^2 + 8z^2 = 41$ 的整数解为

$
  (plus.minus 4, plus.minus 3, 0) quad (plus.minus 4, plus.minus 1, plus.minus 1) quad (plus.minus 2, plus.minus 5, plus.minus 1) quad (plus.minus 2, plus.minus 1, plus.minus 2) quad (0, plus.minus 3, plus.minus 2)
$

（所有加减号的组合均允许）。一共有 32 个解，其中 $z$ 为偶数的有 16 个，$z$ 为奇数的也有 16 个。因此，我们预期存在面积为 41 的有理边直角三角形。按照前文提到的方法，利用曲线 $y^2 = x^3 - 41^2 x$ 上点 $(-9, 120)$ 处的切线，可以得到边长为 $(40 \/ 3, 123 \/ 20, 881 \/ 60)$ 的直角三角形，其面积为 41。

关于同余数问题的更多内容，见 @ref:koblitz1993ellipticmodular。

最后，让我们考虑费马四次方程。我们想证明 $ a^4 + b^4 = c^4 $ <eq:quartic-fermat-equation> 在 $a, b, c$ 为非零整数时无解。这个方程是费马大定理中最简单的一种情形。该定理断言：当 $n >= 3$ 时，两个非零整数的 $n$ 次幂之和不可能是另一个非零整数的 $n$ 次幂。这个一般性的结论由 Wiles 在 1994 年证明，他结合了 Frey、Ribet、Serre、Mazur、Taylor 等人的工作，使用了椭圆曲线的性质。我们将在 @chap:fermat-last-theorem 讨论这些思想，但现在我们将目光集中在 $n = 4$ 这个简单得多的情形。这个情形下的第一个证明归功于费马本人。

假设存在非零整数 $a$ 使得 $a^4 + b^4 = c^4$。令 $ x = 2 frac(b^2 + c^2, a^2) quad quad y = 4b frac(b^2 + c^2, a^3) $

（见 @example:quartic-to-weierstrass）。直接计算可得：$ y^2 = x^3 - 4x $

在 @chap:elliptic-curves-over-Q 我们将证明，这个方程的所有有理数解为 $ (x, y) = (0, 0), (2, 0), (-2, 0) $

这些解都对应于 $b = 0$，因此 @eq:quartic-fermat-equation 没有非平凡的整数解。

三次费马方程也可以转换为椭圆曲线。假设 $a^3 + b^3 = c^3$ 且 $a b c != 0$，由于 $a^3 + b^3 = (a + b)(a^2 - a b + b^2)$，我们必须有 $a + b != 0$。令 $ x = 12 frac(c, a + b) quad quad y = 36 frac(a - b, a + b) $

那么可以得到：$ y^2 = x^3 - 432 $

（这个变量代换从哪里来的？见 @subsec:cubic-equations）

可以证明（但这并不容易）这个方程的唯一有理数解为 $(x, y) = (12, plus.minus 36)$。

当 $y = 36$ 时，$a - b = a + b$，得到 $b = 0$；当 $y = -36$ 时，$a = 0$。

因此，当 $a b c != 0$ 时，方程 $a^3 + b^3 = c^3$ 没有整数解。

#pagebreak()
#heading(numbering: none, level: 2)[练习]

#exercise[
  使用数学归纳法证明 $ 1^2 + 2^2 + 3^2 + dots.c + x^2 = frac(x(x + 1)(2x + 1), 6) $ 对于所有的正整数 $x$ 都成立。
] <exercise:1-1>

#exercise[
  + 证明若 $x, y$ 是满足 $y^2 = x^3 - 25x$ 的有理数，且 $x$ 是一个有理数的平方，则这无法推出 $x + 5$ 和 $x - 5$ 都是有理数的平方。

  + $n$ 为整数，证明若 $x, y$ 是满足 $y^2 = x^3 - n^2x$ 的有理数，且 $x != 0, plus.minus n$，那么在曲线上作点 $(x, y)$ 的切线与曲线的交点 $(x_1, y_1)$ 满足 $x_1, x_1 - n, x_1 + n$ 都是有理数的平方。（更一般的见定理 8.14）这说明如果我们能找到一个起始点使得 $x != 0, plus.minus n$，那么使用文中的方法就一定能构造出一个面积为 $n$ 的有理边三角形。 /// TODO: Ref to Theorem 8.14
] <exercise:1-2>

#exercise[
  盘丢图并没有使用解析几何，更不可能知道如何使用隐函数求导来求切线的斜率。以下是他如何求出过点 $(-4, 6)$ 的 $y^2 = x^3 - 25x$ 的切线方程的。看起来，丢番图只是将其视作一个代数技巧。而牛顿似乎是第一个认识到这与求切线有关的人。

  + 令 $x = -4 + t, y = 6 + m t$ 并将这两个表达代入方程 $y^2 = x^3 - 25x$，这将得到一个关于 $t$ 的三次方程，且该方程以 $t = 0$ 为一个根。

  + 证明当取 $m = 23 \/ 12$ 时，$t = 0$ 是一个重根。

  + 求出该三次方程的另一个非零根 $t$，并据此计算得到 $ x = 1681/144 quad quad y = 62279/1728 $
] <exercise:1-3>

#exercise[
  使用过点 $(x, y) = (1681 \/ 114, 62279 \/ 1728)$ 的切线找到另一个面积为 5 的直角三角形。

] <exercise:1-4>
/// END: Chapter

/// START: Chapter
= 理论基础 <chap:the-basic-theory>

== Weierstrass 方程

在本书的大多数情形中，椭圆曲线 $E$ 是形如 $ y^2 = x^3 + A x + B $ 的方程图像，其中 $A$ 和 $B$ 是常数。这个形式被称为 *椭圆曲线的 Weierstrass 方程*。我们需要明确 $A, B, x$ 和 $y$ 分别属于哪个集合。通常，它们被看作某个域中的元素，例如实数域 $RR$、复数域 $CC$、有理数域 $QQ$、有限域 $FF_p (= ZZ_p)$，其中 $p$ 为质数，或更一般的有限域 $FF_q$，其中 $q = p^k$ 且 $k >= 1$。事实上，在本书几乎所有地方，如果读者对域这个概念不熟悉，也可以直接将其理解为上述这些常见的域之一即可。如果 $K$ 是一个域，且 $A, B in K$，那么我们说椭圆曲线 $E$ 是 *定义在* $K$ *上的*。在本书中，$E$ 和 $K$ 一般默认表示一个椭圆曲线及其定义所在的域。

如果我们希望讨论定义在某个扩域 $L supset.eq K$ 上的点，我们记作 $E(L)$。按照定义，这个集合总是包含一个将在本节后面定义的特殊点 $infinity$：

$ E(L) = {infinity} union {(x, y) in L times L divides y^2 = x^3 + A x + B} $

对于大多数域而言，无法画出直观的椭圆曲线图像。然而，为了形成直觉，考虑定义在实数域 $RR$ 上的曲线图像是很有帮助的。它们有两种基本形状，如 @fig:elliptic-curves-shapes 所示：

#subpar.grid(
  caption: "椭圆曲线的两种基本形状",
  columns: (1fr, 1fr),
  label: <fig:elliptic-curves-shapes>,
  supplement: "图",
  numbering: num => (
    numbering("1-1", counter(heading).get().first(), num)
  ),
  numbering-sub: "(1)  ",
  numbering-sub-ref: (a, b) => (
    numbering("1-1-1", counter(heading).get().first(), a, b)
  ),
  figure(
    cetz.canvas(length: 3em, {
      import cetz.draw: *
      set-style(stroke: (paint: colors.text, thickness: 0.5pt))

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

      line((-1.05, 0), (2, 0))
      line((0, -2.5), (0, 2.5))
    }),
    caption: $y^2 = x^3 - x$,
  ),
  <subfig:elliptic-curves-shapes-1>,

  figure(
    cetz.canvas(length: 3em, {
      import cetz.draw: *
      set-style(stroke: (paint: colors.text, thickness: 0.5pt))

      let y(x) = {
        let y2 = x * x * x + x
        if y2 < 0 { return () }
        let y = calc.sqrt(y2)
        return ((x, y), (x, -y))
      }

      for i in range(0, 160) {
        let p = y(i / 100)
        let p2 = y((i + 1) / 100)
        if p.len() == 0 or p2.len() == 0 { continue }
        line(p.at(0), p2.at(0))
        line(p.at(1), p2.at(1))
      }

      line((-0.05, 0), (2, 0))
      line((0, -2.5), (0, 2.5))
    }),
    caption: $y^2 = x^3 + x$,
  ),
  <subfig:elliptic-curves-shapes-2>,
)

第一种情况下，方程 $y^2 = x^3 - x$ 的三次项有三个不相等的实数根。第二种情况下，方程 $y^2 = x^3 + x$ 只有一个实根。

那么，如果存在重根会发生什么呢？我们不允许这种情况发生。也就是说，我们假定 $ 4A^3 + 27B^2 != 0 $

若三次多项式 $x^3 + A x + B$ 的根为 $r_1, r_2, r_3$，则可以证明其判别式为 $ ((r_1 - r_2)(r_1 - r_3)(r_2 - r_3))^2 = - (4A^3 + 27B^2) $

因此，三次方程的根必须是互不相同的。然而，当根不互异时的情形依然很有趣，我们将在 @sec:singular-curves 中讨论这一情况。

为了获得更多的灵活性，我们还允许使用更一般形式的方程 $ y^2 + a_1 x y + a_3 y = x^3 + a_2 x^2 + a_4 x + a_6 $ <eq:generalized-weierstrass-equation> 其中 $a_1, dots.c, a_6$ 是常数。这个更一般的形式（我们称之为 *广义 Weierstrass 方程*）在处理特征为 2 或 3 的域时非常有用。如果域的特征不是 2，我们可以对 $y$ 完全平方，做如下变形：

$
  (y + frac(a_1 x, 2) + frac(a_3, 2))^2 =
  x^3 + (a_2 + frac(a_1^2, 4)) x^2
  + (a_4 + frac(a_1 a_3, 2)) x
  + (frac(a_3^2, 4) + a_6)
$

这可以写成 $ y_1^2 = x^3 + a'_2 x^2 + a'_4 x + a'_6 $

其中 $y_1 = y + a_1 x \/ 2 + a_3 \/ 2$，$a'_2, a'_4, a'_6$ 是某些新的常数。如果域的特征还不是 3，我们可以令 $x_1 = x + a'_2 \/ 3$，从而得到 $ y_1^2 = x_1^3 + A x_1 + B $ 其中 $A$、$B$ 为某些常数。

在本书的大部分内容中，我们将使用 Weierstrass 方程建立理论，在某些情况下指出在特征为 2 和 3 的情形下应作的修改。在 @sec:elliptic-curves-in-characteristic-2 中，我们将更详细地讨论特征为 2 的情形，因为普通 Weierstrass 方程在这种情形下不再适用。相反，对于形如 $y^2 = x^3 + A x + B$ 的曲线，在特征为 3 的情况下，这些公式依然成立，但也存在不符合此形式的曲线。特征为 3 的一般情形可以通过处理形如 $y^2 = x^3 + C x^2 + A x + B$ 的曲线来实现。

最后，假设我们从如下方程出发 $ c y^2 = d x^3 + a x + b $

其中 $c, d != 0$。我们将该式两边乘以 $c^3 d^2$，得到 $ (c^2 d y)^2 = (c d x)^3 + (a c^2 d)(c d x) + (b c^3 d^2) $

替换变量 $ y_1 = c^2 d y quad quad x_1 = c d x $

得到的便是 Weierstrass 形式的方程。

本章稍后还会出现一些其他类型的方程，它们可以变换为 Weierstrass 形式，在特定语境下非常有用。

出于技术需要，在椭圆曲线上添加一个无穷远点是有益的。在 @sec:projective-space-and-the-point-at-infinity 我们将对这一概念进行严格定义。但现在，我们可以将其视为一个形式点 $(infinity, infinity)$，通常简写为 $infinity$，位于 $y$ 轴的顶端。从计算角度看，$infinity$ 是一个形式符号，满足某些计算规则。例如，若称一条直线通过 $infinity$，则当且仅当它是竖直线（即 $x =$ 常数）。这个 $infinity$ 点也许看起来不自然，但我们将看到，引入它带来了很多便利。

我们还约定，$infinity$ 不仅在 $y$ 轴的顶端，也在底端。换言之，我们设想 $y$ 轴两端“缠绕”并在背面于 $infinity$ 相遇。这看似奇怪，但当工作在非实数域（如有限域）时，元素通常没有自然的顺序，这种“上下”的区分就失去了意义。在 @sec:projective-space-and-the-point-at-infinity 引入射影坐标之后，这种情况将被严谨处理。因此，最好的做法是将 $infinity$ 视为满足某些代数规则的形式符号。此外，我们约定两条竖直线在 $infinity$ 处相交。出于对称性考虑，如果它们在 $y$ 轴顶端相交，也应在底端相交。但两条直线应只在一点相交，因此“顶端的 $infinity$”与“底端的 $infinity$”必须视为同一个点。这将成为 $infinity$ 的一个非常有用的性质。

== 群律 <sec:group-law>

正如我们在 @chap:introduction 看到的，我们可以从椭圆曲线上的两个点，甚至是一个点，构造出另一个点。现在我们来更深入地分析这个过程。

#figure(caption: "椭圆曲线上的点加法")[
  #cetz.canvas(length: 1.19em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    let y(x) = {
      let y2 = x * x * x - x + 6
      if y2 < 0 { return () }
      let y = calc.sqrt(y2)
      return ((x, y), (x, -y))
    }

    for i in range(-200, 250) {
      let p = y(i / 100)
      let p2 = y((i + 1) / 100)
      if p.len() == 0 or p2.len() == 0 { continue }
      line(p.at(0), p2.at(0))
      line(p.at(1), p2.at(1))
    }

    line((-3, -1.5), (2.5, 4))
    circle((-1.978908, -0.478908), name: "P1", radius: 0)
    content("P1", $ P_1 $, anchor: "north-west")
    circle((0.920693, 2.420693), name: "P2", radius: 0)
    content("P2", $ P_2 $, anchor: "north", padding: .3)
    circle((2.058215, 3.558215), name: "P'3", radius: 0)
    content("P'3", $ P'_3 $, anchor: "west", padding: .3)
    circle((2.058215, -3.558215), name: "P3", radius: 0)
    content("P3", $ P_3 $, anchor: "west", padding: .3)

    line((2.058215, 4.75), (2.058215, -4.75), stroke: (dash: "dashed"))

    line((-3, 0), (3, 0))
    line((0, -5), (0, 5))
  })
] <fig:elliptic-curve-point-addition>

从椭圆曲线 $E: y^2 = x^3 + A x + B$ 上两点 $ P_1 = (x_1, y_1) quad quad P_2 = (x_2, y_2) $ 开始。我们按以下步骤计算 $P_3$：连接 $P_1$ 和 $P_2$ 得到直线 $L$，与曲线相交新的点 $P'_3$，以 $x$ 轴为对称轴翻转点 $P'_3$（也就是改变 $y$ 坐标符号）得到点 $P_3$。我们定义 $ P_1 + P_2 = P_3 $

下面的示例将表明，这种操作并不等同于将两个点的坐标直接相加。也许用 $P_1 +_E P_2$ 这样的记号来表示这种运算会更恰当，但我们选择更简洁的记号，因为我们从不会通过坐标相加的方式来进行点的加运算。

假定 $P_1 != P_2$，且两个都不是 $infinity$，连接 $P_1$ 和 $P_2$ 的直线斜率为 $ m = frac(y_1 - y_2, x_2 - x_1) $ 如果 $x_1 = x_2$，那么 $L$ 是竖直的。我们之后再讨论这种情形，所以先假设 $x_1 != x_2$。那么 $L$ 的方程为 $ y = m (x - x_1) + y_1 $

为了找到与 $E$ 的交点，代入得到 $ (m (x - x_1) + y_1)^2 = x^3 + A x + B $ 整理得到如下形式 $ 0 = x^3 - m^2 x^2 + dots.c $

三次方程的三个根对应于直线 $L$ 与椭圆曲线 $E$ 的三个交点。一般而言，求解一个三次方程并不容易，但在这里我们已经知道两个根 $x_1$ 和 $x_2$，因为点 $P_1$ 和 $P_2$ 同时在 $L$ 和 $E$ 上。因此，我们可以通过因式分解来求出第三个 $x$ 坐标值，但其实还有更简单的方法。就像 @chap:introduction 所述，若三次多项式 $x^3 + a x^2 + b x + c$ 根为 $r, s, t$，则 $ x^3 + a x^2 + b x + c = (x - r)(x - s)(x - t) = x^3 - (r + s + t) x^2 + dots.c $

因此 $ r + s + t = -a $

如果已知两个根 $r, s$，就可以得到第三个根 $t = -a - r - s$，在我们的情形中，这意味着 $ x = m^2 - x_1 - x_2 $ 并且 $ y = m (x - x_1) + y_1 $

最后关于 $x$ 轴翻转得到点 $P_3 = (x_3, y_3)$ 有 $ x_3 = m^2 - x_1 - x_2 quad quad y_3 = m (x_1 - x_3) - y_1 $

若 $x_1 = x_2$ 但 $y_1 != y_2$，说明通过 $P_1$ 和 $P_2$ 的直线是竖直的，它与曲线 $E$ 的交点是 $infinity$。将 $infinity$ 关于 $x$ 轴翻转仍为 $infinity$（这也是我们将 $infinity$ 放在 $y$ 轴顶端与底端的原因）。因此，在这种情况下 $P_1 + P_2 = infinity$。

现在考虑 $P_1 = P_2 = (x_1, y_1)$ 的情况。当两点非常接近时，它们之间的连线趋近于切线，所以在它们完全重合时，我们取过该点的切线作为 $L$。通过隐函数求导我们可以计算出切线的斜率 $m$：$ 2y frac("d"y, "d"x) = 3x^2 + A quad "因此" quad m = frac("d"y, "d"x) = frac(3x_1^2 + A, 2y_1) $

如果 $y_1 = 0$，那么直线是竖直线，我们记 $P_1 + P_2 = infinity$，与之前相同。（技术细节：若 $y_1 = 0$，则分子 $3x_1^2 + A != 0$，见 @exercise:2-5）因此假定 $y_1 != 0$，直线 $L$ 的方程和前文一样为 $ y = m (x - x_1) + y_1 $

我们可以得到 $ 0 = x^3 - m^2 x^2 + dots.c $ 这次我们只知道一个根 $x_1$，但因为 $L$ 是 $E$ 在点 $P_1$ 处的切线，所以 $x_1$ 是一个重根。因此重复上文的过程，我们可以得到 $ x_3 = m^2 - 2 x_1 quad quad y_3 = m (x_1 - x_3) - y_1 $

最后，假定 $P_2 = infinity$，那么经过 $P_1$ 和 $infinity$ 的直线是竖直的，交 $E$ 于 $P_1$ 关于 $x$ 轴翻转得到的 $P'_1$ 上。因为 $P_3 = P_1 + P_2$，再次翻转 $P'_1$ 回了 $P_1$。因此 $ P_1 + infinity = P_1 $ 对所有在 $E$ 上的 $P_1$ 都成立。当然，我们将其拓展到 $infinity + infinity = infinity$。

我们将上述讨论总结如下：

#note(title: "群律", sans: true)[
  有椭圆曲线 $E: y^2 = x^3 + A x + B$，令 $P_1 = (x_1, y_1), P_2 = (x_2, y_2)$ 是 $E$ 上的点且 $P_1, P_2 != infinity$。定义 $P_1 + P_2 = P_3 = (x_3, y_3)$ 为：

  + 若 $x_1 != x_2$，则 $ x_3 = m^2 - x_1 - x_2 quad quad y_3 = m (x_1 - x_3) - y_1 quad quad m = frac(y_2 - y_1, x_2 - x_1) $

  + 若 $x_1 = x_2$ 但 $y_1 != y_2$，则 $P_1 + P_2 = infinity$。

  + 若 $P_1 = P_2$ 且 $y_1 != 0$，则 $ x_3 = m^2 - 2 x_1 quad quad y_3 = m (x_1 - x_3) - y_1 quad quad m = frac(3 x_1^2 + A, 2 y_1) $

  + 若 $P_1 = P_2$ 且 $y_1 = 0$，则 $P_1 + P_2 = infinity$。

  此外，定义 $ P + infinity = P $ 对所有 $P in E$ 成立。
]

注意到当 $P_1$ 和 $P_2$ 的坐标属于某个包含 $A$ 和 $B$ 的域 $L$ 时，它们的和 $P_1 + P_2$ 的坐标也属于 $L$。因此，集合 $E(L)$ 在上述点的加法下是封闭的。

这种加法运算乍看之下可能有些不自然。但在 @chap:elliptic-curves-over-C 和 @chap:divisors 中，我们将看到它实际上对应一些非常自然的运算。不过在此之前，我们先来展示它的一些良好性质。

#theorem[
  定义在椭圆曲线 $E$ 上的点的加法满足以下性质：

  + 对所有 $P_1, P_2 in E$，都有 $P_1 + P_2 = P_2 + P_1$（交换律）。

  + 对所有 $P in E$，都有 $P + infinity = P$（单位元的存在性）。

  + 对所有 $P in E$，都存在 $P' in E$ 使得 $P + P' = infinity$。$P'$ 也常被记作 $-P$（逆元的存在性）。

  + 对所有 $P_1, P_2, P_3 in E$，都有 $(P_1 + P_2) + P_3 = P_1 + (P_2 + P_3)$（结合律）。
]

#proof[
  交换律的证明是显然的，因为连接 $P_1$ 和 $P_2$ 的直线与连接 $P_2$ 和 $P_1$ 的直线是同一条直线。 $infinity$ 的单位元性质由其定义直接得出。对于逆元，令 $P'$ 为 $P$ 关于 $x$ 轴的对称点，那么有 $P + P' = infinity$。

  最后我们需要证明结合律。这是椭圆曲线点的加法最微妙，且是最不直观的性质。事实上，可以为椭圆曲线上的点构造许多满足 1. 2. 3. 性质的运算律，这些律可能比我们当前所定义的加法规则更简单或更复杂。然而，这样的运算律极少能满足结合律。实际上，我们所定义的加法居然满足结合律，确实是一个令人惊讶的事实。毕竟，我们是从两个点 $P_1$ 和 $P_2$ 出发，通过某种操作得到第三个点 $P_1 + P_2$，然后再将其与 $P_3$ 相加得到 $(P_1 + P_2) + P_3$。如果我们反过来先计算 $P_2 + P_3$，再与 $P_1$ 相加，得到 $P_1 + (P_2 + P_3)$，乍一看没有任何明显理由表明这两个结果会是相同的点。

  结合律可以通过代入公式直接计算验证。但会遇到多个不同情况，取决于 $P_1 = P_2$、$P_3 = (P_1 + P_2)$ 等是否成立，这会使得证明过程相当繁琐。不过，我们将采用另一种方法，并在 @sec:proof-of-associativity 中给出。
]

#warning[
  对于 Weierstrass 方程，若 $P = (x，y)$，则 $-P = (x，−y)$，对于广义 Weierstrass 方程 @eq:generalized-weierstrass-equation，情况不再如此。如果 $P = (x，y)$ 在 @eq:generalized-weierstrass-equation 描述的曲线上，那么 $ -P =(x，-a_1x -a_3 - y) $（见 @exercise:2-9）。
]

#example[
  @chap:introduction 中的计算现可以解释为椭圆曲线上的点加法。我们在椭圆曲线 $ y^2 = frac(x(x + 1)(2x + 1), 6) $ 上有 $ (0, 0) + (1, 1) = (1/2, -1/2) quad quad (1/2, -1/2) + (1, 1) = (24, -70) $

  在曲线 $ y^2 = x^3 − 25x $ 上有 $ 2(−4, 6) = (−4, 6) + (−4, 6) = (1681/144, − 62279/1728) $

  还有 $ (0, 0) + (−5, 0) = (5, 0) quad quad 2(0, 0) = 2(−5, 0) = 2(5, 0) = infinity $
]

#figure(caption: [定义在 $CC$ 上的椭圆曲线])[
  #image(svg-colorize("/assets/Torus.svg", colors.text), width: 24em)
]

椭圆曲线上的点构成阿贝尔群这一事实，是大多数有趣性质与应用背后的基础。于是就产生了一个问题：我们所得到的这些点群，具有什么样的结构？下面是一些示例：

+ 一个定义在有限域上的椭圆曲线，其在该有限域中的点的个数是有限的。因此，在这种情形下我们得到的是一个有限的阿贝尔群。这类群的性质，以及它们在密码学中的应用，将在后续章节中讨论。

+ 若 $E$ 是定义在有理数域 $QQ$ 上的椭圆曲线，那么 $E(QQ)$ 是一个有限生成的阿贝尔群。这就是 Mordell–Weil 定理，我们将在 @chap:elliptic-curves-over-Q 中给出证明。这样的群与某个形如 $ZZ^r plus.circle F$ 的群同构，其中 $r >= 0$，$F$ 是一个有限群。整数 $r$ 被称为 $E(QQ)$ 的 *秩*。一般来说，确定 $r$ 是一件相当困难的事情，目前尚不清楚 $r$ 是否可以任意大。目前已知存在秩至少为 28 的椭圆曲线。有限群 $F$ 可以通过 @chap:elliptic-curves-over-Q 中的 Lutz–Nagell 定理来容易地计算。此外，Mazur 的一个深刻定理表明：当 $E$ 在所有定义在 $QQ$ 上的椭圆曲线中变化时，$F$ 的可能类型只有有限多种。 /// TODO: Ref to theorems

+ 定义在复数域 $CC$ 上的椭圆曲线同构于一个环面。这一点将在 @chap:elliptic-curves-over-C 中予以证明。环面的常见构造方式是 $ℂ \/ cal(L)$，其中 $cal(L)$ 是复数域中的一个格点。复数的常用加法在商空间 $CC \/ cal(L)$ 上诱导出一个群律，该运算通过环面与椭圆曲线之间的同构对应于椭圆曲线上的群律。

+ 若椭圆曲线 $E$ 定义在实数域 $RR$ 上，那么 $E(RR)$ 同构于单位圆 $S^1$，或同构于 $S^1 plus.circle ZZ_2$。第一种情况对应于三次多项式 $x^3 + A x + B$ 只有一个实根的情形（想象 @subfig:elliptic-curves-shapes-2 中图像的两端在 $infinity$ 处接合，形成一个环）。第二种情况对应于该三次式具有三个实根。@subfig:elliptic-curves-shapes-1 中的闭环曲线就是集合 $S^1 plus.circle {1}$，而那条开口的曲线可以通过加入 $infinity$ 使其闭合，从而得到集合 $S^1 plus.circle {0}$。如果我们有一个定义在 $RR$ 上的椭圆曲线 $E$，我们可以考虑它在复数域上的点集 $E(CC)$。这个集合构成一个环面（如前文 3. 所述）。实点集 $E(RR)$ 是通过将该环面与某个平面相交而得到的。如果这个平面穿过环面中间的洞，我们会得到如 @subfig:elliptic-curves-shapes-1 的曲线；如果没有穿过洞，则得到如 @subfig:elliptic-curves-shapes-2 的曲线（见 @sec:elliptic-curves-over-C-elliptic-curves-over-C）。#footnote[勘误：“实点集 $E(RR)$ 是通过将该环面与某个平面相交而得到的”这句话不准确。如果我们将环面视为在 $CC^2$ 中（即视为 $RR^4$ 中的对象），那么平面 $"Im"(x) = "Im"(y) = 0$ 与环面的交集就是实点集。然而，若将环面放在 $RR^3$ 中情况就不是这样，此时实点集可能对应于环面上的一条或两条不可收缩的圆。第一种情况下这并不是环面与 $RR^3$ 中某个平面的交集。最后一句话“如果没有穿过洞……”也是不正确的。
  ]

如果 $P$ 在椭圆曲线上，且 $k$ 为正整数，那么 $k P$ 表示 $P + P + dots.c + P$（共 $k$ 次加法）。如果 $k < 0$，则 $k P = (-P) + (-P) + dots.c + (-P)$，共 $abs(k)$ 次加法。计算 $k$ 较大时的 $k P$ 反复将 $P$ 与自身相加是低效的，我们可以使用 *连续倍加法*。比如求 $19P$ 时，我们计算 $ 2P quad 4P = 2P + 2P quad 8P = 4P + 4P quad 16P = 8P + 8P quad 19P = 16P + 2P + P $

这种方法使我们能够非常快速地计算 $k P$，即使 $k$ 是非常大的整数。唯一的困难在于：如果我们在有理数域中进行计算，点的坐标会增长得非常快（见定理 8.18）。然而，当我们在有限域中计算，例如在 $FF_p$ 上，这就不是问题，因为我们可以持续地对 $p$ 取模，从而使参与计算的数值保持相对较小。注意到结合律使我们在计算这些加法时无需担心求和顺序。/// TODO: Ref to 8.18

连续倍加法可以一般性地表述如下：

#algorithm[整数与点的乘法][
  令 $P$ 是椭圆曲线上的点，$k$ 是正整数。使用以下步骤可以算出 $k P$。

  + 初始化 $a = k, B = infinity, C = P$

  + 若 $a$ 是偶数，令 $a = a \/ 2$，再令 $B = B, C = 2C$

  + 若 $a$ 是奇数，令 $a = a - 1$，再令 $B = B + C, C = C$

  + 若 $a != 0$，则回到步骤 2

  + 输出 $B$

  输出结果 $B$ 就是 $k P$（见 @exercise:2-8）。
]

另一方面，如果我们在一个大的有限域上进行运算并且给定了点 $P$ 和 $k P$，那么要确定 $k$ 的值是非常困难的。这被称为 *离散对数问题*，它构成了 @chap:elliptic-curves-cryptography 将要讨论的密码学应用的基础。

== 射影空间与无穷远点 <sec:projective-space-and-the-point-at-infinity>

我们都知道，平行线在无穷远处相交。射影空间允许我们为这个说法赋予数学意义，同时也帮助我们解释椭圆曲线上的无穷远点。

设 $K$ 是一个域。定义在 $K$ 上的二维 *射影空间* $PP^2_K$ 是由三元组 $(x, y, z)$ 的等价类给出，其中 $x, y, z in K$，且至少有一个不为零。如果存在 $lambda in K^times$ 使得 $ (x_1, y_1, z_1) = (lambda x_2, lambda y_2, lambda z_2) $ 则称两个三元组 $(x_1, y_1, z_1)$ 和 $(x_2, y_2, z_2)$ 是 *等价* 的，记作 $(x_1, y_1, z_1) ~ (x_2, y_2, z_2)$ 。等价类只与 $x, y, z$ 的比例有关，故使用 $(x : y : z)$ 表示等价类。

当 $z != 0$ 时，$(x : y : z)$ 可归一化为 $(x \/z : y \/z : 1)$，这类点被称为 $PP^2_K$ 中的“有限点”。然而，如果 $z = 0$，则除以 $z$ 应该被认为是在 $x$ 或 $y$ 坐标上得出 $infinity$，因此点 $(x : y : 0)$ 被称为 $PP^2_K$ 中的*“无穷远点”*。椭圆曲线上的无穷远点将很快与 $PP^2_K$ 中的一个无穷远点等同起来。

定义在 $K$ 上的二维 *仿射平面* 记作 $ AA_K^2 = {(x, y) in K times K} $

我们有一个从仿射平面到射影平面的嵌入 $ AA_K^2 arrow.r.hook PP^2_K $ 由下式给出 $ (x, y) |-> (x : y : 1) $

通过这种方式，仿射平面可以识别为射影平面 $PP^2_K$ 中的有限点。将无穷远点加入进来以构造 $PP^2_K$，可以看作是对平面的“紧化”（见 @exercise:2-10）。

一个多项式是 *齐次的*，当且仅当它是一些形如 $a x^i y^j z^k$ 的项的和，其中 $a in K$，且 $i + j + k = n$，也就是说所有项的总次数都是 $n$。例如 $F(x, y, z) = 2x^3 - 5 x y z + 7 y z^2$ 是次数为 3 的齐次多项式。如果一个多项式 $F$ 是次数为 $n$ 的齐次多项式，那么对任意 $lambda in K$ 都有 $F(lambda x, lambda y, lambda z) = lambda^n F(x, y, z)$，由此可知，如果 $F$ 是某次数的齐次多项式，且 $(x_1, y_1, z_1) ~ (x_2, y_2, z_2)$，那么 $F(x_1, y_1, z_1) = 0$ 当且仅当 $F(x_2, y_2, z_2) = 0$。因此，$F$ 在射影平面 $PP^2_K$ 中的零点不依赖于代表元的选择，所以 $F$ 在 $PP^2_K$ 中的零点集合是良定义的。

然而，如果 $F(x, y, z)$ 是任意的（非齐次）多项式，那么我们无法在射影平面 $PP^2_K$ 中讨论 $F(x, y, z) = 0$ 的点，因为这将依赖于代表元的选取。比如取 $F(x, y, z) = x^2 + 2y - 3z$ ，则 $F(1, 1, 1) = 0$，于是我们可能会说 $F$ 在 $(1 : 1 : 1)$ 处为零，然而 $F(2, 2, 2) = 2$，且 $(1 : 1 : 1) = (2 : 2 : 2)$。为避免这种问题，我们必须使用齐次多项式来进行工作。

如果 $f(x, y)$ 是一个关于 $x, y$ 的齐次多项式，那么我们可以通过插入适当的 $z$ 次幂，把它变成齐次多项式。例如 $f(x, y) = y^2 - x^3 - A x - B$，那么我们可以把它变成三元的齐次多项式 $F(x, y, z) = y^2 z - x^3 - A x z^2 - B z^3$。若 $F$ 是一个 $n$ 次齐次多项式，那么 $ F(x, y, z) = z^n f(x/z, y/z) $ 并且 $ f(x, y) = F(x, y, 1) $

现在我们可以明白在射影几何中平行线是如何在无穷远处相交的。设 $ y = m x + b_1 quad quad y = m x + b_2 $ 是两条非竖直线的方程，且 $b_1 != b_2$。将它们转换为齐次形式，得到 $ y = m x + b_1 z quad quad y = m x + b_2 z $

（前面的讨论只考虑了形如 $f(x, y) = 0$ 和 $F(x, y, z) = 0$ 的方程；然而，把这些方程整理成“$n$ 次齐次式 $=$ $n$ 次齐次式”的形式也是完全没有问题的）当我们解这些联立方程以找出它们的交点时，我们得到 $ z = 0 quad quad y = m x $

由于 $x, y, z$ 不能全为 0，我们必须有 $x != 0$。因此，我们可以将各项除以 $x$ 来进行归一化，得到两条直线的交点 $ (x : m x : 0) = (1 : m : 0) $

类似地，如果 $x = c_1$ 和 $x = c_2$ 是两条竖直线，那么它们在投影平面中的交点为 $(0 : 1 : 0)$。这是射影空间 $PP^2_K$ 中的无穷远点之一。

现在我们来看给定的椭圆曲线 $E: y^2 = x^3 + A x + B$，其齐次形式为 $y^2 z = x^3 + A x z^2 + B z^3$。原始曲线上的点 $(x, y)$ 在射影形式中对应于点 $(x : y : 1)$。为了找出椭圆曲线 $E$ 上位于无穷远处的点，我们设 $z = 0$，得 $0 = x^3$，即 $x = 0$，而 $y$ 可以是任意非零数（请注意 $(0 : 0 : 0)$ 是不允许的）。我们以 $y$ 进行归一化，得到 $(0 : y : 0) = (0 : 1 : 0)$，这是 $E$ 上唯一的无穷远点。此外，由于 $(0 : 1 : 0) = (0 : -1 : 0)$，这意味着 $y$ 轴的“顶部”和“底部”其实是相同的点。

在某些情形下，使用射影坐标可以加快椭圆曲线上的运算（见 @sec:other-coordinate-systems）。然而，在本书中我们几乎总是在仿射（非射影）坐标下工作，并在需要时将无穷远点作为一个特殊情况处理。一个例外是 @sec:proof-of-associativity 中关于群律结合律的证明，在那里我们会将无穷远点视为与其他点 $(x : y : z)$ 一样来处理，这样更为方便。

== 结合律的证明 <sec:proof-of-associativity>

在本节中，我们将证明椭圆曲线上点加法的结合律。愿意相信这个结论的读者可以跳过本节，不会错过本书其余部分所需的任何内容。不过，作为这个证明的推论，我们将得到两个有趣的几何定理：帕普斯定理和帕斯卡定理。这两个定理虽然与椭圆曲线无关，但本身就非常值得研究。

我们证明的基本思路如下：我们从椭圆曲线 $E$ 和其上的点 $P, Q, R$ 开始。为了计算 $-((P + Q) + R)$ 我们需要构造直线 $ell_1 = overline(P Q), m_2 = overline(infinity\, P + Q)$ 和 $ell_3 = overline(R\, P + Q)$，并观察它们与 $E$ 的交点。容易发现点 $P_(i j) = ell_i inter m_j$ 除了可能的 $P_(3 3)$ 外都是 $E$ 上的点。我们将在 @theo:the-nine-point-confluence 中证明如果这八个交点 $P_(i j) != P_(3, 3)$ 都在 $E$ 上，那么 $P_(3 3)$ 也必然在 $E$ 上。因为直线 $ell_3$ 与 $E$ 相交于 $R, P + Q, -((P + Q) + R)$，这就意味着 $P_(3 3) = -((P + Q) + R)$。同理，$-(P + (Q + R)) = P_(3 3)$，所以 $ -((P + Q) + R) = -(P + (Q + R)) $ 因此结合律成立。

在这个证明中，有三个关键的技术细节必须处理：首先，部分点 $P_(i j)$ 可能是无穷远点，所以我们需要使用射影坐标；其次，某条直线可能与 $E$ 相切，这会导致某两个交点 $P_(i j)$ 重合，因此，我们需要仔细定义直线与曲线的相交重数；最后，可能存在两条直线完全相同的情况。在整个证明过程中，处理这些技术细节将占据主要精力。

首先，我们需要讨论定义在 $PP^2_K$ 上的直线。描述一条直线的标准方法是使用一个线性方程：$a x + b y + c z = 0$。不过，有时候使用参数形式来描述一条直线会更为方便：

$ x = a_1 u + b_1 v \ y = a_2 u + b_2 v \ z = a_3 u + b_3 v $ <eq:parametric-description-of-line>

其中 $u, v$ 取遍整个 $K$，且 $u, v$ 至少有一个不为零。例如，若 $a != 0$，则直线 $ a x + b y + c z = 0 $ 可以用参数形式 $ x = -b/a u - c/a v quad quad y = u quad quad z = v $ 来描述。

假设所有向量 $(a_i, b_i)$ 都是彼此的倍数，也就是说 $(a_i, b_i) = lambda_i (a_1, b_1)$，那么对所有满足 $x != 0$ 的 $u, v$ 我们都有 $(x, y, z) = x (1, lambda_2, lambda_3)$，这表示我们在射影空间中得到了一个点，而不是一条直线。因此我们对这些系数 $a_1, dots.c, b_3$ 施加一个条件，以确保我们得到的真的是一条直线。不难看出我们必须要让矩阵 $ mat(a_1, b_1; a_2, b_2; a_3, b_3) $ 的秩为 2（见 @exercise:2-12）。

如果存在 $lambda in K^times$ 使得 $(u_1, v_1) = lambda (u_2, v_2)$，那么 $(u_1, v_1)$ 和 $(u_2, v_2)$ 所对应的三元组 $(x, y, z)$ 是等价的。因此，我们可以把参数 $(u,v)$ 看作是在一维射影空间 $PP^1_K$ 中取遍所有的点。于是，一条直线就对应于射影直线 $PP^1_K$ 的一个拷贝嵌入到射影平面中。

我们需要量化一条直线在某点与一条曲线的相交重数，下面的内容将作为一个起点。

#lemma[
  设 $G(u, v)$ 是一个非零的齐次多项式，并设 $(u_0 : v_0) in PP^1_K$，则存在一个整数 $k >= 0$ 和一个多项式 $H(u, v)$，使得 $H(u_0, v_0) != 0$，并且有 $ G(u, v) = (v_0 u - u_0 v)^k H(u, v) $
]

#proof[
  假设 $v_0 != 0$，设 $m$ 为 $G$ 的次数。令 $g(u) = G(u, v_0)$，通过尽可能多地提取 $u - u_0$ 的因子，我们可以把 $g(u)$ 写作 $(u - u_0)^k h(u)$，其中 $k$ 是某个整数，$h(u)$ 是次数为 $m - k$ 的多项式，且 $h(u_0) != 0$。

  令 $ H(u, v) = frac(v^(m - k), v_0^m) h(frac(u v_0, v)) $ 这就是一个次数为 $m - k$ 的齐次多项式，于是

  $
    G(u, v) & = (v / v_0)^m g(frac(u v_0, v)) = frac(v^(m - k), v_0^m) (v_0 u - u_0 v)^k h(frac(u v_0, v)) \
            & = (v_0 u - u_0 v)^k H(u, v)
  $

  如果 $v_0 = 0$，那么 $u_0 != 0$，交换 $u$ 与 $v$ 的角色，用完全相同的思路就能完成证明。
]

设多项式 $f(x, y) = 0$ 描述了仿射平面中的一条曲线 $C$，又设 $ x = a_1 t + b_1 quad quad y = a_2 t + b_2 $ 是以参数 $t$ 表示的一条直线 $L$。定义 $ tilde(f)(t) = f(a_1 t + b_1, a_2 t + b_2) $

那么，当 $tilde(f)(t_0) = 0$ 时，直线 $L$ 在 $t = t_0$ 处与曲线 $C$ 相交。若 $(t - t_0)^2$ 整除 $tilde(f)(t)$，则称 $L$ 与 $C$ 在该点相切（如果与 $t_0$ 对应的点是非奇异点，见 @lemma:the-unique-tangent-line-at-a-nonsingular-point）。更一般地说，如果 $(t - t_0)^n$ 是整除 $tilde(f)(t)$ 的最大次数的因式，则称 $L$ 在与 $t = t_0$ 对应的点 $(x, y)$ 与 $C$ 的相交重数为 $n$。

上述内容在齐次情形下的版本如下：设 $F(x, y, z)$ 是一个齐次多项式，因此 $F = 0$ 描述了射影平面 $PP^2_K$ 中的一条曲线 $C$。设 $L$ 是由参数式 @eq:parametric-description-of-line 给出的直线，定义 $ tilde(F)(u, v) = F(a_1u + b_1v, a_2u + b_2v, a_3u + b_3v) $

若 $(v_0u - u_0v)^n$ 是整除 $tilde(F)(u, v)$ 的最大次数的因式，则称 $L$ 在与 $(u : v) = (u_0 : v_0)$ 对应的点 $P = (x_0 : y_0 : z_0)$ 处与 $C$ 的 *相交重数* 为 $n$，记作 $ "ord"_(L, P)(F) = n $

如果 $tilde(F) equiv 0$，那么我们让 $"ord"_(L, P)(F) = infinity$，不难证明 $"ord"_(L, P)(F)$ 与直线 $L$ 的参数化方式的选择无关。注意到当 $v = v_0 = 1$ 是对应上面提到的非齐次情形，此时的定义是一致的（至少当 $z != 0$ 时如此）。齐次形式的好处在于它允许我们以统一的方式处理无穷远点和有限点。

#lemma[
  令 $L_1$ 和 $L_2$ 是在点 $P$ 相交的两条直线，对于 $i = 1, 2$，设 $L_i (x, y, z)$ 是定义直线 $L_i$ 的齐次多项式。那么，除非存在某个常数 $alpha$ 使得 $L_1 (x, y, z) = alpha L_2 (x, y, z)$，否则有 $ "ord"_(L_1, P)(L_2) = 1 $

  若确实存在，则 $ "ord"_(L_1, P)(L_2) = infinity $
]

#proof[
  当我们将直线 $L_1$ 的参数化代入 $L_2(x, y, z)$ 时，会得到 $tilde(L)_2$，这是关于 $u, v$ 的一个一次表达式。设点 $P$ 对应于 $(u_0 : v_0)$，由于 $tilde(L)_2(u_0, v_0) = 0$，因此 $tilde(L)_2(u, v) = beta (v_0 u - u_0 v)$ 成立，其中 $beta$ 是某个常数。

  如果 $beta != 0$，那么 $"ord"_(L_1, P)(L_2) = 1$；如果 $beta = 0$，则 $L_1$ 上的所有点都在 $L_2$ 上。

  由于射影平面 $PP^2_K$ 中两点确定一条直线，而 $L_1$ 至少包含三点（$PP^1_K$ 总包含点 $(1 : 0), (0 : 1), (1 : 1)$），因此可以推出 $L_1$ 与 $L_2$ 是同一条直线。因此，$L_1(x, y, z)$ 与 $L_2(x, y, z)$ 是成比例的。
]

通常来说，一条与曲线相交重数至少为 2 的直线是该曲线的切线。但是，考虑由方程 $ F(x, y, z) = y^2 z - x^3 = 0 $ 定义的曲线 $C$，令 $ x= a u quad quad y = b u quad quad z = v $ 为经过点 $P = (0 : 0 : 1)$ 的直线。注意点 $P$ 对于参数比 $(u : v) = (0 : 1)$，代入得 $tilde(F) (u, v) = u^2 (b^2 v - a^3 u)$，因此所有通过 $P$ 的直线与曲线 $C$ 的相交重数都至少为 2。当 $b = 0$ 时，也就是取切线的最佳选择，有相交重数为 3。曲线 $C$ 的仿射部分是曲线 $y^2 = x^3$，如 @fig:y2-x3 所示。点 $(0, 0)$ 是该曲线的一个奇点，这就是为什么 $P$ 处的交阶高于一般预期的原因。这种情况通常是我们希望避免的。

#definition[
  设射影平面 $PP^2_K$ 上的曲线 $C$ 由 $F(x, y, z) = 0$ 定义，若在某点 $P$ 处三个偏导数 $F_x, F_y, F_z$ 中至少有一个不为零，则称曲线 $C$ 在点 $P$ 处是 *非奇异的*。

]

比如考虑由 $F(x, y, z) = y^2 z - x^3 - A x z^2 - B z^3 = 0$ 定义的椭圆曲线，并假设我们的域 $K$ 的特征不为 2 或 3。我们有 $ F_x = -3 x^2 - A z^2 quad quad F_y = 2 y z quad quad F_z = y^2 - 2 A x z - 3 B z^2 $

设点 $P = (x : y : z)$ 为奇点。如果 $z = 0$，那么 $F_x = 0$ 推导出 $x = 0$，$F_z = 0$ 推导出 $y = 0$，因此 $P = (0 : 0 : 0)$，这是不允许的。如果 $z != 0$，那么我们可以取 $z = 1$（从而忽略 $z$ 的存在）。如果 $F_y = 0$，那么 $y = 0$。由于 $(x : y : 1)$ 在曲线上，$x$ 必须满足 $x^3 + A x + B = 0$。如果 $F_x = - (3x^2 + A) = 0$，那么 $x$ 同时是该多项式及其导数的根，因此是个重根。然而我们假设这个三次多项式没有重根，出现矛盾。因此，椭圆曲线没有奇点。注意这个结论在我们考虑点的坐标在 $overline(K)$（$K$ 的代数闭包）中时仍然成立。一般来说，当我们说一条曲线是 *非奇异曲线* 时，指的是它在 $overline(K)$ 上没有任何奇点。

如果我们允许三次多项式有一个重根，那么很容易看出曲线在 $(x : 0 : 1)$ 处是奇点。这种情况将在 @sec:singular-curves 中讨论。

如果 $P$ 是曲线 $F(x, y, z) = 0$ 上的一个非奇异点，那么过点 $P$ 的切线为 $ F_x (P) x + F_y (P) y + F_z (P) z = 0 $

比如令 $F(x, y, z) = y^2 z - x^3 - A x z^2 - B z^3$，则过点 $P = (x : y : z)$ 的切线为 $ (-3 x_0^2 - A z_0^2) x + 2 y_0 z_0 y + (y_0^2 - 2 A x_0 z_0 - 3 B z_0^2) z = 0 $

如果我们让 $z_0 = z = 1$，则得 $ (-3 x_0^2 - A) x + 2 y_0 y + (y_0^2 - 2 A x_0 - 3 B) = 0 $

再根据 $y_0^2 = x_0^3 + A x_0 + B$ 这个事实，我们可以将其简化为 $ (-3 x_0^2 - A) (x - x_0) + 2 y_0 (y - y_0) = 0 $

这就是我们在推导椭圆曲线上点加自身的运算公式时使用的仿射坐标下的切线。现在我们来看这条曲线上的无穷远点。我们有 $(x_0 : y_0 : z_0) = (0 : 1 :0)$，该点处切线由 $0x + 0y + z = 0$ 给出，也就是射影平面 $PP^2_K$ 中的“无穷远直线”。这条直线仅在点 $(0 : 1 : 0)$ 处与曲线相交，这与椭圆曲线上 $infinity + infinity = infinity$ 这一事实相对应。

#lemma[
  设 $F(x, y, z) = 0$ 定义了一条曲线 $C$。如果 $P$ 是 $C$ 上的一个非奇异点，那么在射影平面 $PP^2_K$ 中，恰好存在唯一一条直线在点 $P$ 与曲线的相交重数至少为 2，这条直线就是曲线 $C$ 在 $P$ 处的切线。

] <lemma:the-unique-tangent-line-at-a-nonsingular-point>

#proof[
  令 $L$ 是与 $C$ 相交重数 $k >= 1$ 的直线，根据 @eq:parametric-description-of-line 参数化 $L$ 并代入 $F$ 得到 $tilde(F) (u, v)$。设 $(u_0 : v_0)$ 对应于点 $P$，则 $tilde(F)(u_0, v_0) = 0$。那么存在某个函数 $H(u, v)$ 使得 $tilde(F)(u, v) = (v_0 u - u_0 v)^k H(u, v)$，其中 $H(u_0, v_0) != 0$。因此 $ tilde(F)_u (u, v) = k v_0 (v_0 u - u_0 v)^(k - 1) H(u, v) + (v_0 u - u_0 v)^k H_u (u, v) $ 且 $ tilde(F)_v (u, v) = -k u_0 (v_0 u - u_0 v)^(k - 1) H(u, v) + (v_0 u - u_0 v)^k H_u (u, v) $

  由此可知，当且仅当 $tilde(F)_u (u_0, v_0) = tilde(F)_v (u_0, v_0) = 0$ 时，$k >= 2$。

  假定 $k >= 2$，由链式法则可得在点 $P$ 处有 $ tilde(F)_u = a_1 F_x + a_2 F_y + a_3 F_z = 0 quad quad tilde(F)_v = b_1 F_x + b_2 F_y + b_3 F_z = 0 $ <eq:tangent-line-derivatives>

  注意到 @eq:parametric-description-of-line 表示一条直线，向量 $(a_1, a_2, a_3)$ 和 $(b_1, b_2, b_3)$ 必须线性无关。

  假设还存在另一条直线 $L'$ 与曲线 $C$ 的相交重数至少为 2，我们可以在点 $P$ 处得到另一组等式 $ a'_1 F_x + a'_2 F_y + a'_3 F_z = 0 quad quad b'_1 F_x + b'_2 F_y + b'_3 F_z = 0 $

  若向量 $bold(a') = (a'_1, a'_2, a'_3)$ 和 $bold(b') = (b'_1, b'_2, b'_3)$ 在 $K^3$ 上与 $bold(a) = (a_1, a_2, a_3)$ 和 $bold(b) = (b_1, b_2, b_3)$ 张成的平面相同，那么存在可逆矩阵 $ mat(alpha, beta; gamma, delta) $ 使得 $ bold(a') = alpha bold(a) + beta bold(b) quad quad bold(b') = gamma bold(a) + delta bold(b) $

  因此 $ u bold(a') + v bold(b') = (u alpha + v gamma) bold(a) + (u beta + v delta) bold(b) = u_1 bold(a) + v_1 bold(b) $ 其中 $u_1, v_1$ 是新选定的参数。这意味着直线 $L$ 与 $L'$ 是同一条直线。

  如果 $L$ 和 $L'$ 不是同一条直线，那么 $bold(a), bold(b)$ 与 $bold(a'), bold(b')$ 张成的平面不同，因此向量 $bold(a), bold(b), bold(a'), bold(b')$ 张成了整个 $K^3$ 空间。由于向量 $(F_x, F_y, F_z)$ 与这些向量的点乘都为 0，那么它必然是个零向量。这说明点 $P$ 是奇异点，与我们的假设矛盾。

  最后，我们需要说明切线与曲线的交点阶数至少为 2。假设在点 $P$ 处 $F_x != 0$（其他情形如 $F_y != 0$ 或 $F_z != 0$ 可以类似处理），则切线可由参数化方程 $ x = - frac(F_y, F_x) u - frac(F_z, F_x) v quad quad y = u quad quad z = v $ 给出，因此在 @eq:parametric-description-of-line 的记号下，有 $ a_1 = - frac(F_y, F_x) quad b_1 = - frac(F_z, F_x) quad quad a_2 = 1 quad b_2 = 0 quad quad a_3 = 0 quad b_3 = 1 $

  代入 @eq:tangent-line-derivatives 可得 $ tilde(F)_u (u, v) = - frac(F_y, F_x) F_x + F_y = 0 quad quad tilde(F)_v (u, v) = - frac(F_z, F_x) F_x + F_z = 0 $

  根据证明开头的讨论，这意味着切线与曲线的交点阶数 $k >= 2$。
]

椭圆曲线加法的结合性将会从下一个结果中轻松得出。如果假设各点 $P_(i j)$ 彼此不同，证明可以大大简化。当某些点相等时，就必须使用切线来定义，对应的情形就是在直接利用加法公式验证结合性时更难处理的部分。

#theorem[
  设 $C(x, y, z)$ 是一个齐次三次多项式，令 $C$ 表示射影平面 $PP^2_K$ 中由方程 $C(x, y, z) = 0$ 所定义的曲线。设 $ell_1, ell_2, ell_3$ 与 $m_1, m_2, m_3$ 是 $PP^2_K$ 中的直线，满足对所有的 $i, j$，$ell_i != m_j$。

  令 $P_(i j)$ 表示直线 $ell_i$ 与 $m_j$ 的交点。假设当 $(i, j) != (3, 3)$ 时，$P_(i j)$ 都是曲线 $C$ 上的非奇异点。另外，若对某个 $i$，三点 $P_(i 1), P_(i 2), P_(i 3)$ 中有 $k >= 2$ 个是相同的点，则要求 $ell_i$ 在该点与曲线 $C$ 的相交阶数不少于 $k$；同样地，如果对某个 $j$，三点 $P_(1 j), P_(2 j), P_(3 j)$ 中有 $k >= 2$ 个是相同的点，则要求 $m_j$ 在该点与曲线 $C$ 的相交阶数不少于 $k$。

  那么结论是：点 $P_(3 3)$ 也在曲线 $C$ 上。
] <theo:the-nine-point-confluence>

#proof[
  将直线 $ell_1$ 表示为参数形式 @eq:parametric-description-of-line，并代入曲线方程 $C(x, y, z)$ 得到 $tilde(C)(u, v)$。直线 $ell_1$ 经过点 $P_(1 1), P_(1 2), P_(1 3)$，这些点对应于 $ell_1$ 上的参数点分别为 $(u_1 : v_1), (u_2 : v_2), (u_3 : v_3)$。由于这些点都在曲线 $C$ 上，有 $tilde(C)(u_i, v_i) = 0$ 对 $i = 1, 2, 3$ 成立。

  设每条直线 $m_j$ 的方程为 $m_j (x, y, z) = a_j x + b_j y + c_j z = 0$，将 $ell_1$ 的参数形式代入 $m_j$ 得到 $tilde(m)_j (u, v)$。由于 $ell_1 != m_j$，并且 $tilde(m)_j$ 的零点给出了 $ell_1$ 与 $m_j$ 的交点，所以函数 $tilde(m)_j (u, v)$ 仅在 $P_(1 j)$ 处为零，因此这个线性形式 $tilde(m)_j$ 是非零的。于是三者之积 $ tilde(m)_1 (u, v) dot.c tilde(m)_2 (u, v) dot.c tilde(m)_3 (u, v) $ 是一个非零的三次齐次多项式，我们希望将这个乘积与 $tilde(C)$ 关联起来。

  #lemma[
    设 $R(u, v)$ 和 $S(u, v)$ 是次数为 3 的齐次多项式，且 $S(u, v)$ 不恒为零。假设存在三个点 $(u_i : v_i)$，$i = 1, 2, 3$，使得 $R$ 与 $S$ 在这些点上都为零。此外，如果这三个点中有 $k$ 个点是同一个点，我们要求 $R$ 和 $S$ 在该点的相交重数至少为 $k$（也就是说，$(v_i u - u_i v)^k$ 能整除 $R$ 与 $S$）。那么存在一个常数 $alpha in K$ 使得 $R = alpha S$。

  ]

  #proof[
    首先注意，一个非零的三次齐次多项式 $S(u, v)$ 在射影直线 $PP^1_K$ 上最多有三个零点（按重数计）。这一点可以如下证明：先将 $v$ 的尽可能高的幂因式提出来，记为 $v^k$。那么 $S(u, v)$ 在点 $(1 : 0)$ 处的相交重数为 $k$，并且有 $S(u, v) = v^k S_0 (u, v)$，其中 $S_0 (1, 0) != 0$。由于 $S_0 (u, 1)$ 是一个次数为 $3 - k$ 的多项式，因此它至多有 $3 - k$ 个零点（按重数计），若 $K$ 是代数闭域，则恰好有 $3 - k$ 个。除了 $(1 : 0)$ 之外的所有点 $(u : v)$ 都可以写成 $(u : 1)$ 的形式，因此 $S_0 (u, v)$ 至多在 $3 - k$ 个点上为零。因此，$S(u, v)$ 在 $PP^1_K$ 中最多有 $k + (3 - k) = 3$ 个零点。

    由此可以轻松看出，条件“$S(u, v)$ 在某点的相交重数至少为 $k$”可以换成“相交重数恰为 $k$”。但在实际应用中检查“至少”比“正好”为 $k$ 更容易。由于我们允许 $R(u, v)$ 恒等于零，这条注记并不适用于 $R$。

    令 $(u_0 : v_0)$ 是 $PP^1_K$ 中不等于任何一个 $(u_i : v_i)$ 的任意一点。（技术细节：如果 $K$ 只有两个元素，那么 $PP^1_K$ 仅包含三个点。这种情况下，可以将 $K$ 扩张为 $G F (4)$。最终得到的 $alpha$ 仍在 $K$ 中，因为它是 $R$ 与 $S$ 的系数之比，两者都属于 $K$。）由于 $S$ 最多有三个零点，故有 $S(u_0, v_0) != 0$。令 $ alpha = frac(R (u_0, v_0), S (u_0, v_0)) $

    那么 $R(u, v) - alpha S(u, v)$ 是一个在四个点 $(u_i : v_i)$，$i = 0, 1, 2, 3$ 上都为零的三次齐次多项式。因此，$R - alpha S$ 必然恒等为零。
  ]

  回到定理的证明，我们注意到 $tilde(C)$ 和 $tilde(m)_1 tilde(m)_2 tilde(m)_3$ 在点 $(u_i : v_i)$，$i = 1, 2, 3$ 上都为零。进一步地，如果有 $k$ 个点 $P_(1 j)$ 是相同的点，那么就有 $k$ 个线性函数在该点为零，因此乘积 $tilde(m)_1 (u, v) dot.c tilde(m)_2 (u, v) dot.c tilde(m)_3 (u, v)$ 的相交重数至少为 $k$。根据假设，$tilde(C)$ 在这种情形下的消去阶也至少为 $k$。由前述引理可知，存在一个常数 $alpha$，使得 $ tilde(C) = alpha tilde(m)_1 tilde(m)_2 tilde(m)_3 $

  令 $ C_1 (x, y, z) = C(x, y, z) - alpha tilde(m)_1 (u, v) tilde(m)_2 (u, v) tilde(m)_3 (u, v) $

  直线 $ell_1$ 可以由线性方程 $ell_1 (x, y, z) = a x + b y + c z = 0$ 描述。至少有一个系数不为零，不妨假设 $a != 0$，其他情况类似。于是直线 $ell_1$ 的参数形式可以写作 $ x = - b/a u - c/a v quad quad y = u quad quad z = v $ <eq:parametric-description-of-ell-1>

  于是 $ tilde(C)_1 (u, v) = C_1 (- b/a u - c/a v, u, v) $

  将 $C_1 (x, y, z)$ 写成关于 $x$ 的多项式，其系数是关于 $y, z$ 的多项式，有 $ x^n = 1/a^n ((a x + b y + c z) - (b y + c z))^n = 1/a^n ((a x + b y + c z)^n + dots.c) $

  由此我们可以将 $C_1 (x, y, z)$ 重新整理为 重新整理成一个关于 $a x + b y + c z$ 的多项式，其系数是 $y, z$ 的多项式：$ C_1 (x, y, z) = a_3(y, z) (a x + b y + c z)^3 + dots.c + a_0(y, z) $ <eq:c1-be-a-polynomial-in-ax-by-cz>

  将 @eq:parametric-description-of-ell-1 代入 @eq:c1-be-a-polynomial-in-ax-by-cz 可得 $ 0 = tilde(C)_1 (u, v) = a_0(u, v) $

  由于 $x, y , z$ 在用 $u, v$ 表示时，$a x + b y + c z$ 恒等于零，因此 $a_0 (y, z) = a_0 (u, v)$ 是零多项式，由 @eq:c1-be-a-polynomial-in-ax-by-cz 得 $C_1 (x, y, z)$ 是 $ell_1 (x, y, z) = a x + b y + c z$ 的倍数。

  类似地，存在常数 $beta$ 使得 $C_1 (x, y, z) - beta ell_1 ell_2 ell_3$ 是 $m_1$ 的倍数。

  设 $ D(x, y, z) = C - alpha m_1 m_2 m_3 - beta ell_1 ell_2 ell_3 $ 则 $D(x, y, z)$ 既是 $ell_1$ 的倍数，也是 $m_1$ 的倍数。

  #lemma[
    $D(x, y, z)$ 是 $ell_1 (x, y, z)$ 和 $m_1 (x, y, z)$ 的乘积。

  ]

  #proof[
    令 $D = m_1 D_1$。我们需要证明 $ell_1$ 整除 $D_1$。我们本可以引用关于唯一因子分解的某个结论，但我们将采用如下方法进行。通过式 @eq:parametric-description-of-ell-1 对直线 $ell_1$ 进行参数化（我们仍然考虑 $a != 0$ 的情形）。将该参数化代入关系式 $D = m_1 D_1$ 中，得到 $tilde(D) = tilde(m)_1 tilde(D)_1$。由于 $ell_1$ 整除 $D$，所以 $tilde(D) = 0$。又因为 $m_1 != ell_1$，所以 $tilde(m)_1 != 0$。因此，$tilde(D)_1(u, v)$ 是零多项式。同前文，这意味着 $D_1(x, y, z)$ 是 $ell_1$ 的一个倍数，也就是我们想要的结论。

  ]

  根据引理，有 $ D(x, y, z) = ell_1 m_1 ell $

  其中 $ell(x, y, z)$ 是一次多项式。根据假设，$C$ 在 $P_(2 2), P_(2 3), P_(3 2)$ 三点处为零。同时，$ell_1 ell_2 ell_3$ 和 $m_1 m_2 m_3$ 在这些点处也为零。因此，$D(x, y, z)$ 在这些点处为零。我们的目标是证明 $D$ 恒等为零。

  #lemma[
    $ ell(P_(2 2)) = ell(P_(2 3)) = ell(P_(3 2)) = 0 $
  ] <lemma:ell-equals-zero-at-p22-p23-p32>

  #proof[
    首先假设 $P_(1 3) != P_(2 3)$。如果 $ell_1 (P_(2 3)) = 0$，那么由定义可得 $P_(2 3)$ 同时在直线 $ell_1, ell_2$ 和 $m_3$ 上。因此，$P_(2 3)$ 就等于直线 $ell_1$ 与 $m_3$ 的交点 $P_(1 3)$，但我们已经假设 $P_(1 3) != P_(2 3)$，引出矛盾，因此 $ell_1 (P_(2 3)) != 0$。又因为 $D(P_(2 3)) = 0$，所以 $m_1 (P_(2 3)) ell(P_(2 3)) = 0$。

    再来假设 $P_(1 3) = P_(2 3)$。根据定理中的假设，$m_3$ 是曲线 $C$ 在点 $P_(2 3)$ 处的切线，因此 $"ord"_(m_3, P_(2 3)) (C) >= 2$。由于 $P_(1 3) = P_(2 3)$ 且 $P_(2 3)$ 在 $m_3$ 上，可得 $"ord"_(m_3, P_(2 3)) (ell_1) = "ord"_(m_3, P_(2 3)) (ell_2) = 1$。因此 $"ord"_(m_3, P_(2 3)) (alpha ell_1 ell_2 ell_3) >= 2$，且 $"ord"_(m_3, P_(2 3)) (beta m_1 m_2 m_3) = infinity$。因此，$"ord"_(m_3, P_(2 3)) (D) >= 2$，因为 $D$ 是若干项的和，而每一项相交重数至少为 2，但 $"ord"_(m_3, P_(2 3)) (ell_1) = 1$，于是得到 $ "ord"_(m_3, P_(2 3)) (m_1 ell) = "ord"_(m_3, P_(2 3)) (D) - "ord"_(m_3, P_(2 3)) (ell_1) >= 1 $

    因此 $m_1 (P_(2 3)) ell(P_(2 3)) = 0$。

    在两种情况下，我们都得到了 $m_1 (P_(2 3)) l(P_(2 3)) = 0$。

    如果 $m_1 (P_(2 3)) != 0$，那么 $ell(P_(2 3)) = 0$，正是我们想要的。

    如果 $m_1 (P_(2 3)) = 0$，那么 $P_(2 3)$ 由定义在直线 $m_1$ 上，也在直线 $ell_2$ 和 $m_3$ 上。因此 $P_(2 3) = P_(2 1)$，因为 $ell_2$ 与 $m_1$ 的交点唯一。根据假设，$ell_2$ 在 $P_(2 3)$ 处与曲线 $C$ 相切，也就是 $"ord"_(ell_2, P_(2 3)) (C) >= 2$，同样推出 $"ord"_(ell_2, P_(2 3) (D) >= 2$，于是 $ "ord"_(ell_2, P_(2 3)) (ell_1 ell) >= 1 $

    如果在这种情况下有 $ell_1 (P_(2 3)) = 0$，那么 $P_(2 3)$ 在直线 $ell_1, ell_2, m_3$ 上，因此 $P_(2 3) = P_(1 3)$。根据假设，直线 $m_3$ 在 $P_(2 3)$ 处与曲线 $C$ 相切。由于 $P_(2 3)$ 是 $C$ 上的非奇异点，@lemma:the-unique-tangent-line-at-a-nonsingular-point 的结论表明 $ell_2 = m_3$，与假设矛盾。因此 $ell_1 (P_(2 3)) != 0$，且得 $ell(P_(2 3)) = 0$。

    类似地，$ell(P_(2 2)) = 0$ 和 $ell(P_(3 2)) = 0$。
  ]

  如果 $ell(x, y, z)$ 恒等于零，那么 $D$ 也恒等于零。因此，假设 $ell(x, y, z)$ 不为零，因此它定义了一条直线 $ell$。

  首先假设 $P_(2 3), P_(2 2), P_(3 2)$ 是互不相同的点。那么 $ell$ 和 $ell_2$ 是经过 $P_(2 3)$ 和 $P_(2 2)$ 的直线，因此 $ell = ell_2$。类似地，$ell = m_2$，所以 $ell_2 = m_2$，这与假设矛盾。

  再来假设 $P_(3 2) = P_(2 2)$。那么 $m_2$ 在点 $P_(2 2)$ 处与 $C$ 相切。与先前类似，有 $ "ord"_(m_2, P_(2 2))(ell_1 m_1 ell) >= 2 $

  我们希望证明这将迫使 $ell$ 与 $m_2$ 是同一条直线。

  若 $m_1(P_(2 2)) = 0$，则点 $P_(2 2)$ 位于 $m_1, m_2, ell_2$ 上，因此 $P_(2 1) = P_(2 2)$。这意味着 $ell_2$ 在点 $P_(2 2)$ 处与 $C$ 相切。根据 @lemma:the-unique-tangent-line-at-a-nonsingular-point，$ell_2 = m_2$，与假设矛盾。因此 $m_1(P_(2 2)) != 0$。

  若 $ell_1(P_(2 2)) != 0$，则 $"ord"_(m_2, P_(2 2))(ell) >= 2$，这意味着 $ell$ 与 $m_2$ 是同一条直线。

  若 $ell_1(P_(2 2)) = 0$，则由于 $P_(2 2) = P_(3 2)$，该点落在 $ell_1, ell_2, ell_3, m_2$ 上，因此 $P_(1 2) = P_(2 2) = P_(3 2)$。于是有 $"ord"_(m_2, P_(2 2))(C) >= 3$。跟前文一样，可以得到 $"ord"_(m_2, P_(2 2))(ell_1 m_1 ell) >= 3$。由于我们已经证明 $m_1(P_(2 2)) != 0$，便有 $"ord"_(m_2, P_(2 2))(ell) >= 2$。这意味着 $ell$ 与 $m_2$ 是同一条直线。

  因此我们已经证明，在假设 $P_(3 2) = P_(2 2)$ 的前提下，$ell$ 与 $m_2$ 是同一条直线。根据 @lemma:ell-equals-zero-at-p22-p23-p32，$P_(2 3)$ 落在 $ell$ 上，因而也落在 $m_2$ 上。又因为 $P_(2 3)$ 也在 $ell_2$ 和 $m_3$ 上，所以 $P_(2 2) = P_(2 3)$。这意味着 $ell_2$ 在 $P_(2 2)$ 处与 $C$ 相切。而 $P_(3 2) = P_(2 2)$ 又意味着 $m_2$ 也在该点与 $C$ 相切，因此 $ell_2 = m_2$，与假设矛盾。因此，在假设 $ell != 0$ 的条件下，$P_(3 2) != P_(2 2)$。

  同理，$P_(2 3) != P_(2 2)$。

  最后，假设 $P_(2 3) = P_(3 2)$。那么 $P_(2 3)$ 位于 $ell_2, ell_3, m_2, m_3$ 上。这将迫使 $P_(2 2) = P_(3 2)$，而我们刚才已经证明这是不可能的。

  因此，所有可能的情况都导致矛盾。由此可得，$ell(x, y, z)$ 必须恒等为零。所以 $D = 0$，于是

  $ C = alpha ell_1 ell_2 ell_3 + beta m_1 m_2 m_3 $

  由于 $ell_3$ 和 $m_3$ 在点 $P_(3 3)$ 处为零，我们有 $C(P_(3 3)) = 0$，正是我们想要的。这就完成了 @theo:the-nine-point-confluence 的证明。
]

#remark[
  注意，我们实际上证明了一个更强的结论，即

  $ C = alpha ell_1 ell_2 ell_3 + beta m_1 m_2 m_3 $

  其中 $alpha, beta$ 是常数。由于一个齐次三元三次多项式有 10 个系数，而我们要求 $C$ 在 8 个点（当所有 $P_(i j)$ ​互不相同时）处为零。因此可得一组多项式构成一个两参数族，这并不意外。当某些 $P_(i j)$ ​不互异时，切线条件会增加额外的约束，使我们仍然得到一个两参数族的解集。
]

现在我们可以证明椭圆曲线上点的加法满足结合律。令 $P, Q, R$ 是 $E$ 上的点。定义直线

$
  ell_1 = overline(P Q) quad quad ell_2 = overline(infinity\, Q + R) quad quad ell_3 = overline(R\, P + Q) \ m_1 = overline(Q R) quad quad m_2 = overline(infinity\, P + Q) quad quad m_3 = overline(P\, Q + R)
$

我们可以得到如下交点：

#figure[
  #table(
    columns: (auto, auto, auto, auto),
    align: center,
    stroke: none,
    table.hline(),
    table.header([], table.vline(), $ell_1$, $ell_2$, $ell_3$),
    table.hline(),
    $m_1$, $Q$, $-(Q + R)$, $R$,
    $m_2$, $-(P + Q)$, $infinity$, $P + Q$,
    $m_3$, $P$, $Q + R$, $X$,
    table.hline(),
  )
]

暂且假设这满足定理的所有前提条件。那么，上表中的所有点，包括点 $X$ 都落在 $E$ 上。直线 $ell_3$ 与 $E$ 相交与 $R, P + Q, X$ 三点，根据点加法的定义，$X = - ((P + Q) + R)$，同理直线 $m_3$ 与 $C$ 相交于三点，得到 $X = - (P + (Q + R))$。因此，经过绕 $x$ 的翻转，得到 $(P + Q) + R = P + (Q + R)$，正是我们想要的。

接下来要验证定理的假设条件，也就是即交点的相交重数正确的，且各 $ell_i$ 与 $m_j$ 是互不相同的直线。

我们首先处理包含无穷远点 $infinity$ 的情形。问题在于我们在定义群律时，将 $infinity$ 视为一个特殊情况处理。

#lemma[
  令 $P_1, P_2$ 是椭圆曲线上的点，那么 $(P_1 + P_2) - P_2 = P_1$，且 $- (P_1 + P_2) + P_2 = -P_1$。

] <lemma:p1-plus-p2-minus-p2-equals-p1>

#proof[
  这两条关系互为对称，因此只需证明第二个等式。设直线 $L$ 通过点 $P_1$ 和 $P_2$，则它与椭圆曲线相交于第三点 $- (P_1 + P_2)$。现在，把 $L$ 看作是连接 $- (P_1 + P_2)$ 和 $P_2$ 的直线，根据加法规则，我们有 $- (P_1 + P_2) + P_2 = -P_1$，即得证。

]

假设某两条直线 $ell_i = m_j$，我们来考虑各种情形。根据前面的讨论，可以假设交点表中的所有点都是有限点，除了 $infinity$ 和可能的点 $X$。注意，每条 $ell_i$ 和每条 $m_j$ 与椭圆曲线 $E$ 相交三个点（按重数计），其中一个是 $P_(i j)$。如果两条直线重合，那么它们与曲线相交的另外两个点也必须（在某种顺序上）重合。 /// TODO: Check "order" here.

+ $ell_1 = m_1$：那么 $P, Q, R$ 共线，结合律得证。

+ $ell_1 = m_2$：此时 $P, Q, infinity$ 共线，所以 $P + Q = infinity$；结合律由上面的直接计算得出。

+ $ell_2 = m_1$：与上一个情况类似。

+ $ell_1 = m_3$：那么 $P, Q, Q + R$ 共线；结合律已在上面证明。

+ $ell_3 = m_1$：与上一个情况类似。

+ $ell_2 = m_2$：那么 $P + Q$ 必为 $plus.minus (Q + R)$。若 $P + Q = Q + R$，则利用交换律与上面的引理得出 $ P = (P + Q) - Q = (Q + R) - Q = R $ 因此 $ (P + Q) + R = R + (P + Q) = P + (P + Q) = P + (R + Q) = P + (Q + R) $ 若 $P + Q = - (Q + R)$，则 $ (P + Q) + R = - (Q + R) + R = -Q $ 且 $ P + (Q + R) = P - (P + Q) = -Q $ 因此结合律成立。

+ $ell_2 = m_3$：此时，过 P 和 $Q + R$ 的直线 $m_3$ 与 $E$ 相交于 $infinity$，所以 $P = - (Q + R)$。因为 $- (Q + R), Q, R$ 共线，有 $P, Q, R$ 共线，从而结合律成立。

+ $ell_3 = m_2$：与上一个情况类似。

+ $ell_3 = m_3$：由于 $ell_3$ 不可能与 E 有 4 个交点（按重数计），可容易看出 $P = R$ 或 $P = P + Q$ 或 $Q + R = P + Q$ 或 $Q + R = R$。$P = R$ 在 $ell_2 = m_2$ 时已经处理。假设 $P = P + Q$，加上 $-P$ 并使用 @lemma:p1-plus-p2-minus-p2-equals-p1 得到 $infinity = Q$，此时结合律立即成立。情况 $Q + R = R$ 类似。若 $Q + R = P + Q$，加上 $-Q$ 并使用 @lemma:p1-plus-p2-minus-p2-equals-p1 得到 $P = R$，这我们已经处理过。

若对所有 $i, j$ 都有 $ell_i != m_j$，则定理的假设成立，因此如上所证，加法是结合的。这就完成了椭圆曲线加法结合律的证明。

#remark[
  注意，在本证明的大部分过程中，我们并未使用椭圆曲线的 Weierstrass 方程。实际上，任何非奇异的三次曲线都足够用。群律中的单位元 $O$ 需要是一个切线与曲线三重相交的点（即切线交点的阶数为 3）。三个点若共线，则它们的和为零。点 $P$ 的逆元通过连接 $O$ 和 $P$ 的直线实现，这条直线与曲线的第三个交点就是 $-P$。这个群律的结合律的证明与 Weierstrass 曲线的情况类似。

]

=== 帕普斯定理和帕斯卡定理 <subsec:the-theorems-of-pappus-and-pascal>

@theo:the-nine-point-confluence 在椭圆曲线之外的领域还有两个很好的应用。

#theorem[帕斯卡定理][
  令 $A B C D E F$ 是是一个内接于某个圆锥曲线（椭圆、抛物线或双曲线）上的六边形 #footnote[译者注：严格来说，此处的“六边形”应该称作六点形（或六线形），见视频 #link("https://www.bilibili.com/video/BV1QHBMY5ESk?t=449.2")[【射影几何】线动也能成点！对偶原理简介（五）]。此处 @fig:pascals-theorem 与原书中的内接凸六边形不一致，但不影响结论]，其中点 $A,B,C,D,E,F$ 是仿射平面中的互不相同的点。设 $X$ 是 $overline(A B)$ 和 $overline(D E)$ 的交点，$Y$ 是 $overline(B C)$ 和 $overline(E F)$ 的交点，$Z$ 是 $overline(C D)$ 和 $overline(F A)$ 的交点。那么，点 $X, Y, Z$ 共线（见 @fig:pascals-theorem）。
] <theo:pascals-theorem>

#figure(caption: [帕斯卡定理])[
  #cetz.canvas(length: 1.5em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    circle((0, 0), radius: (2, 1))

    let A = (-2, 0)
    circle(A, name: "A", radius: 0)
    content("A", $ A $, anchor: "east", padding: 0.1)
    let B = (-calc.sqrt(3), 1 / 2)
    circle(B, name: "B", radius: 0)
    content("B", $ B $, anchor: "south-east", padding: 0.1)
    let C = (-calc.sqrt(3), -1 / 2)
    circle(C, name: "C", radius: 0)
    content("C", $ C $, anchor: "north-east", padding: 0.1)
    let D = (calc.sqrt(3), 1 / 2)
    circle(D, name: "D", radius: 0)
    content("D", $ D $, anchor: "south-west", padding: 0.1)
    let E = (calc.sqrt(3), -1 / 2)
    circle(E, name: "E", radius: 0)
    content("E", $ E $, anchor: "north-west", padding: 0.1)
    let F = (0, 1)
    circle(F, name: "F", radius: 0)
    content("F", $ F $, anchor: "south", padding: 0.1)

    // 直线 AB
    line((-2.803848, -1.5), (1.751289, 7))
    // 直线 DE
    line((calc.sqrt(3), 7), (calc.sqrt(3), -1.5))
    // 直线 BC
    line((-calc.sqrt(3), 7), (-calc.sqrt(3), -1.5))
    // 直线 EF
    line((-5, 5.330127), (2.5, -1.165063))
    // 直线 CD
    line((-5, -1.434957), (2.5, 0.720728))
    // 直线 FA
    line((-5, -1.5), (2.5, 2.25))

    // 交点 X
    let X = (1.732051, 6.964102)
    circle(X, name: "X", radius: 0)
    content("X", $ X $, anchor: "south", padding: 0.1)
    // 交点 Y
    let Y = (-1.724564, 2.493516)
    circle(Y, name: "Y", radius: 0)
    content("Y", $ Y $, anchor: "east", padding: 0.1)
    // 交点 Z
    let Z = (-4.694024, -1.347012)
    circle(Z, name: "Z", radius: 0)
    content("Z", $ Z $, anchor: "north-west", padding: 0.1)

    line((-4.812313, -1.5), (1.759807, 7), stroke: (dash: "dashed"))
  })
] <fig:pascals-theorem>

#remark[
  + 一个圆锥曲线由形如 $q(x, y) = a x^2 + b x y + c y^2 + d x + e y + f = 0$ 的方程定义，其中 $a, b, c$ 至少有一个不为零。通常地，假定 $b^2 - 4 a c != 0$，否则圆锥曲线可以因式分解为两个线性因子，图像是两条直线的并集。上文呈现的定理甚至包含这种情况，只要点 $A, C, E$ 在一条直线，$B, D, F$ 在另外一条上即可。

  + 举例来说 $overline(A B)$ 和 $overline(D E)$ 可能是平行的，那么 $X$ 是个在 $PP^2_K$ 里的无穷远点。

  + 注意到 $X, Y, Z$ 总是互不相等的。这是显然易见的：首先注意到，点 $X, Y, Z$ 不可能落在该圆锥曲线上，因为一条直线最多与圆锥曲线相交两点；而点 $A, B, C, D, E, F$ 被假定为互不相同，因此它们已经穷尽了所有可能的交点。若 $X = Y$，那么直线 $overline(A B)$ 与 $overline(B C)$ 在点 $B$ 和 $Y$ 相交，因此这两条直线必须相同。但这意味着 $A = C$，矛盾。同理，$X != Z$ 且 $Y != Z$。
]

#proof[
  定义如下曲线：$ ell_1 = overline(E F) quad quad ell_2 = overline(A B) quad quad ell_3 = overline(C D) \ m_1 = overline(B C) quad quad m_2 = overline(D E) quad quad m_3 = overline(F A) $

  我们得到如下交点表：

  #figure[
    #table(
      columns: (auto, auto, auto, auto),
      align: center,
      stroke: none,
      table.hline(),
      table.header([], table.vline(), $ell_1$, $ell_2$, $ell_3$),
      table.hline(),
      $m_1$, $Y$, $B$, $C$,
      $m_2$, $E$, $X$, $D$,
      $m_3$, $F$, $A$, $Z$,
      table.hline(),
    )
  ]

  设 $q(x, y) = 0$ 是该圆锥曲线的仿射方程。为了应用 @theo:the-nine-point-confluence，我们将 $q(x, y)$ 改写为它的齐次形式 $Q(x, y, z)$。设 $ell(x, y, z)$ 是给出通过点 $X$ 和 $Y$ 的直线的线性形式。那么 $ C(x, y, z) = Q(x, y, z) ell(x, y, z) $ 是一个三次齐次多项式。曲线 $C = 0$ 包含表格中除了可能的 $Z$ 以外的所有点。可以容易地验证，$C$ 的唯一奇异点是 $Q = 0$ 和 $ell = 0$ 的交点，以及在退化圆锥曲线情况下 $Q = 0$ 所组成的两条直线的交点。由于我们考虑的这些点中没有一个是这些奇异点，@theo:the-nine-point-confluence 的假设就得到了满足。因此，$C(Z) = 0$。又由于 $Q(Z) != 0$，我们必须有 $ell(Z) = 0$，即 $Z$ 落在通过 $X$ 和 $Y$ 的直线上。因此，$X, Y, Z$ 共线。这就完成了帕斯卡定理的证明。
]

#corollary[帕普斯定理][
  设 $ell$ 和 $m$ 是平面上的两条不同的直线。设 $A, B, C$ 是 $ell$ 上的三个不同点，$A', B', C'$ 是 $m$ 上的三个不同点。假设这些点中没有任何一点是 $ell$ 和 $m$ 的交点。令 $X$ 为直线 $overline(A B')$ 与直线 $overline(A' B)$ 的交点，$Y$ 为直线 $overline(B' C)$ 与直线 $overline(B C')$ 的交点，$Z$ 为直线 $overline(C A')$ 与直线 $overline(C' A)$ 的交点。则点 $X, Y, Z$ 共线（见 @fig:pascals-theorem）。

]

#proof[
  这是 @theo:pascals-theorem 中退化圆锥曲线的一个情形。此时的“六边形”是 $A B' C A' B C'$

]

#figure(caption: [帕普斯定理])[
  #cetz.canvas({
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 1.5pt))
    /// y = x/8 + 1
    line((-1, 7 / 8), (9, 17 / 8))
    /// y = -x/8 - 1
    line((-1, -7 / 8), (9, -17 / 8))
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    circle((0, 1), name: "A", radius: 0)
    content("A", $ A $, anchor: "south", padding: 0.1)
    circle((0, -1), name: "A'", radius: 0)
    content("A'", $ A' $, anchor: "north", padding: 0.1)
    circle((6, 7 / 4), name: "B", radius: 0)
    content("B", $ B $, anchor: "south", padding: 0.1)
    circle((2, -5 / 4), name: "B'", radius: 0)
    content("B'", $ B' $, anchor: "north", padding: 0.1)
    circle((8, 2), name: "C", radius: 0)
    content("C", $ C $, anchor: "south", padding: 0.1)
    circle((8, -2), name: "C'", radius: 0)
    content("C'", $ C' $, anchor: "north", padding: 0.1)

    line((0, 1), (2, -5 / 4))
    line((0, 1), (8, -2))

    line((0, -1), (6, 7 / 4))
    line((0, -1), (8, 2))

    line((6, 7 / 4), (8, -2))
    line((2, -5 / 4), (8, 2))

    /// y = 3/10 x - 4/5
    line((0, -4 / 5), (15 / 2, 29 / 20), stroke: (dash: "dashed"))
  })
]

== 椭圆曲线的其他方程式 <sec:other-equations-of-elliptic-curves>

在本书中，我们主要使用 Weierstrass 形式来表示椭圆曲线。然而，椭圆曲线还可以以其他多种形式出现，简要地讨论这些不同的表示方式也是有意义的。

=== Legendre 方程 <subsec:legendre-equation>

这是一种 Weierstrass 方程的变体。它的优点是允许我们用一个参数来表示定义在代数闭域（特征不为 2）上的所有椭圆曲线。

#proposition[
  令 $K$ 为特征不为 2 的域，且令 $ y^2 = x^3 + a x^2 + b x + c = (x - e_1) (x - e_2) (e_3) $ 是定义在 $K$ 上的椭圆曲线 $E$，其中 $e_1, e_2, e_3 in K$，令 $ x_1 = (e_2 - e_1)^(-1) (x - e_1) quad quad y_1 = (e_2 - e_1)^(-3/2) y quad quad lambda = frac(e_3 - e_1, e_2 - e_1) $

  则 $lambda != 0, 1$，且 $ y_1^2 = x_1 (x_1 - 1) (x_1 - lambda) $
]

#proof[
  直接计算即可。

]

参数 $lambda$ 并不是椭圆曲线 $E$ 的唯一表示。事实上，以下每个数值 $ { lambda, 1/lambda, 1 - lambda, 1/(1 - lambda), lambda/(1 - lambda), (lambda - 1)/lambda } $ 都给出了 $E$ 的一个 Legendre 形式。这些数值对应于根 $e_1, e_2, e_3$ 的六种排列方式。可以证明，这些是唯一对应于 $E$ 的 $lambda$ 值，因此 $lambda |-> E$ 的映射是六对一的，除了某些特殊值 $lambda = -1, 1 \/ 2, 2$ 或满足 $lambda^2 - lambda + 1 = 0$ 的值。在这些情形中，上述集合会塌缩成更少的值（见 @exercise:2-13）。

=== 三次方程 <subsec:cubic-equations>

我们有可能可以从一个三次方程 $C(x, y)$ 出发，其定义在特征不为 2 或 3 的域 $K$ 上，并且有一个满足 $x, y in K$ 的点，以及找到一个可逆的变量变换，来将它化为 Weierstrass 形式（尽管可能有 $4 A^3 + 27 B^2 = 0$）。这个变换过程相当复杂（见 @ref:cohen1993algebraic、@ref:connell1992addendum 或 @ref:nagell1929arithmetique），因此我们仅考虑一个具体的例子。

考虑三次费马方程 $ x^3 + y^3 + z^3 = 0 $

这一方程在 $x y z != 0$ 的条件下没有有理数解的事实早在公元 900 年代便被阿拉伯数学家所猜想。这是费马大定理的一个特例，其断言两个非零整数的 $n$ 次幂之和不可能等于另一个非零整数的 $n$ 次幂，其中 $n >= 3$。对于 $n = 3$ 的情形，最早的证明可能是由费马本人给出的。我们将在 @chap:fermat-last-theorem 讨论更一般情形下的部分证明思想。

现在假设 $x^3 + y^3 + z^3 = 0$，且 $x y z != 0$。由于 $x^3 + y^3 = (x + y)(x^2 - x y + y^2)$，必然有 $x + y != 0$。记 $ x/z = u + v quad quad y/z = u - v $ 则有 $(u + v)^3 + (u - v)^3 + 1 = 0$，整理得 $2 u^3 + 6 u v^2 + 1 = 0$。由于 $x + y != 0 ==> u != 0$，可除以 $u^3$ 并整理得 $ 6(v/u)^2 = -(1/u)^3 - 2 $

令 $ x_1 = (-6)/u = -12 z/(x + y) quad quad y_1 = (36v)/u = 36 (x - y)/(x + y) $

则 $ y_1^2 = x_1^3 - 432 $

可以证明（但不容易）该方程的所有有理数解只有 $(x_1, y_1) = (12, plus.minus 36)$ 以及 $infinity$。$y_1 = 36$ 时可以得到 $x - y = x + y$，因此 $y = 0$。相似地，$y_1 = -36$ 时得到 $x = 0$。点 $(x_1, y_1) = infinity$ 对应于 $x = -y$，这意味着 $z = 0$。因此，当 $x y z != 0$ 时，方程 $x^3 + y^3 + z^3 = 0$ 没有解。

=== 四次方程 <subsec:quartic-equations>

有时我们会遇到由如下形式的方程定义的曲线

$ v^2 = a u^4 + b u^3 + c u^2 + d u + e $ <eq:v2-equal-au4-plus-bu3-plus-cu2-plus-du-plus-e>

其中 $a != 0$。如果我们有一个点 $(p, q)$ 在这条曲线上，且 $p, q in K$，那么该方程（在非奇异的情况下）可以通过一个可逆的变量代换转换为 Weierstrass 形式；该变量代换使用系数在域 $K$ 中的有理函数。注意，定义在域 $K$ 上的椭圆曲线 $E$ 总有一个 $E(K)$ 中的点，即无穷远点 $infinity$（它的射影坐标为 $(0 : 1 : 0)$，显然在 $K$ 中）。因此，如果我们要将一条曲线 $C$ 转换为 Weierstrass 形式，并且要求描述这个代换的所有有理函数的系数都在 $K$ 中，那么我们必须从一个坐标在 $K$ 中的点开始。

确实存在一些形如 @eq:v2-equal-au4-plus-bu3-plus-cu2-plus-du-plus-e 的曲线，其上没有坐标在 $K$ 中的点。这种现象将在 @chap:elliptic-curves-over-Q 中更详细地讨论。

假设我们有一条由方程 @eq:v2-equal-au4-plus-bu3-plus-cu2-plus-du-plus-e 定义的曲线，并且有一个点 $(p, q)$ 在这条曲线上。通过将 $u$ 替换为 $u + p$，我们可以假设 $p = 0$，于是该点的形式为 $(0, q)$。

首先，假设 $q = 0$。如果 $d = 0$，那么曲线在点 $(u, v) = (0, 0)$ 处是奇异的。因此，假设 $d != 0$。于是我们有 $ (v/(u^2))^2 = d (1/u)^3 + c (1/u)^2 + b (1/u) + a $

这个方程可以很容易地被转换为以 $d \/ u$ 和 $d v \/ u^2$ 为变量的 Weierstrass 方程。

更困难的情况是当 $q != 0$ 时。我们有如下结果。

#theorem[
  令域 $K$ 的特征不为 2，考虑方程 $ v^2 = a u^4 + b u^3 + c u^2 + d u + e $ 其中 $a, b, c, d, q in K$。令 $ x = frac(2 q (v + q) + d u, u^2) quad quad y = frac(4 q^2 (v + q) + 2 q (d u + c u^2) - (d^2 u^2 \/ 2q), u^3) $

  定义 $ a_1 = d/q quad quad a_2 = c - (d^2)/(4 q^2) quad quad a_3 = 2 q b quad quad a_4 = -4 q^2 a quad quad a_6 = a_2 a_4 $ 则 $ y^2 + a_1 x y + a_3 y = x^3 + a_2 x^2 + a_4 x + a_6 $

  逆变换为 $ u = frac(2 q (x + c) - (d^2 \/ 2q), y) quad quad v = -q + frac(u (u x - d), 2q) $

  点 $(u, v) = (0, q)$ 对应于点 $(x, y) = infinity$，且点 $(u, v) = (0, -q)$ 对应于点 $(x, y) = (-a_2, a_1 a_2 - a_3)$。
] <theo:quartic-to-weierstrass>

#proof[
  证明大部分都是直接计算，因此省略。关于点 $(0, −q)$ 的像，见 @ref:connell1992addendum。

]

#example[
  考虑等式 $ v^2 = u^4 + 1 $ <eq:v2-equal-u4-plus-1>

  那么 $a = 1, b = c = d = 0$ 及 $q = 1$。如果 $ x = frac(2(v + 1), u^2) quad quad y = frac(4(v + 1), u^3) $ 那么我们可以推出一个椭圆曲线 $E$ 由 $ y^2 = x^3 - 4x $ 给出。

  逆变换为 $ u = (2x)/y quad quad v = -1 + (2x^3)/(y^2) $

  点 $(u, v) = (0, 1)$ 对应于 $E$ 上的点 $infinity$，而点 $(u, v) = (0, -1)$ 对应点 $(0, 0)$。我们将在 @chap:elliptic-curves-over-Q 证明 $ E(QQ) = {infinity, (0, 0), (2, 0), (-2, 0)} $

  它们对应于点 $(u, v) = (0, 1), (0, -1)$ 和在无穷远处的点。因此，该四次曲线上唯一有限的有理点是 $(u, v) = (0, plus.minus 1)$。由此可以轻易推得，方程 $ a^4 + b^4 = c^2 $ 的唯一整数解满足 $a b = 0$。这就得出了费马定理在指数为 4 时成立。我们将在 @chap:elliptic-curves-over-Q 中更详细地讨论这一点。

  值得简要考虑 $u, v$ 在无穷远处的情形。将 @eq:v2-equal-u4-plus-1 齐次化后，得到 $ F(u, v, w) = v^2 w^2 - u^4 - w^4 = 0 $

  无穷远点满足 $w = 0$。为了找出它们，我们令 $w = 0$，得到 $0 = u^4$，这意味着 $u = 0$。因此我们只得到一点 $(u : v : w) = (0 : 1 : 0)$。但在相应的 Weierstrass 形式中，我们有两个点，即 $(2, 0)$ 和 $(-2, 0)$。问题在于 $(u : v : w) = (0 : 1 : 0)$ 是四次模型中的一个奇点。在这一点有 $ F_u = F_v = F_w = 0 $

  此时发生的是曲线在点 $(u : v : w) = (0 : 1 : 0)$ 处自相交。曲线的一支是 $v = +u^2 sqrt(1 + (1 \/ u)^4)$，另一支是 $v = -u^2 sqrt(1 + (1 \/ u)^4)$。为简便起见，我们在实数或复数域上进行讨论。如果将第二个表达式代入 $x = 2(v + 1) \/ u^2$ 并令 $u -> infinity$，我们可以得到 $ x = frac(2(v + 1), u^2) = frac(2(1 - u^2 sqrt(1 + (1 \/ u)^4)), u^2) -> -2 $

  如果使用另一支，则会得到 $x -> +2$。所以将四次方程转换为 Weierstrass 方程的变换将两条分支在这个奇点处拉开了（术语为“奇点解消”）。
] <example:quartic-to-weierstrass>

=== 两个二次曲面的相交 <subsec:intersection-of-two-quadratic-surfaces>

在三维空间中，两条二次曲面交于一条曲线，并且这条曲线上的某一点通常构成一条椭圆曲线。我们不在最一般的情形下讨论，而是考虑如下形式的一对方程 $ a u^2 + b v^2 = e quad quad c u^2 + d w^2 = f $ 其中 $a, b, c, d, e, f$ 是特征不为 2 的域 $K$ 中的非零元素。每一个方程可以看作是 $u v w$ - 空间中的一个曲面，它们的交集是一条曲线。我们将说明：若已知交点上的一点 $P$，则这条曲线可以变换成一个Weierstrass 形式的椭圆曲线。

在分析这两个曲面的交集之前，先考虑第一个方程本身。它可被视为定义了 $u v$ - 平面上的一条曲线 $C$。设 $P = (u_0, v_0)$ 是 $C$ 上的一点。令 $L$ 为通过 $P$ 且斜率为 $m$ 的直线：$ u = u_0 + t quad quad v = v_0 + m t $

我们希望找到 $L$ 与曲线 $C$ 的另一个交点。见 @fig:intersection-of-two-quadratic-surfaces。将上式代入 $C$ 的方程，并利用 $a u_0^2 + b v_0^2 = e$ 这一事实，得到 $ a(2 u_0 t + t^2) + b(2 v_0 m t + m^2 t^2) = 0 $

#figure(caption: [两个二次曲面的相交])[
  #cetz.canvas(length: 4em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    circle((0, 0), radius: (2, 1.2), name: "C")
    content("C.north-east", $ C $, anchor: "south", padding: 0.1)

    line((2.2, -0.085714), (-1.5, 1.5), name: "L")
    content("L", $ L $, anchor: "south-west", padding: 0.05)

    circle((-648 / 999, 42 / 37), radius: 0, name: "uv")
    content("uv", $ (u, v) $, anchor: "south", padding: 0.1)

    circle((2, 0), radius: 2pt, name: "u0v0", fill: colors.text)
    content("u0v0", $ (u_0, v_0) $, anchor: "north-east", padding: 0.1)
  })
] <fig:intersection-of-two-quadratic-surfaces>

因为 $t = 0$ 对应于点 $(u_0, v_0)$，我们将 $t$ 提出并得到 $ t = - frac(2 a u_0 + 2 b v_0 m, a + b m^2) $

因此 $ u = u_0 - frac(2 a u_0 + 2 b v_0 m, a + b m^2) quad quad v = v_0 - frac(2 a m u_0 + 2 b v_0 m^2, a + b m^2) $

我们作如下约定：令 $m = infinity$ 时，所对应的点为 $(u_0, -v_0)$，这正是当我们在实数情况下令 $m -> infinity$ 所得到的点。另外，也可能存在分母 $a + b m^2$ 为零的情形，此时我们得到的是 $u v$ - 射影平面中的“无穷远点”（见 @exercise:2-14）。

注意：如果 $(u, v)$ 是定义在 $K$ 上的 $C$ 上任意一点，那么连接该点与 $P$ 的直线的斜率 $m$ 也属于 $K$（或为无穷大）。因此，我们实际上在 $m$ 的取值（含 $infinity$）与 $C$ 上的点（含无穷远点）之间建立了一个双射（除去一些技术性细节）。关键是我们得到了 $C$ 上点的一个参数化方式。对于任何包含一个 $K$ 上点的二次曲线，这种方法都是可行的。

哪一个 $m$ 值对应于原始点 $(u_0, v_0)$ 呢？答案是 $m$ 为 $(u_0, v_0)$ 处切线的斜率。因为切线与曲线的另一个交点仍为 $(u_0, v_0)$，所以该斜率即是我们想要的 $m$。当 $m = 0$ 时，对应的点为 $(-u_0, v_0)$。这一点可以通过公式看出，也可以通过考虑点 $(-u_0, v_0)$ 与 $(u_0, v_0)$ 之间连线的斜率为 0 得出。

我们现在希望将 $C$（视作 $u v w$ - 空间中的“圆柱面”）与曲面 $c u^2 + d w^2 = f$ 相交。将刚才求得的 $u$ 的表达式代入，可得 $ d w^2 = f - c (u_0 - frac(2 a u_0 + 2 b v_0 m, a + b m^2))^2 $

这可以重写为 $ d (w (a + b m^2))^2 & = (a + b m^2)^2 f - c(b u_0 m^2 - 2b v_0 m - a u_0)^2 \
                    & = (b^2 f - c b^2 u_0^2) m^4 + dots.c $

现在可以通过前面给出的方法将其化为 Weierstrass 形式。注意，首项系数 $b^2 f - c b^2 u_0^2$ 等于 $b^2 d w_0^2$。如果 $w_0 = 0$，那么四次多项式变为三次多项式，因此上述方程很容易化为 Weierstrass 形式。这个三次多项式的首项当且仅当 $v_0 = 0$ 时为零。但在这种情形下，点 $(u_0, v_0, w_0) = (u_0, 0, 0)$ 是 $u v w$ 曲线上的奇异点 —— 这是我们应当避免的情形（见 @exercise:2-15）。

将“平方 $=$ 四次多项式”转化为 Weierstrass 形式的过程中，需要一个满足该方程的点。我们可以令 $m$ 为点 $(u_0, v_0)$ 处切线的斜率，该值对应点 $(u_0, v_0)$。@theo:quartic-to-weierstrass 中的公式要求我们将 $m$ 的值作平移，从而使 $m = 0$。不过，直接使用 $m = 0$ 更为方便，因为如上文所指出的，该值对应的点是 $(-u_0, v_0)$。

#example[
  考虑 $ u^2 + v^2 = 2 quad quad u^2 + 4w^2 = 5 $ 相交。令 $(u_0, v_0, w_0) = (1, 1, 1)$。首先，我们对 $u^2 + v^2 = 2$ 的解进行参数化。令 $u = 1 + t, v = 1 + m t$，得出 $ (1 + t)^2 + (1 + m t)^2 = 2 $

  由此得到 $t(2 + 2m) + t^2 (1 + m^2) = 0$，舍去解 $t = 0$ 得到 $t = - (2 + 2m) \/ (1 + m^2)$，于是

  $
    u = 1 - frac(2 + 2m, 1 + m^2) = frac(m^2 - 2m - 1, 1 + m^2) quad quad
    v = 1 - m frac(2 + 2m, 1 + m^2) = frac(1 - 2m - m^2, 1 + m^2)
  $

  注意 $m = -1$ 对应于点 $(u, v) = (1, 1)$（因为该点处的切线斜率为 $m = -1$）。将此代入 $u^2 + 4w^2 = 5$ 得到 $ 4(w(1 + m^2))^2 & = 5(1 + m^2)^2 - (m^2 - 2m - 1)^2 \
                  & = 4m^4 + 4m^3 + 8m^2 - 4m + 4 $

  设 $r = w(1 + m^2)$，则 $ r^2 = m^4 + m^3 + 2m^2 - m + 1 $

  在 @theo:quartic-to-weierstrass 中，我们使用 $q = 1$。于是这些公式将这条曲线转化为广义 Weierstrass 方程 $ y^2 - x y + 2y = x^3 + frac(7, 4)x^2 - 4x - 7 $

  配方得 $ y_1^2 = x^3 + 2 x^2 - 5 x - 6 $ 其中 $y_1 = y + 1 - x \/ 2$
]

== 其他坐标系 <sec:other-coordinate-systems>

在 Weierstrass 形式下，椭圆曲线上两点相加需要 2 次乘法，1 次平方以及 1 次求逆。尽管求逆运算本身是快速的，但它比乘法要慢得多。根据 @ref:cohen2005handbook[第 282 页] 的估计，一次求逆的时间大约是一次乘法的 9 到 40 倍。此外，平方运算的耗时大约是乘法的 0.8 倍。在许多情况下，这样的差异并不重要。然而，如果一个中心服务器需要每秒验证大量签名，这种差异就可能变得显著。因此，在某些情形下，在点加法公式中避免使用求逆运算是有利的。在本节中，我们将讨论几种可以避免求逆的替代表达式。

=== 射影坐标 <subsec:projective-coordinates>

一个很自然的方法就是将所有的点都表示为射影空间中的点 $(x : y : z)$，通过在加法的标准公式中清除分母，我们得到如下形式：

令 $P_i = (x_i, y_i, z_i), i = 1, 2$ 是椭圆曲线 $y^2 z = x^3 + A x z^2 + B z^3$，那么 $ (x_1 : y_1 : z_1) + (x_2 : y_2 : z_2) = (x_3 : y_3, z_3) $ 其中 $x_3, y_3, z_3$ 由如下步骤得到：

当 $P_1 != plus.minus P_2$ 时

$
  u = y_2 z_1 - y_1 z_2 quad quad v = x_2 z_1 - x_1 z_2 quad quad w = u^2 z_1 z_2 - v^3 - 2 v^2 x_1 z_2 \
  x_3 = v w quad quad y_3 = u (v^2 x_1 z_2 - w) quad quad z_3 = v^3 z_1 z_2
$

当 $P_1 = P_2$ 时

$
  t = A z_1^2 + 3 x_1^2 quad quad u = y_1 z_1 quad quad v = u x_1 y_1 quad quad w = t^2 - 8 v \
  x_3 = 2 u w quad quad y_3 = t (4 v - w) - 8 y_1^2 u^2 quad quad z_3 = 8 u^3
$

当 $P_1 = - P_2$ 时，我们有 $P_1 + P_2 = infinity$。

点加法需要 12 次乘法和 2 次平方，而点倍加需要 7 次乘法和 5 次平方。不需要求逆。由于加法和减法比乘法快得多，我们在分析中不予考虑。同样地，乘以一个常数也不包括在内。

=== Jacobian 坐标 <subsec:jacobian-coordinates>

射影坐标的一种改进可以加快点倍加的运算。令 $(x : y : z)$ 表示仿射点 $(x \/ z^2, y \/ z^3)$。这是比较自然的选择，因为正如我们将在 @chap:divisors 看到的，函数 $x$ 在 $infinity$ 有一个二阶极点，函数 $y$ 有一个三阶极点。椭圆曲线 $y^2 = x^3 + A x + B$ 因此变为 $ y^2 = x^3 + A x z^4 + B z^6 $ 此时无穷远点的坐标为 $(1 : 1 : 0)$。

令 $P_i = (x_i, y_i, z_i), i = 1, 2$ 是椭圆曲线 $y^2 z = x^3 + A x z^2 + B z^3$，那么 $ (x_1 : y_1 : z_1) + (x_2 : y_2 : z_2) = (x_3 : y_3, z_3) $ 其中 $x_3, y_3, z_3$ 由如下步骤得到：

当 $P_1 != plus.minus P_2$ 时

$
  r = x_1 z_2^2 quad quad s = x_2 z_1^2 quad quad t = y_1 z_2^3 quad quad u = y_2 z_1^3 quad quad v = s - r quad quad w = u - t \
  x_3 = - v^3 - 2 r v^2 + w^2 quad quad y_3 = - t v^3 + (r v^2 - x_3) w quad quad z_3 = v z_1 z_2
$

当 $P_1 = P_2$ 时

$
  v = 4 x_1 y_1^2 quad quad w = 3 x_1^2 + A z_1^4 \ x_3 = - 2 v + w^2 quad quad y_3 = - 8 y_1^4 + (v - x_3) w quad quad z_3 = 2 y_1 z_1
$

当 $P_1 = - P_2$ 时，我们有 $P_1 + P_2 = infinity$。

点加法需要 12 次乘法和 2 次平方，而点倍加需要 7 次乘法和 5 次平方。不需要求逆。

若 $A = -3$，倍加还可加速：有 $w = 3(x_1^2 - z_1^4) = 3(x_1 + z_1^2)(x_1 - z_1^2)$，只需 1 次平方和 1 次乘法，而不是 3 次平方。因此倍加仅需 4 次乘法和 4 次平方。NIST 曲线列表中那些定义在域 $FF_p$ 上的椭圆曲线（见 @ref:ieee13632000，@ref:hankerson2004guide[第 262 页]）之所以选择 $A = -3$，正是出于这一优化考虑。

此外，在某些情况下，可以高效地将不同坐标系下的点相加。例如，将一个 Jacobian 坐标表示的点与一个仿射坐标的点相加，仅需 8 次乘法和 3 次平方。关于更多坐标系选择和高效点加法的内容，可参考 @ref:hankerson2004guide[第 3.2、3.3 节] 和 @ref:cohen2005handbook[第 13.2、13.3 节]。

=== Edwards 坐标 <subsec:edwards-coordinates>

在文献 @ref:edwards2007normal 中，Harold Edwards 描述了一种具有某些计算优势的椭圆曲线形式。特别地，当 $c = 1, d = -1$ 时，这种形式出现在 Euler 和 Gauss 的工作中。而 Edwards 自身限制讨论了 $d = 1$ 的情况。之后，Bernstein 和 Lange 在 @ref:bernstein2007faster 中进一步研究了这种更一般形式的曲线。

#proposition[
  令 $K$ 是特征不为 2 的域，令 $c, d in K$ 且 $c, d != 0$，$d$ 在 $K$ 中不是平方数，则曲线 $ C: u^2 + v^2 = c^2 (1 + d u^2 v^2) $ 和曲线 $ E: y^2 = (x - c^4 d - 1) (x^2 - 4 c^4 d) $ 在代数上是同构的，其变量代换为 $ x = frac(-2 c (w - c), u^2) quad quad y = frac(4 c^2 (w - c) + 2 c (c^4 d + 1) u^2, u^3) $ 其中 $w = (c^2 d u^2 - 1) v$。

  曲线 $C$ 上的点 $(0, c)$ 是其加法群结构中的单位元，点加法公式为 $ (u_1, v_1) + (u_2. v_2) = (frac(u_1 v_2 + u_2 v_1, c (1 + d u_1 u_2 v_1 v_2 )), frac(v_1 v_2 - u_1 u_2, c (1 - d u_1 u_2 v_1 v_2))) $ 且适用于所有的点 $(u_i, v_i) in C(K)$。点的负值为 $- (u, v) = (-u, v)$。
]

#proof[
  /// TODO: Keep translate here...
]

== $j$-不变量 <sec:the-j-invariant>

#theorem[]

#proof[]

== 定义在特征为 2 的域上的椭圆曲线 <sec:elliptic-curves-in-characteristic-2>

== 自同态 <sec:endomorphisms>

#example[]

#example[]

#example[]

#lemma[]

#proof[]

#proposition[]

#proof[]

#theorem[]

#remark[]

#proof[]

#lemma[]

#proof[]

#remark[]

#lemma[]

#proof[]

#remark[]

#proposition[]

#proof[]

#proposition[]

#proof[]

== 奇异曲线 <sec:singular-curves>

我们一直在研究 $y^2 = x^3 + A x + B$ 并假设 $x^3 + A x + B$ 有不同的根。然而，当有重根时会发生什么是有趣的。椭圆曲线的加法将变为域 $K$ 中元素的加法，或者域 $K^times$ 中元素的乘法，又或者域 $K$ 的二次扩张中的乘法。这意味着椭圆曲线群 $E(K)$ 的算法，如解决离散对数问题的算法（见 @chap:the-discrete-logarithm-problem），也可能适用于这些更熟悉的情况，见 @chap:other-applications。此外，如本节末尾将简要讨论的，奇异曲线在椭圆曲线定义于整数并模各种质数时自然出现。

我们先考虑 $x^3 + A x + B$ 在 $x=0$ 处有三重根的情况，曲线方程为 $ y^2 = x^3 $

点 $(0, 0)$ 是该曲线上唯一的一个奇点（见 @fig:y2-x3）。

#figure(caption: $y^2 = x^3$)[
  #cetz.canvas(length: 8em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    let y(x) = {
      let y2 = x * x * x
      if y2 < 0 { return () }
      let y = calc.sqrt(y2)
      return ((x, y), (x, -y))
    }

    for i in range(0, 100) {
      let p = y(i / 100)
      let p2 = y((i + 1) / 100)
      if p.len() == 0 or p2.len() == 0 { continue }
      line(p.at(0), p2.at(0))
      line(p.at(1), p2.at(1))
    }

    line((-0.05, 0), (1.05, 0))
    line((0, -1), (0, 1))
  })
] <fig:y2-x3>

由于包含点 $(0, 0)$ 会导致问题，所以我们将其排除在外。剩下的点，我们记作 $E_(n s) (K)$，构成一个群，群律与三次多项式有不同根时相同。唯一需要验证的是，两点之和不可能是 $(0, 0)$。但由于通过 $(0, 0)$ 的直线最多与曲线相交另一点，通过两个非奇异点的直线不可能经过 $(0, 0)$（这一点也将在下面定理的证明中得到体现）。

#theorem[]

#proof[]

#figure(caption: $y^2 = x^3 + x^2$)[
  #cetz.canvas(length: 6em, {
    import cetz.draw: *
    set-style(stroke: (paint: colors.text, thickness: 0.5pt))

    let y(x) = {
      let y2 = x * x * x + x * x
      if y2 < 0 { return () }
      let y = calc.sqrt(y2)
      return ((x, y), (x, -y))
    }

    for i in range(-100, 100) {
      let p = y(i / 100)
      let p2 = y((i + 1) / 100)
      if p.len() == 0 or p2.len() == 0 { continue }
      line(p.at(0), p2.at(0))
      line(p.at(1), p2.at(1))
    }

    line((-1.05, 0), (1.05, 0))
    line((0, -1.5), (0, 1.5))
  })
] <fig:y2-x3-x2>

== 模 $n$ 的椭圆曲线 <sec:elliptic-curves-mod-n>

#pagebreak()
#heading(numbering: none, level: 2)[练习]

#exercise[
  + 证明一元三次首一多项式的常数项等于其根的乘积的相反数。

  + 利用 1. 的结果，推导横坐标均不为零的两点 $P_1, P_2$ 的加法公式，如 @sec:group-law。当两坐标其一为 0 时，使用通常的公式会涉及除以 0，因此须特别处理。
] <exercise:2-1>

#exercise[
] <exercise:2-2>

#exercise[
] <exercise:2-3>

#exercise[
] <exercise:2-4>

#exercise[
  令 $(x, y)$ 是椭圆曲线 $E: y^2 = x^3 + A x + B$ 上的一点，证明若 $y = 0$，则 $3x^2 + A != 0$。（提示：一个多项式的 $x$ 有重根的条件是什么？）

] <exercise:2-5>

#exercise[
] <exercise:2-6>

#exercise[
] <exercise:2-7>

#exercise[
] <exercise:2-8>

#exercise[
] <exercise:2-9>

#exercise[
] <exercise:2-10>

#exercise[
] <exercise:2-11>

#exercise[
] <exercise:2-12>

#exercise[
] <exercise:2-13>

#exercise[
] <exercise:2-14>

#exercise[
] <exercise:2-15>

#exercise[
] <exercise:2-16>

#exercise[
] <exercise:2-17>

#exercise[
] <exercise:2-18>

#exercise[
] <exercise:2-19>

#exercise[
] <exercise:2-20>

#exercise[
] <exercise:2-21>

#exercise[
] <exercise:2-22>

#exercise[
] <exercise:2-23>

#exercise[
] <exercise:2-24>
/// END: Chapter

/// START: Chapter
= 挠点 <chap:torsion-points>

挠点，即阶数是有限的点，在椭圆曲线的研究中扮演着重要角色。我们将在 @chap:elliptic-curves-over-finite-fields 中看到它们在有限域上的椭圆曲线中所起的作用，在那里所有的点都是挠点；而在 @chap:elliptic-curves-over-Q 中，我们将在一个称为降维的过程中使用到 2-挠点。在本章中，我们首先考虑 2-阶与 3-阶的基本情形，然后再确定一般情况。最后，我们将讨论重要的 Weil 配对与 Tate-Lichtenbaum 配对。

== 挠点 <sec:torsion-points>

== Division Polynomials

== Weil 配对 <sec:torsion-points-weil-pairing>

== Tate-Lichtenbaum 配对 <sec:torsion-points-tate-lichtenbaum-pairing>

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Elliptic Curves over Finite Fields <chap:elliptic-curves-over-finite-fields>

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

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= The Discrete Logarithm Problem <chap:the-discrete-logarithm-problem>

== The Index Calculus

== General Attacks on Discrete Logs

=== Baby Step, Giant Step

=== Pollard's $rho$ and $lambda$ Method

== Attacks with Pairings

=== The MOV Attack

=== The Frey-Rück Attack

== Anomalous Curves <sec:anomalous-curves>

== Other Attacks

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= 椭圆曲线密码学 <chap:elliptic-curves-cryptography>

本章我们将讨论几种基于椭圆曲线的密码系统，特别是椭圆曲线离散对数问题相关的系统。我们还会涉及一些相关的内容，比如数字签名。

有人可能会疑问，为什么在密码学中使用椭圆曲线。原因是椭圆曲线在提供与传统系统等效的安全性的同时，所需的密钥位数更少。比如，据文献 @ref:blake2000elliptic 估计，RSA 需要 4096 位密钥才能达到的安全级别，椭圆曲线系统只需 313 位密钥即可实现。这意味着椭圆曲线密码系统的实现对芯片面积、功耗等的要求更低。Daswani 和 Boneh @ref:boneh1999palm 在使用 3Com 的 PalmPilot（一个比智能卡大但比笔记本电脑小的小型手持设备）进行实验时发现，生成一个 512 位的 RSA 密钥需要 3.4 分钟，而生成一个 163 位的 ECC-DSA 密钥仅需 0.597 秒。虽然某些操作，如签名验证，RSA 稍快一些，但椭圆曲线方法如 ECC-DSA 在许多情况下明显提升了速度。

== 基本配置

Alice 想要给 Bob 发送一条消息，通常称为 *明文*。为了防止窃听者 Eve 读取消息，Alice 会对消息进行加密，得到 *密文*。当 Bob 收到密文后，他解密密文并读取消息。为了加密消息，Alice 使用一个 *加密密钥*；Bob 使用一个 *解密密钥* 来解密密文。显然，解密密钥必须对 Eve 保密。

加密主要有两种基本类型。*对称加密* 中，加密密钥和解密密钥相同，或者一个可以很容易地从另一个推导出来。常见的对称加密方法包括数据加密标准（DES）和高级加密标准（AES，常称其原始名称 `Rijndael`）。在这种情况下，Alice 和 Bob 需要某种方式来建立密钥。比如，Bob 可以提前几天派信使把密钥送给 Alice。这样当需要发送消息时，他们双方都有密钥。显然，这在很多情况下是不切实际的。

另一种加密方式是 *公钥加密*，也叫非对称加密。在这种方式下，Alice 和 Bob 不需要事先联系。Bob 会公布一个公钥，供 Alice 使用，同时他拥有一个私钥，可以用来解密密文。因为公钥是公开的，理应无法从公钥推导出私钥。最著名的公钥系统是基于质因数分解困难问题的 RSA 系统；另一个著名系统是 ElGamal，基于离散对数难题。

通常公钥系统比好的对称加密系统要慢。因此，常见做法是用公钥系统先建立一个密钥，然后用该密钥进行对称加密。当传输大量数据时，这样的速度提升非常重要。

== 迪菲-赫尔曼密钥交换 <sec:diffe-hellman-key-exchange>

Alice 和 Bob 希望协商出一个共同的密钥，用于通过对称加密方案如 DES 或 AES 交换数据。例如，Alice 和 Bob 可以是希望传输金融数据的银行。使用信使递送密钥既不现实又耗时。且假设 Alice 和 Bob 之前没有任何联系，他们之间唯一的通信渠道是公开的。一种建立密钥的方法是迪菲和赫尔曼提出的（实际上，他们使用的是有限域的乘法群）。

+ Alice 和 Bob 商定一条定义在有限域 $FF_q$ 上的椭圆曲线 $E$，使得在 $E(FF_q)$ 上离散对数问题是困难的。他们还同意选定曲线上的一点 $P in E(FF_q)$，使得 $P$ 生成的子群阶数很大（通常选择阶为大质数的曲线和点）。

+ Alice 选择一个秘密整数 $a$，计算 $P_a = a P$，并将 $P_a$ 发送给 Bob。

+ Bob 选择一个秘密整数 $b$，计算 $P_b = b P$，并将 $P_b$ 发送给 Alice。

+ Alice 计算 $a P_b = a b P$。

+ Bob 计算 $b P_a = b a P$。

+ Alice 和 Bob 使用某种公开约定的方法从 $a b P$ 中提取密钥。例如，他们可以取 $a b P$ 的 x 坐标的后 256 位作为密钥，或者对 x 坐标计算哈希函数值。

窃听者 Eve 所能看到的只有曲线 $E$、有限域 $FF_q$ 以及点 $P$、$a P$ 和 $b P$。因此，她需要解决以下问题：

#note(variant: [迪菲-赫尔曼问题])[
  已知 $P$、$a P$ 和 $b P in E(FF_q)$，求 $a b P$。

]

如果 Eve 能在 $E(FF_q)$ 中解决离散对数问题，就能用 $P$ 和 $a P$ 求出 $a$，然后计算 $a(b P)$ 得到 $a b P$。但目前尚不清楚是否存在不先解决离散对数问题而直接计算 $a b P$ 的方法。

一个相关问题是：

#note(variant: [判定迪菲-赫尔曼问题])[
  已知 $P$、$a P$ 和 $b P in E(FF_q)$ 和 $Q in E(FF_q)$，判断 $Q$ 是否等于 $a b P$。

]

换言之，如果 Eve 收到匿名提示给出 $a b P$，她能否验证该信息的正确性？

这两个问题可以在任意群中提出，最初是在有限域乘法群 $FF_q^times$ 中提出的。

对于椭圆曲线，Weil 配对在某些情况下可以用来解决判定迪菲-赫尔曼问题。下面给出一个例子。

设 $E$ 是定义在 $FF_q$ 上的曲线 $y^2 = x^3 + 1$，其中 $q equiv 2 (mod 3)$。根据命题 4.33，$E$ 是超奇异曲线。设 $omega in FF_(q^2)$ 是一个原始三次单位根。注意 $omega in.not FF_q$，因为 $FF_q^times$ 的阶为 $q - 1$，且不含 3 的因子。 /// TODO: Reference to Proposition 4.33

定义映射 $ beta: E(overline(FF)_q) -> E(overline(FF)_q) quad quad (x, y) |-> (omega x, y) quad quad beta(infinity) = infinity $

利用加法法则的公式，可以直接证明 $beta$ 是一个同构（@exercise:6-1）。

假设点 $P in E(F_q)$ 的阶为 $n$，则 $beta(P)$ 也具有阶 $n$。定义改良的魏尔配对 $ tilde(e)_n (P_1, P_2) = e_n (P_1, beta(P_2)) $ 其中 $e_n$ 是通常的 Weil 配对，且 $P_1, P_2 in E[n]$。

#lemma[]

== Massey-Omura 加密 <sec:massey-omura-encryption>

Alice 想通过公开信道向 Bob 发送一条消息。他们尚未建立一个私钥。一种实现方法如下：Alice 把消息放进一个盒子里并上上她自己的锁，然后将盒子寄给 Bob；Bob 在盒子上再加一把锁后寄回 Alice；Alice 拆掉她的锁后再次将盒子寄给 Bob；最后，Bob 拆掉他自己的锁，打开盒子，读取消息。

这个过程可以用数学方式如下实现：

+ Alice 和 Bob 约定一条定义在有限域 $FF_q$ 上的椭圆曲线 $E$，使得在 $E(FF_q)$ 上的离散对数问题是困难的。设 $N = \#E(FF_q)$。

+ Alice 将她的消息表示为曲线上的一点 $M in E(FF_q)$（我们将在后面讨论如何实现这一点）。

+ Alice 选择一个与 $N$ 互质的秘密整数 $m_A$，计算 $M_1 = m_A M$，并将 $M_1$ 发送给 Bob。

+ Bob 选择一个与 $N$ 互质的秘密整数 $m_B$，计算 $M_2 = m_B M_1$，并将 $M_2$ 发送给 Alice。

+ Alice 计算 $m_A^(-1) in ZZ_N$，再计算 $M_3 = m_A^(-1) M_2$，并将 $M_3$ 发送给 Bob。

+ Bob 计算 $m_B^(-1) in ZZ_N$，再计算 $M_4 = m_B^(-1) M_3$，此时 $M_4 = M$ 即原始消息。

我们来验证 $M_4$ 确实等于原始消息 $M$。形式上我们有 $ M_4 = m_B^(-1) m_A^(-1) m_B m_A M = M $

但我们还需要说明 $m_A^(-1)$ 是 $m_A$ 模 $N$ 的逆元，它们确实会相互抵消。


== ElGamal 公钥加密 <sec:elgamal-public-key-encryption>

== ElGamal 数字签名 <sec:elgamal-digital-signatures>

== 数字签名算法 <sec:the-digital-signature-algorithm>

== ECIES

== A Public Key Scheme Based on Factoring

== A Cryptosystem Based on the Weil Pairing

#pagebreak()
#heading(numbering: none, level: 2)[练习]

#exercise[] <exercise:6-1>

/// END: Chapter

/// START: Chapter
= 其他应用 <chap:other-applications>

== 使用椭圆曲线进行质因数分解 <sec:factoring-using-elliptic-curves>

== 素性检验 <sec:primality-testing>

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Elliptic Curves over $QQ$ <chap:elliptic-curves-over-Q>

== The Torsion Subgroup. The Lutz-Nagell Theorem <sec:the-torsion-subgroup-the-lutz-nagell-theorem>

== Descent and the Weak Mordell-Weil Theorem

== Heights and the Mordell-Weil Theorem

== 示例

== The Height Pairing

== Fermat's Infinite Descent <sec:fermat-infinite-descent>

== 2-Selmer Groups; Shafarevich-Tate Groups

== A Nontrivial Shafarevich-Tate Group

== Galois Cohomology

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Elliptic Curves over $CC$ <chap:elliptic-curves-over-C>

== Doubly Periodic Functions

== Tori are Elliptic Curves

== Elliptic Curves over $CC$ <sec:elliptic-curves-over-C-elliptic-curves-over-C>

== Computing Periods

=== The Arithmetic-Geometric Mean

== Division Polynomials

== The Torsion Subgroup: Doud's Method

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Complex Multiplication <chap:complex-multiplication>

== Elliptic Curves over $CC$

== Elliptic Curves over Finite Fields

== Integrality of j-invariant

== Numerical Examples

== Kronecker's Jugendtraum

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Divisors <chap:divisors>

== 定义与示例

== The Weil Pairing <sec:divisors-weil-pairing>

== The Tate-Lichtenbaum Pairing <sec:divisors-tate-lichtenbaum-pairing>

== Computation of the Pairings

== Genus One Curves and Elliptic Curves

== Equivalence of the Definitions of the Pairings

=== The Weil Pairing <subsec:divisors-weil-pairing>

=== The Tate-Lichtenbaum Pairing <subsec:divisors-tate-lichtenbaum-pairing>

== Nondegeneracy of the Tate-Lichtenbaum Pairing

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Isogenies <chap:isogenies>

== The Complex Theory <sec:complex-theory>

== The Algebraic Theory

== Vélu's Formulas

== Point Counting

== Complements

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Hyperelliptic Curves <chap:hyperelliptic-curves>

== Basic Definitions

== Divisors

== Cantor's Algorithm

== The Discrete Logarithm Problem

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= Zeta Functions <chap:zeta-functions>

== Elliptic Curves over Finite Fields

== Elliptic Curves over $QQ$

#pagebreak()
#heading(numbering: none, level: 2)[练习]
/// END: Chapter

/// START: Chapter
= 费马大定理 <chap:fermat-last-theorem>

== Overview

== Galois Representations

== Sketch of Ribet's Proof

== Sketch of Wiles' Proof

/// START: Appendix setup
#let appendix(body) = {
  set heading(numbering: (..num) => {
    if num.pos().len() == 1 {
      numbering("附录 A", num.pos().at(0))
    } else {
      numbering("A.1", ..num)
    }
  })
  counter(heading).update(0)
  body
}
#show: appendix
/// END: Appendix setup

/// START: Appendix
= 数论 <appendix:number-theory>

#heading(numbering: none, outlined: false, level: 2)[基本结论]

令 $n$ 为正整数，$ZZ_n$ 为模 $n$ 的整数，它在加法下构成一个群。我们可以使用数字 $0, 1, 2, dots.c, n - 1$ 表示 $ZZ_n$ 的元素。令 $ ZZ_n^times = { a divides 1 <= a <= n, gcd(a, n) = 1 } $ 那么 $ZZ_n^times$ 在模 $n$ 乘法下构成一个群。

令 $a in ZZ_n^times$，则使得 $a^k equiv 1 (mod n)$ 的最小正整数 $k$ 称为 *$a$ 模 $n$ 的阶*。$a$ 模 $n$ 的阶 $k$ 整除 $phi.alt(n)$，其中 $phi.alt$ 是欧拉函数。

令 $p$ 为一个质数，$a in ZZ_p^times$。$a$ 模 $p$ 的阶整除 $p - 1$。模 $p$ 的一个 *原根* #footnote[译者注：在抽象代数中，原根就是循环群的生成元。这个概念只在模 $n$ 缩剩余系关于乘法形成的群中有「原根」这个名字，在一般的循环群中都称作「生成元」—— 见 #link("https://oi-wiki.org/math/number-theory/primitive-root/#%E5%8E%9F%E6%A0%B9")[此链接]] 是一个整数 $g$，使得 $g$ 在模 $p$ 下的阶等于 $p - 1$。如果 $g$ 是模 $p$ 的一个原根，则每个整数模 $p$ 同余于 0 或某个 $g$ 的幂。例如，3 是模 7 的一个原根，且 $ { 1, 3, 9, 27, 81, 243 } equiv { 1, 3, 2, 6, 4, 5 } quad (mod 7) $

模 $p$ 的原根一共有 $phi.alt(p - 1)$ 个。特别地，模 $p$ 的原根总是存在，因此 $ZZ_p^times$ 是一个循环群。

如果已知 $p − 1$ 的素因子分解，可以用如下判据判断某个整数 $g$ 是否是模 $p$ 的原根：若对所有素因子 $q divides p - 1$，都有 $g^((p - 1) \/ q) equiv.not a$，则 $g$ 是模 $p$ 的原根。这可以通过注意到以下事实来证明：如果 $g$ 不是模 $p$ 的原根，那么它的阶是 $p - 1$ 的一个真因子，即存在某个质数 $q$ 使得它整除 $(p - 1) \/ q$。 /// TODO: Check translation

在知道 $p - 1$ 的分解的前提下，寻找原根的一个简单方法是从 $2, 3, 5, 6, dots.c$ 这些小整数开始依次试验，直到找到满足上述条件的一个原根为止。由于原根数量较多，通常很快就能找到。

数论中的一个非常有用的结论如下。

#theorem[中国剩余定理][
  令 $n_1, n_2, dots.c, n_r$ 为两两互质的正整数，且令 $a_1, a_2, dots.c, a_r$ 为整数，则存在整数 $x$，使得 $ x equiv a_i (mod n_i) $ 对所有的 $i$ 成立。

  这样的 $x$ 在模 $n_1 n_2 dots.c n_r$ 时是唯一的。
] <theo:chinese-remainder-theorem>

例如，令 $n_1 = 4, n_2 = 3, n_3 = 5$，且 $a_1 = 1, a_2 = 2, a_3 = 3$。那么 $x = 53$ 是以下同余方程组的一个解：

$ x equiv 1 quad (mod 4) quad quad x equiv 2 quad (mod 3) quad quad x equiv 3 quad (mod 5) $

且任意解 $x$ 都满足 $x equiv 53 (mod 60)$。

中国剩余定理的另一种表述方式是：如果 $n_1, n_2, dots.c, n_r$ 两两互质，则 $ ZZ_(n_1 n_2 dots.c n_r) tilde.eq ZZ_(n_1) plus.circle dots.c plus.circle ZZ_(n_r) $
（见 @appendix:groups 关于 $plus.circle$ 的定义）。这是加法群的同构，同时也是环的同构。

#heading(numbering: none, outlined: false, level: 2)[p 进数]

令 $p$ 为质数，$x$ 为非零有理数。记 $ x = p^r a/b $ 其中 $a, b$ 是满足 $p divides.not a b$ 的整数。那么 $r$ 被称为 $x$ 的 *$p$ 进赋值*，记作 $ r = v_p (x) $

定义 $v_p (0) = infinity$。（有关 $p$ 进赋值的更多内容，见 @sec:anomalous-curves 和 @sec:the-torsion-subgroup-the-lutz-nagell-theorem）$x$ 的 *$p$ 进绝对值* 定义为 $ abs(x)_p = p^(-r) $ 且定义 $abs(0)_p = 0$。

例如 $ abs(12/35)_2 = 1/4 quad quad abs(11/250)_5 = 125 quad quad abs(1/2 - 41)_3 = 1/81 $ 最后一个例子说明在 3 进意义下 $1 \/ 2$ 与 $41$ 相近。注意：两个整数在 $p$ 进意义下接近，当且仅当它们在模 $p^n$ 意义下对于足够大的 $n$ 同余。

*$p$ 进整数* 最容易被看作是 $ sum_(n = 0)^(infinity) a_n p^n quad a_n in {0, 1, 2, dots.c, p - 1} $ 形式的无穷和。这样的无穷和在实数意义下并不收敛，但在 $p$ 进绝对值下是有意义的，因为当 $n -> infinity$ 时有 $abs(a_n p^n)_p -> 0$。

加法与乘法的运算方法与有限位制数加法类似。例如，在 3 进整数中

$
  (1 + 2 dot.c 3 + 0 dot.c 3^2 + dots.c) + (1 + 2 dot.c 3 + 1 dot.c 3^2 + dots.c) & = 2 + 4 dot.c 3 + 1 dot.c 3^2 + dots.c \
  & = 2 + 1 dot.c 3 + 2 dot.c 3^2 + dots.c
$

（我们将 $4 = 1 + 3$ 重新分组，或者说是进位，以得到最后的结果）。若 $ x = a_k p^k + a_(k + 1) p^(k + 1) + dots.c $ 其中 $a_k != 0$，则 $ -x = (p - a_k) p^k + (p - 1 - a_(k + 1)) p^(k + 1) + (p - 1 - a_(k + 2)) p^(k + 2) + dots.c $ <eq:negation-in-p-adic-integers> /// TODO: A.1

（用到了 $p^(k + 1) + (p - 1) p^(k + 1) + (p - 1) p^(k + 2) + dots.c = 0$ 这一事实，因为裂项求和使得所有的系数都抵消了）。因此 $p$ 进整数有加法逆元，且构成一个环。

任何一个分母不被 $p$ 整除的有理数都是 $p$ 进整数。比如在 3 进整数中 $ 1/2 = (-1)/(1 - 3) = -(1 + 3 + 3^2 + dots.c) = 2 + 3 + 3^2 + dots.c $ 其中最后一个等号我们使用到了 @eq:negation-in-p-adic-integers。实际上，可以证明若 $ x = sum_(n = 0)^(infinity) a_n p_n $ 是 $p$ 进整数，且 $a_0 != 0$，那么 $1 \/ x$ 也是 $p$ 进整数。

*$p$ 进有理数*，记作 $QQ_p$，是如下形式的和 $ y = sum_(n = m)^(infinity) a_n p^n $ <eq:p-adic-rational> 其中 $m$ 为正整数、负整数或零，$a_n in {0, 1, 2, dots.c, p - 1}$。如果 $y in QQ_p$，则存在整数 $k$ 使得 $p^k y$ 为 $p$ 进整数。$p$ 进有理数构成一个域，且每个有理数都在 $QQ_p$ 中。若 @eq:p-adic-rational 中的 $a_m != 0$，则我们定义 $ v_p (y) = m quad quad abs(y)_p = p^(-m) $ 这在 $y$ 为有理数时与前面定义的 $p$ 进赋值和绝对值相一致。

还有另一种理解 $p$ 进整数的方法。考虑一列整数 $x_1, x_2, dots.c$ 满足 $ x_m equiv x_(m + 1) quad (mod p^m) $ <eq:x-m-equiv-x-m-plus-1-mod-p-m> 对所有的 $m >= 1$ 成立。由于对所有 $k >= m$，都有 $x_m equiv x_k (mod p^m)$，所以对所有 $k >= m$，数 $x_k$ 的以 $p$ 为底的展开在 $p^(m - 1)$ 项之前必须一致。因此，整数序列 $x_m$ 确定了一个如下形式的表达式 $ sum_(n = 0)^(infinity) a_n p^n $ 其中 $ x_m equiv sum_(n = 0)^(m - 1) a_n p^n quad (mod p^m) $ 对所有 $m$ 成立。换句话说，这个整数序列确定了一个 $p$ 进整数。反过来，一个 $p$ 进整数的部分和确定了一个满足 @eq:x-m-equiv-x-m-plus-1-mod-p-m 的整数序列。

让我们利用这些想法来展示 $-1$ 是 5 进整数中的平方数。令 $x_1 = 2$，那么 $ x_1^2 equiv -1 quad (mod 5) $

假设我们已定义了某个 $x_m$，使得 $ x_m^2 equiv -1 quad (mod 5) $

令 $x_(m + 1) = x_m + 5^m b$，其中 $ b equiv frac(-1 - x_m^2, 2 dot.c 5^m x_m) quad (mod 5) $

注意，$x_m^2 equiv -1 (mod 5)$ 意味着上一个同余式右边在模 5 下是有定义的。快速计算可得 $ x_(m + 1)^2 equiv -1 quad (mod 5^(m + 1)) $

由于 @eq:x-m-equiv-x-m-plus-1-mod-p-m 被满足，存在一个 5 进整数 $x$ 使得对所有 $m$ 有 $x equiv x_m (mod 5)$。此外 $ x^2 equiv -1 quad (mod 5) $ 对所有 $m$ 成立。这意味着 $x^2 = -1$。

一般而言，这个过程导出了以下非常有用的结果。

#theorem[Hensel 引理][
  设 $f(X)$ 是一个系数为 $p$ 进整数的多项式，且设 $x_1$ 是一个整数，使得 $ f(x_1) equiv 0 quad (mod p) $

  如果 $ f'(x_1) equiv.not 0 quad (mod p) $ 那么存在一个 $p$ 进整数 $x$，使得 $x equiv x_1 (mod p)$ 且 $ f(x) = 0 $
]

#corollary[
  设 $p$ 是一个奇质数，且设 $b$ 是一个在模 $p$ 意义下为非零平方数的 $p$ 进整数，那么 $b$ 是某个 $p$ 进整数的平方。

]

该推论可以用与证明 $-1$ 是 5 进整数中的平方完全相同的方法来证明。该推论也可以由定理推出：设 $f(X) = X^2 - b$，并设 $x_1^2 equiv b (mod p)$。那么 $f(x_1) equiv 0 (mod p)$，且因为 $p$ 是奇数，以及根据假设 $x_1 equiv.not 0$ 有 $ f'(x_1) = 2x_1 equiv.not 0 quad (mod p) $

Hensel 引理表明存在一个 $p$ 进整数 $x$，使得 $f(x) = 0$。这意味着 $x^2 = b$，即得证。

当 $p = 2$ 时，该推论不成立。例如，5 在模 2 下是平方数，但在模 8 下不是平方数，因此不是 2 进平方。不过，上述归纳法可推出以下命题：

#proposition[
  如果 $b$ 是一个满足 $b equiv 1 (mod 8)$ 的 2 进整数，那么 $b$ 是某个 2 进整数的平方。

]
/// END: Appendix

/// START: Appendix
= 群 <appendix:groups>

#heading(numbering: none, outlined: false, level: 2)[基本定义]

由于本书中的大多数群是加法阿贝尔群，我们将在本附录中使用加法记号表示群运算。因此，一个群 $G$ 有一个满足结合律的二元运算 $+$。存在一个加法单位元，记作 $0$，满足 $ 0 + g = g + 0 = g $ 对所有 $g in G$ 成立。每个 $g in G$ 被假定具有一个加法逆元 $-g$，满足 $ (-g) + g = g + (-g) = 0 $

若 $n$ 是正整数，我们记 $ n g = g + g + dots.c + g quad "（共 "n" 项）" $

若 $n < 0$，我们定义 $n g = -(abs(n) g) = -(g + dots.c + g)$。

本书中的几乎所有群都是阿贝尔群，这意味着对所有 $g, h in G$，有 $g + h = h + g$。

如果 $G$ 是有限群，则 $G$ 的 *阶* 是其元素的个数。*元素 $g in G$ 的阶* 是满足 $k g = 0$ 的最小正整数 $k$。如果 $k$ 是 $g$ 的阶，则有 $ i g = j g <==> i equiv j quad (mod k) $

关于阶的基本结论如下。

#theorem[拉格朗日定理][
  设 $G$ 是一个有限群。

  + 令 $H$ 是 $G$ 的子群，则 $H$ 的阶整除 $G$ 的阶。

  + 令 $g in G$，则 $g$ 的阶整除 $G$ 的阶。
] <theo:lagrange-theorem>

群 $G$ 与其子群 $H$ 的阶的比值 $\#G \/ \#H$ 被称为 $H$ 在 $G$ 中的 *指数*。更一般地说，在任意群（可能是无限群）$G$ 中，子群 $H$ 的指数是一个最小的正整数 $n$，使得我们将 $G$ 写为 $ G = union.big_{i=1}^n (g_i + H) $ 其中 $g_i in G$。

例如，$ZZ = (0 + 3ZZ) union (1 + 3ZZ) union (2 + 3ZZ)$，所以 $3ZZ$ 在 $ZZ$ 中的指数是 3。

一个 *循环群* 是与 $ZZ$ 或某个 $ZZ_n$ 同构的群。这类群的特点是可以由一个元素生成。例如，$ZZ_4$ 可以由 1 生成，也可以由 3 生成，因为 ${ 0, 3, 3 + 3, 3 + 3 + 3 }$ 就是整个 $ZZ_4$。以下结果表明：拉格朗日定理在有限循环群中的逆命题成立。

#theorem[
  令 $G$ 是一个阶为 $n$ 的有限循环群。令 $d > 0$ 整除 $n$。

  + 则 $G$ 中存在唯一的阶为 $d$ 的子群。

  + $G$ 中有 $d$ 个元素的阶整除 $d$，并且有 $phi.alt(d)$ 个元素的阶恰为 $d$，其中 $phi.alt$ 是欧拉函数。
]

例如 $ZZ_6$ 包含一个阶为 3 的子群 ${ 0, 2, 4 }$。元素 $2, 4 in ZZ_6$ 的阶为 3。

两个群 $G_1$ 和 $G_2$ 的 *直和* 定义为由两者元素组成的有序对集合 $ G_1 plus.circle G_2 = { (g_1, g_2) | g_1 in G_1, g_2 in G_2 } $

有序对之间按分量相加：$ (g_1, g_2) + (h_1, h_2) = (g_1 + h_1, g_2 + h_2) $

这使得 $G_1 plus.circle G_2$ 构成一个群，其单位元为 $(0, 0)$。多个群的直和也可类似定义。我们记 $G^r$ 为 $G$ 的 $r$ 个拷贝的直和。特别地，$ZZ^r$ 表示所有可能的整数 $r$ 元组的集合，它在加法下构成一个群。

#heading(numbering: none, outlined: false, level: 2)[结构定理]

对群 $G_1, G_2$ 如果存在一个双射函数 $psi: G_1 -> G_2$，使得对所有 $g, h in G_1$，都有 $psi(g h) = psi(g) psi(h)$，则称两者 *同构*。注意：左边的乘积 $g h$ 是在群 $G_1$ 中进行的，而右边的乘积 $psi(g) psi(h)$ 是在群 $G_2$ 中进行的。

#theorem[
  任意有限阿贝尔群同构于如下形式的群

  $
    ZZ_(n_1) plus.circle ZZ_(n_2) plus.circle dots.c plus.circle ZZ_(n_s)
  $

  其中 $n_i divides n_(i + 1)$ 对所有 $i = 1, 2, dots.c, s - 1$ 成立。这些整数 $n_i$ 由群 $G$ 唯一确定。
]

若阿贝尔群 $G$ 存在一个有限集合 ${ g_1, g_2, dots.c, g_k } subset.eq G$，使得 $G$ 中的任意元素都可以表示为 $ m_1 g_1 + m_2 g_2 + dots.c + m_k g_k $

则 $G$ 称为是 *有限生成的*，其中 $m_i in ZZ$，且该表示不要求唯一。


#theorem[
  有限生成的阿贝尔群同构于如下形式的群

  $
    ZZ^r plus.circle ZZ_(n_1) plus.circle ZZ_(n_2) plus.circle dots.c plus.circle ZZ_(n_s)
  $

  其中 $r >= 0$，且 $n_i divides n_(i + 1)$ 对所有 $i = 1, 2, dots.c, s - 1$ 成立。整数 $r$ 和各 $n_i$ 被群 $G$ 唯一确定。
]

若 $G$ 的某个子群与

$
  ZZ_(n_1) plus.circle ZZ_(n_2) plus.circle dots.c plus.circle ZZ_(n_s)
$

同构，则其称为 $G$ 的 *挠子群*，整数 $r$ 称为群 $G$ 的 *秩*。

该定理可以由如下定理证明。

#theorem[
  设群 $G_1 subset.eq G_2 subset.eq G_3$，且存在某个整数 $r$，使得 $G_1$ 与 $G_2$ #footnote[勘误：应为 $G_3$] 都同构于 $ZZ^r$，则 $G_2$ 也同构于 $ZZ^r$。

]

例如，令 $G_1 = 12 ZZ$，$G_2 = 6 ZZ$，$G_3 = ZZ$，这三个群都同构于 $ZZ$，满足定理的条件。在文中，该定理应用于 $G_1$ 和 $G_3$ 是复平面 $CC$ 中的晶格的情形。此时 $G_1$ 和 $G_3$ 都同构于 $ZZ^2$。如果 $G_1 subset.eq G_2 subset.eq G_3$，那么 $G_2 tilde.eq ZZ^2$，因此存在复数 $omega_1, omega_2$ 使得 $G_2 = ZZ omega_1 + ZZ omega_2$。由于 $G_1$ 是晶格，它包含两个在实数域上线性无关的向量。又因为 $G_1 subset.eq G_2$，这说明 $omega_1$ 和 $omega_2$ 也在实数域上线性无关，因此 $G_2$ 也是一个晶格。

#heading(numbering: none, outlined: false, level: 2)[同态]

设 $G_1, G_2$ 是群。一个从 $G_1$ 到 $G_2$ 的 *同态* 是指一个映射 $psi : G_1 -> G_2$，满足对所有 $g, h in G_1$，有 $psi(g + h) = psi(g) + psi(h)$。换句话说，该映射把 $G_1$ 中的加法对应到 $G_2$ 中的加法。

$psi$ 的 *核* 定义为 $ "Ker" psi = { g in G_1 divides psi(g) = 0 } $

$psi$ 的像记作 $psi(G_1)$，其是 $G_2$ 的一个子群。

我们所需的主要结论如下。

#theorem[
  设 $G_1$ 是有限群，且 $psi : G_1 -> G_2$ 是群同态。则有 $ \#G_1 = (\#"Ker" psi) (\#psi(G_1)) $
]

实际上，从商群的角度来看，有 $G_1 \/ "Ker" psi tilde.eq psi(G_1)$。
/// END: Appendix

/// START: Appendix
= 域 <appendix:fields>

令 $K$ 为一个域。存在环同态 $psi: ZZ -> K$ 将 $1 in ZZ$ 映射到 $1 in K$。如果 $psi$ 是单射，那么我们称 $K$ 的 *特征为 $0$*，否则存在最小的正整数 $p$，使得 $psi(p) = 0$，此时我们称 $K$ 的 *特征为 $p$*。如果 $p$ 可分解为 $a b$，其中 $1 < a <= b < p$，那么 $psi(a) psi(b) = psi(p) = 0$，得 $psi(a) = 0$ 或 $psi(b) = 0$，这与 $p$ 最小相矛盾。因此 $p$ 是质数。

当 $K$ 的特征为 $0$ 时，有理数域 $QQ$ 包含在 $K$ 中。

当 $K$ 的特征为 $p$ 时，模 $p$ 的有限域 $FF_p$ 包含在 $K$ 中。

令域 $K$ 和 $L$ 满足 $K subset.eq L$，若 $alpha in L$，且存在一个非常数多项式 $ f(X) = X^n + a_(n - 1) X^(n - 1) + dots.c + a_0 $ 使得 $f(alpha) = 0$，其中 $a_0, dots.c, a_(n - 1) in K$，则称 $alpha$ 在 $K$ 上是 *代数的* #footnote[译者注：或称 $alpha$ 是 $K$ 的 *代数元*，译者将尽可能取缔 *代数的* 这种说法]。

若 $L$ 的每一个元素都是 $K$ 的代数元，则称 $L$ 在 $K$ 上是 *代数的*，或称 $L$ 是 $K$ 的 *代数扩张* #footnote[译者注：或称 $L$ 是 $K$ 的 *代数扩域*，两种表述将混用]。

域 $K$ 的 *代数闭包* 是一个包含 $K$ 的域 $overline(K)$，且满足

+ $overline(K)$ 是 $K$ 的代数扩域。

+ 所有系数在 $overline(K)$ 中的非常数多项式 $g(X)$ 在 $overline(K)$ 中都有根（即 $overline(K)$ 是代数封闭的）。

如果 $g(X)$ 的次数为 $n$，且在 $K$ 中有根 $alpha$，那么可以写成 $g(X) = (X − alpha) g_1(X)$，其中 $g_1(X)$ 的次数为 $n - 1$。通过归纳可知，$g(X)$ 在 $overline(K)$ 中有恰好 $n$ 个根（按重数计）。

可以证明，每个域 $K$ 都有一个代数闭包，并且任意两个代数闭包都是同构的。在本书中，我们默认已选择某个特定的 $K$ 的代数闭包，并称其为 $K$ 的代数闭包。

当 $K = QQ$ 时，其代数闭包 $overline(QQ)$ 是所有在 $QQ$ 上为代数元的复数组成的集合。当 $K = CC$ 时，其代数闭包就是 $CC$ 本身，因为由代数基本定理可知 $CC$ 就是代数封闭的。

#heading(numbering: none, outlined: false, level: 2)[有限域]

令 $p$ 为质数，则模 $p$ 的整数构成有 $p$ 个元素的域 $FF_p$。可以证明，有限域中的元素个数必为某个质数的幂，并且对于每个质数 $p$ 的幂 $p^n$，存在一个唯一的（同构意义下的）有限域，其元素个数为 $p^n$。（注意：当 $n >= 2$ 时，环 $ZZ_(p^n)$ 不是域，因为 $p$ 在其中没有乘法逆元；实际上，因为 $p dot.c p^(n - 1) equiv 0 (mod p^n)$，所以 $p$ 是一个零因子。）在本书中，元素个数为 $p^n$ 的有限域记作 $FF_(p^n)$。另一种在文献中常见的记法是 $"GF"(p^n)$。可以证明 $ FF_(p^m) subset.eq FF_(p^n) <==> m divides n $

域 $FF_(p^n)$ 的代数闭包可以表示为 $ overline(FF)_p = union.big_(n >= 1) FF_(p^n) $

#theorem[
  令 $overline(FF)_p$ 为 $FF_q$ 的代数闭包，$q = p^n$，那么

  $ FF_q = { alpha in overline(FF)_p divides alpha^q = alpha } $
] <theo:finite-field-with-its-algebraic-closure>

#proof[
  域 $FF_q$ 的非零元素构成阶为 $q - 1$ 的群 $FF_q^times$，因此当 $0 != alpha in FF_q$ 时 $alpha^(q - 1) = 1$，因此对所有的 $alpha in FF_q$ 都有 $alpha^q = alpha$。

  回想一个多项式 $g(X)$ 当且仅当 $g(X)$ 与 $g'(X)$ 有公共根时，$g(X)$ 才有重根。因为 $ "d"/("d"x) (X^q - X) = q X^(q - 1) - 1 = -1 $（其中有 $q = p^n = 0$ 在 $FF_p$ 成立），因此多项式 $X^q - X$ 没有重根。故恰有 $q$ 个不同的 $alpha in overline(FF)_p$ 满足 $alpha^q = alpha$。一般来说，确定

  由于定理中的两个集合元素个数都为 $q$，且一个包含于另一个，故它们相等。
]

若 $ phi.alt_q (x) = x^q $ 对所有 $x in overline(FF)_q$ 成立，我们称 $phi.alt_q$ 为 $overline(FF)_q$ 的 $q$ 次幂 *Frobenius 自同构*。

#proposition[
  令 $q$ 为质数 $p$ 的幂。

  + $overline(FF)_q = overline(FF)_p$。

  + $phi.alt_q$ 是 $overline(FF)_q$ 的一个自同构。特别地，对所有 $x, y in overline(FF)_q$ 有 $ phi.alt_q (x + y) = phi.alt_q (x) + phi.alt_q (y) quad quad phi.alt_q (x y) = phi.alt_q (x) phi.alt_q (y) $

  + 令 $alpha in overline(FF)_q$，那么 $ alpha in FF_(q^n) quad <==> quad phi.alt_q^n (alpha) = alpha $
]

#proof[
  第 1 点是一个更一般事实的特例：若 $K subset.eq L$，且 $L$ 是 $K$ 的代数扩域，则 $overline(L) = overline(K)$。这个结论可以这样证明：如果元素 $alpha$ 是 $L$ 的代数元，而 $L$ 又是 $K$ 的代数扩域，那么根据代数扩张的传递性，$alpha$ 也是 $K$ 的代数元。因此 $overline(L)$ 是 $K$ 的代数扩域，且是代数封闭的。因此它是 $K$ 的代数闭包。

  第 3 点其实就是 @theo:finite-field-with-its-algebraic-closure 的另一种说法，把 $q$ 换成了 $q^n$。

  现在来证第 2 点。设 $1 <= j <= p - 1$，那么二项式系数 $binom(p, j)$ 在分子里含有一个 $p$ 的因子，而分母不会抵消它，所以 $ binom(p, j) equiv 0 quad (mod p) $

  于是

  $
    (x + y)^p & = x^p + binom(p, 1) x^(p - 1) y + binom(p, 2) x^(p - 2) y^2 + dots.c + y^p \
              & = x^p + y^p
  $

  因为我们在特征为 $p$ 的域中讨论。简单的归纳法可以得到 $ (x + y)^(p^n) = x^(p^n) + y^(p^n) $ 对于所有 $x, y in FF_p$ 都成立。这说明了 $phi.alt_q(x + y) = phi.alt_q(x) + phi.alt_q(y)$，而 $phi.alt_q(x y) = phi.alt_q(x) dot.c phi.alt_q(y)$ 也是显然的。因此，$phi.alt_q$ 是域的一个同态。（根据命题 C.5 之前的讨论），域同态一定是单射，现在我们只需要证明 $phi.alt_q$ 是满射。

  若 $alpha in overline(FF)_p$，则存在某个 $n$ 使得 $alpha in FF_(q^n)$，于是 $phi.alt_q^n (alpha) = alpha$。因此 $alpha$ 是 $phi_q$ 的像，故 $phi.alt_q$ 是满射。所以 $phi.alt_q$ 是一个自同构。
]

在 @appendix:number-theory 中已经指出 $FF_p^times = ZZ_p^times$ 是一个由原根生成的循环群。更一般地，可以证明 $FF_q^times$ 是一个循环群。一个有用的推论如下。

#proposition[
  令 $m$ 为满足 $p divides.not m$ 的正整数，且 $mu_m$ 为 $m$ 次单位根的群。则 $ mu_m subset.eq FF_q^times quad <==> quad m divides q - 1 $
]

#proof[
  根据 @theo:lagrange-theorem（见 @appendix:groups），如果 $mu_m subset.eq FF_q^times$，则 $m$ 必须整除 $q - 1$。

  反之，如果 $m$ 整除 $q - 1$，由 $FF_q^times$ 的阶为 $q - 1$，可得其包含一个阶为 $m$ 的子群（见 @appendix:groups）。由 @theo:lagrange-theorem，子群的元素必然满足 $x^m = 1$，因此它们必然是 $mu_m$ 中的 $m$ 个元素。
]

设 $FF_q subset.eq FF_(q^n)$ 为有限域，我们可以认为 $FF_(q^n)$ 是 $FF_q$ 上的一个 $n$ 维向量空间。这意味着存在一组基 ${ beta_1, dots.c, beta_n }$，使得 $FF_(q^n)$ 中的每个元素都可以唯一地表示为 $ a_1 beta_1 + dots.c + a_n beta_n $ 其中 $a_1, dots.c, a_n in FF_q$。接下来的一个结论说明，有可能选取一种特别好的基形式，这种形式有时被称为 *正规基*。

#proposition[
  存在 $beta in FF_(q^n)$ 使得

  $
    { beta, phi.alt_q (beta), dots.c, phi.alt_q^(n - 1) (beta) }
  $

  为 $FF_q$ 上的向量空间 $FF_(q^n)$ 的一个基。
]

使用正规基有一个优点，取 $q$ 次幂的运算在坐标表示上变成了一个循环移位操作：设

$
  x = a_1 beta + a_2 phi.alt_q (beta) + dots.c + a_n phi.alt_q^(n - 1)(beta)
$

其中 $a_i in FF_q$。由于 $a_i^q = a_i$，且 $phi.alt_q^n (beta) = beta$，于是

$
  x^q & = a_1 beta^q + a_2 phi.alt_q (beta^q) + dots.c + a_n phi.alt_q^(n - 1)(beta^q)               \
      & = a_n phi.alt_q^n (beta) + a_1 phi.alt_q (beta) + dots.c + a_(n - 1) phi.alt_q^(n - 1)(beta) \
      & = a_n beta + a_1 phi.alt_q (beta) + dots.c + a_(n - 1) phi.alt_q^(n - 1)(beta)
$

因此，如果 $x$ 在正规基下的坐标是 $(a_1, dots.c, a_n)$，那么 $x^q$ 的坐标就是 $(a_n, a_1, dots.c, a_(n - 1))$。由此可见，计算 $q$ 次幂非常快速，无需在 $FF_(q^n)$ 内部进行复杂运算，具有显著的计算优势。

#heading(numbering: none, outlined: false, level: 2)[嵌入与自同构]

设 $K$ 是一个特征为 0 的域，自然有 $QQ subset.eq K$。若某个元素 $alpha in K$ 不是任何有理系数非零多项式的根，则称它是 *超越的*，即它在 $QQ$ 上不是代数的。

设集合 $S = {alpha_i} subset.eq K$（其中 $i$ 遍历某个（可能是无限的）指标集 $I$），若存在 $S$ 中 $n >= 1$ 个不同的元素 $alpha_1, dots.c, alpha_n$，以及一个有理系数的非零多项式 $f(X_1, dots.c, X_n)$，使得 $f(alpha_1, dots.c, alpha_n) = 0$，则称这组元素是 *代数相关* 的。反之则称这组元素是 *代数无关* 的。这意味着它们之间没有任何非平凡的代数关系。

一个在 $K$ 中的极大代数无关子集被称为 $K$ 的一个 *超越基*。而 $K$ 关于 $QQ$ 的 *超越次数* 被定义为某个超越基的势，这个数值与所选超越基无关。如果 $K$ 中的每个元素都是 $QQ$ 上的代数元，那么超越次数就是 0。而复数域 $CC$ 相对于 $QQ$ 的超越次数是无限的，实际上，是不可数无限。

设 $K$ 是一个特征为 0 的域，选取一个超越基 $S$。设 $F$ 是由 $QQ$ 与 $S$ 中元素生成的子域。由于 $S$ 是极大的代数无关集，它的极大性意味着 $K$ 中的每个元素都在 $F$ 上是代数的。
因此，域 $K$ 可以从 $QQ$ 出发，加入若干个代数无关的超越元，再通过代数扩张进行构造。

设 $K$、$L$ 是两个域，且 $f : K -> L$ 是一个域同态。我们始终假设 $f$ 将 $1 in ZZ$ 映射到 $1 in K$。则 $f$ 必为单射。一种理解方式是：若 $x in K$ 且 $x != 0$，那么 $1 = f(x)f(x^(-1)) = f(x)f(x)^(-1)$。因为 $f(x)$ 有乘法逆元，所以它不可能为 0。

接下来的一个结论非常有用，它的证明依赖于 Zorn 引理（见 @ref:lang2002algebra）。

#proposition[]

/// TODO: Keep translate here...

/// END: Appendix

/// START: Appendix
= 计算机软件包 <appendix:computer-packages>

目前有若干计算机代数软件可以用于椭圆曲线上的计算。在本附录中，我们将对其中三种主流软件做一个简要介绍。我们不打算详细解释这些软件的结构，而是通过一些计算示例展示它们的功能。读者若想了解更多操作方式，可参考在线或软件自带的文档，其中包含了丰富的计算可能性。

== Pari <subappendix:pari>

PARI/GP 是一个用于数论计算的自由计算机代数系统。它可以从 #link("http://pari.math.u-bordeaux.fr")[此网站] 下载。

下面是一次使用会话的记录，并附有注释说明。

#set raw(align: center)

```txt
GP/PARI CALCULATOR Version 2.3.0 (released)
i686 running linux (ix86 kernel) 32-bit version
compiled: Aug 16 2007, gcc-3.4.4 20050721 (Red Hat 3.4.4-2)
(readline v4.3 enabled [was v5.0 in Configure], extended help available)
Copyright (C) 2000-2006 The PARI Group
```

#set raw(align: left)

```txt
PARI/GP is free software, covered by the GNU General Public License, and comes WITHOUT ANY WARRANTY WHATSOEVER.
Type ? for help, \q to quit. Type ?12 for how to get moral (and possibly technical) support.
parisize = 4000000, primelimit = 500000
```

首先我们需要输入并初始化一个椭圆曲线。令 $[a_1, a_2, a_3, a_4, a_6]$ 是曲线在广义 Weierstrass 形式下的系数。让我们从例 9.3 的曲线 $E_1: y^2 = x^3 - 58347 x + 3954150$ 开始。/// TODO: Ref to example 9.3

```
? e1=ellinit([0,0,0,-58347,3954150])
%1 = [0, 0, 0, -58347, 3954150, 0, -116694, 15816600,
-3404372409, 2800656, -3416385600, 5958184124547072,
10091699281/2737152, [195.1547871847901607239497645,
75.00000000000000000000000000, -270.1547871847901607239497645],
0.1986024692687475355260042188, 0.1567132675477145982613047883*I,
-6.855899811988574944063544705, -21.22835194662770142565252843*I,
0.03112364190214999895971387115]
```

输出结果中包含该椭圆曲线的若干参数（输入 `?ellinit` 可查看说明）。
例如，周期 $omega_1 = "i" dot.c 0.156713dots$ 和 $omega_2 = 0.198602dots$ 是其中的条目。而 $j$-不变量是第 13 个条目：

```
? e1[13]
%2 = 10091699281/2737152
```

以及曲线 $E_2: y^2 = x^3 + 73$：

```
? e2=ellinit([0,0,0,0,73])
%3 = [0, 0, 0, 0, 73, 0, 0, 292, 0, 0, -63072, -2302128, 0,
[-4.179339196381231892056376349, 2.089669598190615946028188174
+ 3.619413915098187674530455654*I, 2.089669598190615946028188174
-3.619413915098187674530455654*I], 2.057651708004923756251055780,
-1.028825854002461878125527890+0.5939928837575679811100134634*I,
-2.644469941892436553395125300, 1.322234970946218276697562650
-2.290178149223208371431388983*I, 1.222230471806529890431614914]
```

我们可以将在曲线上的点 $(2, 9)$ 和 $(3, 10)$ 添加上：

```
? elladd(e2,[2,9],[3,10])
%4 = [-4, -3]
```

我们可以求出点 $(2, 9)$ 的三次方：

```
? ellpow(e2,[2,9],3)
%5 = [5111/625, -389016/15625]
```

/// TODO: Keep translate here...

== Magma <subappendix:magma>

== SAGE <subappendix:sage>
/// END: Appendix

/// START: References
#bibliography("/references.bib", title: "参考文献")
// END: References
