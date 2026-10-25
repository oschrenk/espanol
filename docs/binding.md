# Binding

These terms describe how the PDF becomes a printed book.
Use them in issues, commits and conversation, so that a layout question means the same thing to everyone.

## Terms

### Sheet

One piece of paper as it leaves the printer, such as one Letter sheet.

### Side

The front or the back of a sheet.

### Leaf

A piece of paper in the finished book, with a page on its front and a page on its back.

### Page

One printed side of a leaf.
The verb pages are landscape: wider than tall.

### Spread

The pair of pages that face each other when the book lies open.

### Spine

The edge where a spiral or staples hold the leaves together.

### Inner Margin

The margin of a page on the side of the spine.

### Outer Edge

The edge of a page away from the spine, where a reader turns the page.

### Recto and Verso

The recto is the page on the right of a spread, the front of a leaf.
The verso is the page on the left of a spread, the back of a leaf.
The first page of a book is a recto.

### Cut Line

A line where the print shop cuts a sheet into separate leaves.

### Fold Line

A line where the print shop folds a sheet instead of cutting it.
A folded sheet stays one piece and has four pages.

### Imposition

The arrangement of pages on the sheets.
A correct imposition gives a book in page order after cutting or folding and binding.

## Current Imposition

`impose.typ` builds `Español-carta-2up.pdf` from `Español-mediacarta.pdf`.

- The book is a spiral binding of loose leaves.
  Each leaf is media carta in portrait, 5.5 × 8.5 in, and goes onto the spiral on its own.
- Every Letter sheet, in landscape, holds two leaves side by side.
  The middle of the sheet is the cut line and the spiral edge of both leaves.
  So the outer edge of every page is the outer edge of the sheet.
- Each side of a sheet reads like an open book: a verso on the left, a recto on the right.
  Turning the sheet over swaps left and right.
- The page designs are landscape.
  The imposition turns each one a quarter, so the bottom of the text faces the outer edge of the sheet.
  The margins stay the same on every page.
- Page 1, the title, is the recto on the right half of sheet 1.
  The left half of sheet 1 is waste: blank on both sides, discarded after cutting.
- Every other half sheet is one leaf.
  Each verb fills one leaf, with the Indicativo on one side and the Subjuntivo on the other.
  Sheet 3 holds ser and haber, sheet 4 estar and tener, and every later sheet the next two verbs.

With p for a PDF page and b for a book page, the first sheets are:

- p1 waste, b1 · p2 b2, waste
- p3 b4, b5 · p4 b6, b3
- p5 b8, b9 · p6 b10, b7

Print on Letter, double-sided, flip on short edge, at 100 %.
Cut every sheet down the middle, and discard the waste half of sheet 1.
