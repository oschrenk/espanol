// ── Español — shared design tokens and helpers ─────────────────────────────

#let f-head = "Fraunces 72pt"
#let f-body = "Atkinson Hyperlegible Next"

#let ink = rgb("#23262B")
#let soft = rgb("#5C6370")
#let faint = rgb("#A3A9B1")
#let irregular = rgb("#C8462B")
#let rule = rgb("#E3E6EA")

// One tint per time family, so the tenses group at a glance.
#let tint = (
  now: rgb("#E6F0FA"),
  past: rgb("#FBEEDB"),
  later: rgb("#E4F3E7"),
  mood: rgb("#EFE7F7"),
)

// "t[ie]nes": the bracketed part is the irregular one.
#let form(s, muted: false) = {
  for m in s.matches(regex("\[([^\]]*)\]|[^\[]+")) {
    if m.captures.at(0) != none {
      text(fill: if muted { faint } else { irregular }, weight: "bold", m.captures.at(0))
    } else { m.text }
  }
}
