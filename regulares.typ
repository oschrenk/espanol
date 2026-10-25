#import "theme.typ": *

// Endings for yo, tú, él / nosotros, vosotros, ellos; vosotros in grey.
#let endings(e) = {
  let cell(i) = if i == 4 { text(fill: faint, e.at(i)) } else { e.at(i) }
  [#cell(0) · #cell(1) · #cell(2) \ #cell(3) · #cell(4) · #cell(5)]
}

#let tense(fam, name) = block(fill: tint.at(fam), inset: (x: 5pt, y: 4pt), radius: 3pt, width: 100%)[
  #text(weight: "bold", size: 8.5pt)[#name]
]

// Endings in blue: red stays reserved for irregular parts.
#let model(stem, ending) = [#stem#text(weight: "bold", fill: rgb("#2F6690"))[#ending]]

#let page-title(title, sub) = [
  #text(font: f-head, size: 26pt, weight: "bold")[#title] #h(8pt)
  #text(size: 10pt, fill: soft, style: "italic")[#sub]
  #v(2pt)
]

// ── front: endings ─────────────────────────────────────────────────────────

#let terminaciones = {
  page-title[Verbos regulares][drop -ar, -er or -ir, then add the ending]
  set text(size: 10.5pt)
  table(
    columns: (88pt, 1fr, 1fr, 1fr),
    stroke: (x, y) => (bottom: if y > 0 { 0.5pt + rule }),
    inset: (x: 4pt, y: 8pt),
    align: (x, y) => left + horizon,
    [],
    [#text(font: f-head, size: 13pt, weight: "bold")[-ar] #h(4pt) #text(fill: soft, style: "italic")[hablar]],
    [#text(font: f-head, size: 13pt, weight: "bold")[-er] #h(4pt) #text(fill: soft, style: "italic")[comer]],
    [#text(font: f-head, size: 13pt, weight: "bold")[-ir] #h(4pt) #text(fill: soft, style: "italic")[vivir]],

    tense("now", "Presente"),
    endings(("o", "as", "a", "amos", "áis", "an")),
    endings(("o", "es", "e", "emos", "éis", "en")),
    endings(("o", "es", "e", "imos", "ís", "en")),

    tense("past", "Pretérito"),
    endings(("é", "aste", "ó", "amos", "asteis", "aron")),
    table.cell(colspan: 2)[#endings(("í", "iste", "ió", "imos", "isteis", "ieron")) #h(1fr) #text(fill: soft, size: 8pt)[-er and -ir share these]],

    tense("past", "Imperfecto"),
    endings(("aba", "abas", "aba", "ábamos", "abais", "aban")),
    table.cell(colspan: 2)[#endings(("ía", "ías", "ía", "íamos", "íais", "ían")) #h(1fr) #text(fill: soft, size: 8pt)[-er and -ir share these]],

    tense("later", "Futuro"),
    table.cell(colspan: 3)[
      #text(weight: "bold")[whole infinitive] + #endings(("é", "ás", "á", "emos", "éis", "án")) #h(1fr)
      #model("hablar", "é") · #model("comer", "é") · #model("vivir", "é")
    ],

    tense("later", "Condicional"),
    table.cell(colspan: 3)[
      #text(weight: "bold")[whole infinitive] + #endings(("ía", "ías", "ía", "íamos", "íais", "ían")) #h(1fr)
      #model("hablar", "ía") · #model("comer", "ía") · #model("vivir", "ía")
    ],

    tense("now", "Perfecto"),
    table.cell(colspan: 3)[he · has · ha · hemos · habéis · han + participio #h(1fr) #model("he habl", "ado") · #model("he com", "ido") · #model("he viv", "ido")],

    [#text(weight: "bold", size: 8.5pt)[Gerundio]],
    model("habl", "ando"),
    table.cell(colspan: 2)[#model("com", "iendo") · #model("viv", "iendo")],

    [#text(weight: "bold", size: 8.5pt)[Participio]],
    model("habl", "ado"),
    table.cell(colspan: 2)[#model("com", "ido") · #model("viv", "ido")],
  )
  v(1fr)
  text(size: 8pt, fill: soft)[Endings per person: yo · tú · él, ella, usted on the first line, nosotros · #text(fill: faint)[vosotros] · ellos, ustedes on the second.]
}

// ── back: subjuntivo, imperativo, spelling ────────────────────────────────

#let rule-row(change, where, a, b) = (
  [#text(weight: "bold")[#change] \ #text(fill: soft, size: 8pt)[#where]],
  a,
  b,
)

#let reglas = {
  page-title[Verbos regulares][subjuntivo, imperativo and spelling]
  set text(size: 9.5pt)
  grid(
    columns: (1fr, 1.1fr),
    column-gutter: 16pt,
    [
      #tense("mood", "Subjuntivo: swap the vowel")
      #v(2pt)
      -ar takes *e*: #model("habl", "e") · #model("habl", "es") · #model("habl", "emos") \
      -er and -ir take *a*: #model("com", "a") · #model("viv", "as") · #model("com", "amos") \
      #text(fill: soft, size: 8pt)[Start from the yo form of the presente: _hago_ gives _haga_, _tengo_ gives _tenga_.]
      #v(8pt)
      #tense("mood", "Subjuntivo imperfecto")
      #v(2pt)
      ellos pretérito minus *-ron*, plus *-ra*: \
      hablaron: #model("habla", "ra") · comieron: #model("comie", "ra") · vivieron: #model("vivie", "ra") \
      #text(fill: soft, size: 8pt)[Works for irregular verbs too: tuvieron gives tuviera, fueron gives fuera.]
      #v(8pt)
      #tense("mood", "Imperativo")
      #v(2pt)
      #stack(
        spacing: 7pt,
        [*tú:* the él form of the presente: #model("habl", "a") · #model("com", "e") · #model("viv", "e")],
        [*vos:* infinitive without r, stressed: #model("habl", "á") · #model("com", "é") · #model("viv", "í")],
        [*usted, ustedes, nosotros:* the subjuntivo: #model("habl", "e") · #model("com", "an") · #model("viv", "amos")],
        text(fill: faint)[*vosotros:* r becomes d: hablad · comed · vivid],
        [*negative:* no + subjuntivo: no #model("habl", "es") · no #model("com", "as")],
      )
    ],
    [
      #tense("now", "Spelling changes keep the sound")
      #v(2pt)
      #table(
        columns: (auto, 1fr, 1fr),
        stroke: (x, y) => (bottom: 0.5pt + rule),
        inset: (x: 3pt, y: 5pt),
        align: left + horizon,
        ..rule-row("-car: c becomes qu", "before e", [buscar: bus#text(fill: irregular, weight: "bold")[qu]é], [tocar: to#text(fill: irregular, weight: "bold")[qu]e]),
        ..rule-row("-gar: g becomes gu", "before e", [llegar: lle#text(fill: irregular, weight: "bold")[gu]é], [pagar: pa#text(fill: irregular, weight: "bold")[gu]e]),
        ..rule-row("-zar: z becomes c", "before e", [cruzar: cru#text(fill: irregular, weight: "bold")[c]é], [empezar: empe#text(fill: irregular, weight: "bold")[c]é]),
        ..rule-row("-eer: i becomes y", "between vowels", [creer: cre#text(fill: irregular, weight: "bold")[y]ó], [leer: le#text(fill: irregular, weight: "bold")[y]endo]),
        ..rule-row("-ger: g becomes j", "before a, o", [escoger: esco#text(fill: irregular, weight: "bold")[j]o], [recoger: reco#text(fill: irregular, weight: "bold")[j]a]),
      )
      #v(4pt)
      #text(size: 8pt)[
        The sound never changes, only the letter. \
        -car, -gar and -zar change in the pretérito yo form and the whole subjuntivo. \
        -eer changes in the pretérito él and ellos forms, the subjuntivo imperfecto and the gerundio.
      ]
    ],
  )
}
