#import "theme.typ": *

#let ex(es, en) = [#text(style: "italic")[#es] #h(2pt) #text(size: 6.5pt, fill: soft)[#en]]

#let use(letter, name, a, b) = block(width: 100%, below: 5pt)[
  #text(weight: "bold", fill: irregular)[#letter]#text(weight: "bold")[#name.slice(1)] \
  #ex(..a) \
  #ex(..b)
]

#let column(fam, verb, gloss, mnemonic, uses) = block(width: 100%)[
  #block(fill: tint.at(fam), inset: (x: 6pt, y: 4pt), radius: 3pt, width: 100%)[
    #text(font: f-head, size: 15pt, weight: "bold")[#verb] #h(4pt)
    #text(size: 7.5pt, fill: soft)[#gloss · remember *#mnemonic*]
  ]
  #v(3pt)
  #uses
]

#text(font: f-head, size: 24pt, weight: "bold")[Ser o estar] #h(8pt)
#text(size: 10pt, fill: soft, style: "italic")[Both mean "to be". Ask: _what_ is it, or _how / where_ is it?]
#v(2pt)

#set text(size: 8pt)
#grid(
  columns: (1fr, 1fr, 1.05fr),
  column-gutter: 12pt,
  column("mood", "ser", "what or who it is", "DOCTOR")[
    #use("D", "Description", ("La casa es grande.", "The house is big."), ("Es alto.", "He is tall."))
    #use("O", "Occupation", ("Soy ingeniero.", "I'm an engineer."), ("Ella es doctora.", "She is a doctor."))
    #use("C", "Characteristic", ("Eres muy amable.", "You're very kind."), ("Es inteligente.", "She's clever."))
    #use("T", "Time & date", ("Son las tres.", "It's three o'clock."), ("Hoy es lunes.", "Today is Monday."))
    #use("O", "Origin & material", ("Soy de Alemania.", "I'm from Germany."), ("La mesa es de madera.", "It's wooden."))
    #use("R", "Relationship", ("Es mi hermana.", "She's my sister."), ("Somos amigos.", "We're friends."))
  ],
  column("now", "estar", "how or where it is", "PLACE")[
    #use("P", "Position", ("Está sentado.", "He is sitting."), ("Estoy de pie.", "I'm standing."))
    #use("L", "Location", ("Estoy en casa.", "I'm at home."), ("Antigua está cerca.", "Antigua is close."))
    #use("A", "Action in progress", ("Estoy comiendo.", "I'm eating."), ("Están trabajando.", "They're working."))
    #use("C", "Condition", ("La puerta está abierta.", "The door is open."), ("El café está frío.", "The coffee is cold."))
    #use("E", "Emotion", ("Estoy contento.", "I'm happy."), ("Está nervioso.", "He's nervous."))
  ],
  [
    #text(size: 9pt, weight: "bold")[Same word, other meaning]
    #table(
      columns: (auto, 1fr, 1fr),
      stroke: (x, y) => (bottom: 0.5pt + rule),
      inset: (x: 3pt, y: 3pt),
      table.header([], text(fill: soft)[ser], text(fill: soft)[estar]),
      ..(
        ("aburrido", "boring", "bored"),
        ("listo", "clever", "ready"),
        ("malo", "bad", "sick"),
        ("rico", "rich", "tasty"),
        ("verde", "green", "unripe"),
        ("seguro", "safe", "sure"),
        ("vivo", "lively", "alive"),
        ("orgulloso", "arrogant", "proud"),
      ).map(((adj, s, e)) => (text(weight: "bold", adj), s, e)).flatten(),
    )
    #v(4pt)
    #text(size: 9pt, weight: "bold")[Watch out]
    #v(-2pt)
    Events take *ser* for their place: _La fiesta es en mi casa._ \
    Death takes *estar*: _Está muerto._ \
    Feelings take both: _Soy feliz_ (a happy person) · _Estoy feliz_ (right now).
  ],
)
