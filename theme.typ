#let theme-flavors = (
  tailwind: (
    name: "Tailwind",
    identifier: "tailwind",
    order: 1,
    dark: false,
    light: true,
    colors: (
      base: oklch(100%, 0, 90deg),
      text: oklch(37.3%, 0.034, 259.733deg),
      white: oklch(100%, 0, 90deg),
      black: oklch(37.3%, 0.034, 259.733deg),
      red: oklch(70.4%, 0.191, 22.216deg),
      orange: oklch(75%, 0.183, 55.934deg),
      // amber: oklch(82.8%, 0.189, 84.429deg),
      yellow: oklch(85.2%, 0.199, 91.936deg),
      lime: oklch(84.1%, 0.238, 128.85deg),
      green: oklch(79.2%, 0.209, 151.711deg),
      emerald: oklch(76.5%, 0.177, 163.223deg),
      // teal: oklch(77.7%, 0.152, 181.912deg),
      // cyan: oklch(78.9%, 0.154, 211.53deg),
      sky: oklch(74.6%, 0.16, 232.661deg),
      blue: oklch(70.7%, 0.165, 254.624deg),
      // indigo: oklch(67.3%, 0.182, 276.935deg),
      // violet: oklch(70.2%, 0.183, 293.541deg),
      purple: oklch(71.4%, 0.203, 305.504deg),
      fuchsia: oklch(74%, 0.238, 322.16deg),
      // pink: oklch(71.8%, 0.202, 349.761deg),
      // rose: oklch(71.2%, 0.194, 13.428deg),
    ),
  ),
  one-dark-pro: (
    name: "One Dark Pro",
    identifier: "one-dark-pro",
    order: 2,
    dark: true,
    light: false,
    colors: (
      base: rgb("#282c34"),
      text: rgb("#abb2bf"),
      white: rgb("#abb2bf"),
      black: rgb("#282c34"),
      red: rgb("#e06c75"),
      orange: rgb("#d19a66"),
      yellow: rgb("#e5c07b"),
      green: rgb("#73c991"),
      lime: rgb("#98c379"),
      emerald: rgb("#109868"),
      sky: rgb("#61afef"),
      blue: rgb("#56b6c2"),
      purple: rgb("#c678dd"),
      fuchsia: rgb("#de73ff"),
    ),
  ),
)

#let theme-init(default-flavor: theme-flavors.tailwind) = {
  let theme-key = sys.inputs.keys().find(it => it == "theme")

  if theme-key != none {
    let theme = sys.inputs.at(theme-key)
    let result = theme-flavors.values().find(it => it.identifier == theme)
    if result == none { default-flavor } else { result }
  } else { default-flavor }
}

#let theme-setup(flavor, body) = {
  set page(fill: flavor.colors.base)
  set text(fill: flavor.colors.text)
  body
}
