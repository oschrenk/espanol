#import "theme.typ": *

#import "regulares.typ": terminaciones, reglas

// Irregular includes stem changes, as the RAE counts them; regular includes spelling changes. Each by frequency.
#let load(names) = names.map(name => yaml("data/" + name + ".yaml"))
#let irregulares = load((
  "ser", "haber", "estar", "tener", "hacer", "poder", "decir", "ir", "ver", "dar",
  "saber", "querer", "poner", "parecer", "seguir", "encontrar", "venir", "pensar", "salir", "volver",
))
#let regulares = load((
  "llegar", "pasar", "deber", "quedar", "creer", "hablar", "llevar", "dejar", "buscar", "llamar",
  "tomar", "vivir", "tocar", "leer", "recibir", "comer", "pagar",
))

// Front: everyday indicativo. Back: subjuntivo and compound tenses.
#let front = (
  (key: "presente", name: "Presente", cue: "ahora · siempre", fam: "now"),
  (key: "indefinido", name: "Pretérito", cue: "ayer · el año pasado", fam: "past"),
  (key: "imperfecto", name: "Imperfecto", cue: "antes · cuando era niño", fam: "past"),
  (key: "futuro", name: "Futuro", cue: "mañana · = voy a + inf.", fam: "later"),
  (key: "condicional", name: "Condicional", cue: "me gustaría · ¿podrías?", fam: "later"),
  (key: "imperativo", name: "Imperativo", cue: "¡hazlo! · no lo hagas", fam: "mood"),
)
#let back = (
  (key: "subjuntivo", name: "Subjuntivo", cue: "quiero que · ojalá", fam: "mood"),
  (key: "subjuntivo-imperfecto", name: "Subjuntivo imperfecto", cue: "si … · quería que", fam: "mood"),
  (key: "perfecto", name: "Pretérito perfecto", cue: "ya · nunca · ¿alguna vez?", fam: "now"),
  (key: "pluscuamperfecto", name: "Pluscuamperfecto", cue: "ya había… antes de otro pasado", fam: "past"),
)

#let persons = ("yo", "tú", "él · ella · usted", "nosotros", "vosotros", "ellos · ustedes")
#let spain-only = 4

#set document(title: "Español")
#set text(font: f-body, size: 9pt, fill: ink, lang: "es")
// `--input paper=us-statement` builds media carta; mx, mt, mb set the margins.
#let paper = sys.inputs.at("paper", default: "a5")
#let margin-input(key, default) = eval(sys.inputs.at(key, default: default))
#set page(
  paper: paper,
  flipped: true,
  margin: (x: margin-input("mx", "8mm"), top: margin-input("mt", "8mm"), bottom: margin-input("mb", "8mm")),
  footer-descent: 25%,
  footer: context {
    set text(size: 6.5pt, fill: soft)
    let p = here().page()
    let label = query(<side>).filter(m => m.location().page() == p).map(m => m.value).at(0, default: "")
    align(right, label)
  },
)

// Title page with a blank back, so the rules share one sheet and every verb starts on a new one.
#let flag = box(width: 42pt, height: 28pt, radius: 2pt, clip: true, stack(
  rect(width: 100%, height: 25%, fill: rgb("#AA151B")),
  rect(width: 100%, height: 50%, fill: rgb("#F1BF00")),
  rect(width: 100%, height: 25%, fill: rgb("#AA151B")),
))
#v(1fr)
#grid(
  columns: (auto, auto),
  column-gutter: 14pt,
  align: horizon,
  flag,
  text(font: f-head, size: 44pt, weight: "bold")[Español],
)
#v(2fr)
#pagebreak(to: "odd")

#include "rules.typ"
#pagebreak()
#include "serestar.typ"
#pagebreak(to: "odd")

#let tense-head(t) = block(
  fill: tint.at(t.fam), inset: (x: 5pt, y: 4pt), radius: 3pt, width: 100%, height: 30pt,
)[
  #text(weight: "bold", size: 8.5pt)[#t.name] \
  #text(size: 6.5pt, fill: soft)[#t.cue]
]

#let title(verb) = [
  #text(font: f-head, size: 26pt, weight: "bold")[#verb.inf] \
  #box(width: 110pt, text(size: 10pt, fill: soft, style: "italic")[#verb.gloss])
]

#let cuando(verb) = grid(
  columns: (1fr, 1fr),
  column-gutter: 14pt,
  row-gutter: 5pt,
  ..verb.uso.map(((label, es, en)) => [
    #box(width: 58pt, text(size: 6.5pt, fill: soft, tracking: 0.04em)[#upper(label)])
    #text(size: 8pt, style: "italic")[#es] #h(2pt) #text(size: 6.5pt, fill: soft)[#en]
  ]),
)

#let header(verb, uso: false) = if uso {
  grid(columns: (auto, 1fr), column-gutter: 14pt, align: (left + bottom, left + bottom), title(verb), cuando(verb))
} else { title(verb) }

