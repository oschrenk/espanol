#import "theme.typ": *

#let section(title, body) = block(width: 100%, above: 11pt, below: 8pt)[
  #text(size: 10pt, weight: "bold")[#title]
  #v(-3pt)
  #body
]

#let band(fam, name, tenses) = box(
  fill: tint.at(fam), inset: (x: 6pt, y: 4pt), radius: 3pt, width: 100%,
)[#text(weight: "bold")[#name] #h(4pt) #text(fill: soft)[#tenses]]

#let tip(body) = text(fill: soft, body)

#let heading-row(title, sub) = [
  #text(font: f-head, size: 24pt, weight: "bold")[#title] #h(8pt)
  #text(size: 10pt, fill: soft, style: "italic")[#sub]
  #v(2pt)
]

// ── page 1 ─────────────────────────────────────────────────────────────────

#heading-row[Cómo leer][How to read the verb pages]

#grid(
  columns: (1fr, 1fr),
  column-gutter: 18pt,
  [
    #section[Colours in the forms][
      #grid(
        columns: (auto, 1fr),
        column-gutter: 10pt,
        row-gutter: 7pt,
        form("ten[g]o"), [*Red* is the irregular part. Learn only the red; the black is the regular ending.],
        text(fill: faint, form("[tuv]isteis", muted: true)), [*Grey* is used only in Spain (_vosotros_). In Guatemala, say _ustedes_.],
        text(size: 8pt, fill: soft)[vos tenés], [*vos* is the Guatemalan _tú_, shown under the _tú_ form where it differs.],
        text(size: 8pt, fill: soft)[no tengas], [*no …* under the imperativo is the negative command. It uses the subjuntivo.],
      )
    ]
    #section[Compound tenses][
      Every compound tense is *haber + participio*, like German _haben + gehabt_. \
      he · había · habré · habría · haya · hubiera #h(2pt) + #h(2pt) tenido, comido, hablado …
    ]
  ],
  [
    #section[Colour bands: time families][
      #stack(
        spacing: 4pt,
        band("now", "Now", "Presente · Pretérito perfecto"),
        band("past", "Past", "Pretérito · Imperfecto · Pluscuamperfecto"),
        band("later", "Later", "Futuro · Condicional"),
        band("mood", "Mood, not time", "Imperativo · Subjuntivo · Subjuntivo imperfecto"),
      )
    ]
    #section[Two sides per verb][
      *Indicativo* on the front: the everyday forms, the gerundio, and common expressions. \
      *Subjuntivo y compuestos* on the back: the subjuntivo, the compound tenses, and the participio.
    ]
  ],
)

#pagebreak()

// ── page 2 ─────────────────────────────────────────────────────────────────

#heading-row[Reglas útiles][The rules behind the forms]

#set text(size: 8.5pt)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 18pt,
  [
    #section[Pretérito or imperfecto?][
      *Pretérito* (tuve): it happened, it is finished. _Ayer tuve un examen._ \
      *Imperfecto* (tenía): how it was, or what used to happen. _De niño tenía un perro._ \
      Together: _Estaba en casa cuando sonó el teléfono._ \
      #tip[Test: "used to" or "was …-ing" means imperfecto. "did it, done" means pretérito.]
    ]
    #section[Perfecto or imperfecto?][
      *Perfecto* (he tenido): past that still touches now. _Hoy he tenido mucho trabajo._ \
      *Imperfecto* (tenía): past cut off from now. _Antes tenía más tiempo._ \
      #tip[Test: "have done" means perfecto. In Guatemala the pretérito often replaces it: _Hoy tuve mucho trabajo._]
    ]
    #section[Ser or estar?][
      *Ser*: what something is. Identity, origin, job, time, character. _Soy de Alemania._ \
      *Estar*: how or where something is. Mood, state, location. _Estoy cansado._ \
      #tip[_es aburrido_ (boring) · _está aburrido_ (bored) · _es listo_ (clever) · _está listo_ (ready)]
    ]
  ],
  [
    #section[The boot: stem changes in the presente][
      Stem changes skip *nosotros* and *vosotros*. Draw a boot around the other four forms. \
      _t#text(fill: irregular, weight: "bold")[ie]nes · t#text(fill: irregular, weight: "bold")[ie]ne · t#text(fill: irregular, weight: "bold")[ie]nen_, but _tenemos · tenéis_. Same for _p#text(fill: irregular, weight: "bold")[ue]do_ / _podemos_.
    ]
    #section[Strong pretéritos][
      A new stem and one set of endings, with no accent: *-e · -iste · -o · -imos · -isteis · -ieron* \
      #tip[tuve, estuve, hice, pude, quise, vine. _Ser_ and _ir_ share one pretérito: fui, fuiste, fue …]
    ]
    #section[When the subjuntivo?][
      After *que* when the first part expresses: wish _quiero que tengas_ · feeling _me alegra que estés_ · doubt _no creo que sea_ · judgement _es importante que vayas_ \
      Always after: _ojalá · para que · antes de que_ · _cuando_ about the future (_cuando llegues_). \
      #tip[Negative commands use it too: _¡No tengas miedo!_]
    ]
  ],
)
