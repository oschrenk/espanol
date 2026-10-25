// Prints loose leaves for a spiral book: each Letter sheet, in landscape,
// holds two leaves side by side and is cut down the middle.
//
// The middle of the sheet is the spiral edge of both leaves, so the outer edge
// of every page is the outer edge of the sheet, and each sheet side reads like
// an open book: a verso on the left, a recto on the right.
//
// Leaves are media carta in portrait. The landscape page designs are turned so
// the bottom of the text faces the outer edge: left on the left half, right on
// the right half.
//
// Print on Letter, double-sided, flip on short edge, at 100 %.
// Cut every sheet down the middle. The left half of sheet 1 is waste.
//
// Inputs: src (the media carta PDF), pages (its page count).

#let src = sys.inputs.at("src", default: "Español-mediacarta.pdf")
#let pages = int(sys.inputs.at("pages"))

// Leaf 0 is the waste half; leaf j holds recto 2j - 1 and verso 2j.
#let leaves = calc.ceil(pages / 2) + 1
#let sheets = calc.ceil(leaves / 2)

#set page(paper: "us-letter", flipped: true, margin: 0pt)

#let left-half(n) = box(width: 5.5in, height: 8.5in, if n >= 1 and n <= pages {
  rotate(90deg, reflow: true, image(src, page: n, width: 8.5in))
})
#let right-half(n) = box(width: 5.5in, height: 8.5in, if n >= 1 and n <= pages {
  rotate(-90deg, reflow: true, image(src, page: n, width: 8.5in))
})

// Sheet s holds leaf a = 2s - 2 on the left and b = 2s - 1 on the right.
// Front: verso of a beside recto of b. Back, after turning over: verso of b beside recto of a.
#for s in range(1, sheets + 1) {
  let a = 2 * s - 2
  let b = 2 * s - 1
  grid(columns: 2, left-half(2 * a), right-half(2 * b - 1))
  pagebreak()
  grid(columns: 2, left-half(2 * b), right-half(2 * a - 1))
  if s < sheets { pagebreak() }
}