#let cell(verb, t, i) = {
  let f = verb.forms.at(t.key).at(i)
  let m = i == spain-only
  if f == none { return text(fill: faint)[—] }
  let main = text(fill: if m { faint } else { ink }, form(f, muted: m))
  let extras = ()
  let vos = verb.at("vos", default: (:)).at(t.key, default: none)
  if i == 1 and vos != none { extras.push(text(size: 7.5pt, fill: soft)[vos #form(vos)]) }
  let neg = verb.forms.at(t.key + "-negativo", default: none)
  if neg != none { extras.push(text(size: 7.5pt, fill: if m { faint } else { soft }, form(neg.at(i), muted: m))) }
  if extras.len() == 0 { main } else { stack(spacing: 3pt, main, ..extras) }
}

#let example(verb, key) = if verb.examples.at(key, default: none) == none { text(fill: faint)[—] } else {
  stack(
    spacing: 3pt,
    text(size: 7.5pt, style: "italic", eval(verb.examples.at(key), mode: "markup")),
    text(size: 6.5pt, fill: soft, verb.translations.at(key)),
  )
}

#let conjugation(verb, tenses, widths) = {
  set text(size: 10pt)
  table(
    columns: (auto,) + widths,
    stroke: (x, y) => (bottom: if y > 0 and y < 7 { 0.5pt + rule }),
    inset: (x, y) => if y == 0 { (x: 1.5pt, y: 2pt) } else if y == 7 { (x: 4pt, top: 7pt, bottom: 2pt) } else { (x: 4pt, y: 5pt) },
    align: (x, y) => if y == 0 or y == 7 { left + top } else { left + horizon },
    table.header([], ..tenses.map(tense-head)),
    ..range(6)
      .map(i => (
        text(size: 7.5pt, fill: if i == spain-only { faint } else { soft })[#persons.at(i)],
        ..tenses.map(t => cell(verb, t, i)),
      ))
      .flatten(),
    text(size: 7.5pt, fill: soft)[ejemplo],
    ..tenses.map(t => example(verb, t.key)),
  )
}

#let panel(name, f, rule, ex, body: none) = block(width: 100%, inset: (x: 7pt, y: 6pt), radius: 3pt, fill: tint.now)[
  #set text(size: 8pt)
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [#text(weight: "bold")[#name] #h(4pt) #text(size: 10pt, form(f)) #h(8pt) #text(fill: soft)[#rule]],
    ex,
  )
  #if body != none { v(2pt); body }
]

#let expresiones(verb) = block(width: 100%, inset: (x: 7pt, y: 6pt), radius: 3pt, stroke: 0.6pt + rule)[
  #set text(size: 8pt)
  #text(weight: "bold")[Expresiones]
  #v(2pt)
  #grid(
    columns: (1fr,) * 3,
    row-gutter: 5pt,
    column-gutter: 8pt,
    ..verb.expresiones.map(((es, en)) => [#es #h(3pt) #text(size: 6.5pt, fill: soft)[#en]]),
  )
]

#let gerundio(verb) = panel(
  "Gerundio", verb.gerundio,
  [\= estar + gerundio: an action in progress, like English "-ing"],
  example(verb, "gerundio"),
)

#let compounds(verb) = {
  let rows = (
    ("he", "pretérito perfecto"),
    ("había", "pluscuamperfecto"),
    ("habré", "futuro perfecto"),
    ("habría", "condicional perfecto"),
    ("haya", "subjuntivo perfecto"),
    ("hubiera", "subjuntivo pluscuamperfecto"),
  )
  grid(
    columns: (1fr,) * 3,
    row-gutter: 4pt,
    ..rows.map(((aux, name)) => [#aux #form(verb.participio) #text(size: 6.5pt, fill: soft)[(#name)]]),
  )
}

// Every compound tense is a form of haber plus the participio.
#let participio(verb) = panel(
  "Participio", verb.participio,
  [\= haber + participio: all compound tenses],
  example(verb, "participio"),
  body: compounds(verb),
)

#let side(verb, label, tenses, widths, extra: none, uso: false) = {
  [#metadata("Verbo " + verb.tipo + " · " + label) <side>]
  header(verb, uso: uso)
  v(4pt)
  conjugation(verb, tenses, widths)
  v(1fr)
  extra
}

#let verb-pages(verb) = {
  side(verb, "Indicativo", front, (1fr,) * front.len(), extra: stack(spacing: 5pt, expresiones(verb), gerundio(verb)), uso: true)
  pagebreak()
  side(verb, "Subjuntivo y compuestos", back, (1fr, 1.25fr, 1.15fr, 1.1fr), extra: participio(verb))
}

#let rule-pages = {
  [#metadata("Verbos regulares · Terminaciones") <side>]
  terminaciones
  pagebreak()
  [#metadata("Verbos regulares · Subjuntivo, imperativo y ortografía") <side>]
  reglas
}

#(irregulares.map(verb-pages) + (rule-pages,) + regulares.map(verb-pages)).join(pagebreak())

// Read by `task mediacarta`, which needs the page count to impose the pages.
#context [#metadata(counter(page).final().first()) <pagecount>]
