# Español

Printable Spanish study aids for an A2 learner moving into B1, who lives in Guatemala.
The output is one PDF, `Español.pdf`, printed double-sided on A5.

Issues live in lific project `ESP`.

## Build

```sh
nix develop -c task pdf     # build Español.pdf
nix develop -c task watch   # rebuild on every change
```

`direnv` loads the dev shell, so inside the directory `task pdf` works on its own.

`task mediacarta` builds the same document on media carta (half Letter) and `Español-carta-2up.pdf` from it with `impose.typ`.
`docs/binding.md` defines the terms and describes the imposition.
Landscape media carta is 8 mm shorter than A5, so it needs 5 mm top and bottom margins (`MT`, `MB`).
To try others, run `task mediacarta MT=6mm MB=6mm` and check the page count.
Typst runs with `--ignore-system-fonts`.
The only fonts are the ones `flake.nix` copies into `TYPST_FONT_PATHS`.

## Layout

| File | Role |
| --- | --- |
| `verbs.typ` | Entry point: title page, includes, verb pages |
| `rules.typ` | Portrait pages "Cómo leer" and "Reglas útiles" |
| `serestar.typ` | Portrait page "Ser o estar" |
| `regulares.typ` | Landscape pages "Verbos regulares": endings, subjuntivo, imperativo, spelling rules |
| `theme.typ` | Colours, fonts, the `form()` helper |
| `data/<verb>.yaml` | One file per verb; the `irregulares` and `regulares` lists in `verbs.typ` set the order |

Page order: title, blank, the rules pages, ser o estar, blank, the irregular verbs, the two "Verbos regulares" pages from `regulares.typ`, then the regular verbs.
Every verb has two landscape pages.
The blanks keep every verb on its own sheet in double-sided printing.
After any change, `pdfinfo Español.pdf` must report `8 + 2 × verbs` pages.
More pages means a verb page overflowed.
Fix the layout, and never accept the extra page.

## Verb Data

- `tipo` names the verb type for the footer: `irregular`, `regular`, `con cambio de raíz` or `con cambio ortográfico`.
- Every `forms` list has six persons in this order:
  - yo
  - tú
  - él, ella, usted
  - nosotros
  - vosotros
  - ellos, ellas, ustedes
- `null` means the form does not exist, as with yo in the imperativo.
- Square brackets mark the irregular part of a form, compared with the regular pattern: `t[ie]nes`, `[tuv]e`, `he [hech]o`.
  Mark nothing in a regular form.
  Mark only the letters that differ, the same way in every tense: `ten[g]o` and `ten[g]a`, not `[teng]a`.
- `imperativo-negativo` holds the negative commands.
  The page prints them under the affirmative ones.
- `vos` holds the Guatemalan voseo forms, only where they differ from tú.
- `examples` and `translations` share keys with `forms`, plus `gerundio` and `participio`.
  A `null` example prints a dash, for a verb with no natural command (`haber`, `poder`).
  Mark the verb form in an example with `*bold*`.
- `uso` has exactly six entries `[label, example, English]`.
  Each label fits on one line.
- `expresiones` has nine entries `[phrase, English]`.
- Length limits keep each page on one sheet.
  An `uso` example plus its English stays within 44 characters.
  An example stays within 40 characters, counting the `*` marks.
  A translation stays within 43 characters.

## Language

- Guatemala first, Spain compatible.
  Use Latin American words (`carro`, `computadora`, `hacer las compras`), and keep the vosotros forms in grey.
- Pretérito perfecto examples talk about experience, or use `ya`, `nunca` or `alguna vez`.
  Guatemala uses the pretérito for "today", so a `Hoy he …` example is Spain usage and stays off the verb pages.
- English appears only as a gloss or a translation:
  - the gloss of the infinitive
  - the line under each example
  - the glosses in `uso` and `expresiones`
  - the explanations on the rules pages
- Write tense names in full: `Subjuntivo imperfecto`.

## Checks Before Calling a Change Done

- Check every new or changed form against a reference conjugator (RAE tables, WordReference or SpanishDict).
  Name the source in the commit or the issue.
  A second agent that checks from its own knowledge adds an extra pass on top of the reference.
- `pdffonts Español.pdf` lists only Fraunces and Atkinson Hyperlegible Next.
  A third font, usually `LibertinusSerif`, means a glyph is missing.
  Replace the glyph, such as `→`, and keep the font list as it is.
- Render the changed pages to PNG and look at them.
  The page count alone misses wrapped labels, uneven boxes and overflow.

## Design

- Fonts: `Fraunces 72pt` for verb names and page titles, `Atkinson Hyperlegible Next` for everything else, subheadings included.
- Colours come from `theme.typ`.
  Red marks irregular parts, and grey marks Spain-only forms.
  Each time family has its own tint: now, past, later and mood.
- Keep the pages friendly and plain.
  Leave out uppercase eyebrows, page numbers and boxes at the page bottom.
