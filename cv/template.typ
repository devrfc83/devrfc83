// Plantilla común del CV. Los textos de cada idioma viven en data/<idioma>.json
// y los datos que no dependen del idioma en data/common.json.

#let common = json("data/common.json")

#let serif = "IBM Plex Serif"

// Palette ─────────────────────────────────────────────────────────────────

#let navy = rgb("#0f172a")
#let navy-soft = rgb("#334155")
#let teal = rgb("#0d9488")
#let teal-soft = rgb("#ccfbf1")
#let sidebar-bg = rgb("#f1f5f9")
#let muted = rgb("#64748b")
#let hair = rgb("#e2e8f0")

// Helpers ─────────────────────────────────────────────────────────────────

#let dot(size: 6pt, fill: teal) = box(width: size, height: size, radius: 50%, fill: fill)

#let heading-block(title, on-dark: false) = {
  let fg = if on-dark { white } else { navy }
  stack(
    dir: ttb,
    spacing: 5pt,
    text(font: serif, size: 10pt, weight: "bold", fill: fg, tracking: 1.6pt, upper(title)),
    box(width: 22pt, height: 2.4pt, fill: teal, radius: 1pt),
  )
  v(0.4em)
}

#let job(role, org, dates, desc: none) = {
  block(
    width: 100%,
    fill: white,
    stroke: (left: 2.8pt + teal),
    inset: (left: 14pt, right: 4pt, top: 4pt, bottom: 4pt),
    breakable: false,
    {
      grid(
        columns: (1fr, auto),
        align: (left + top, right + top),
        gutter: 6pt,
        stack(
          dir: ttb,
          spacing: 4pt,
          text(font: serif, size: 11pt, weight: "bold", fill: navy, role),
          text(size: 9.4pt, style: "italic", fill: muted, org),
        ),
        box(
          fill: sidebar-bg,
          inset: (x: 8pt, y: 3.5pt),
          radius: 3pt,
          text(size: 8.3pt, weight: "medium", fill: navy-soft, dates),
        ),
      )
      if desc != none {
        v(4pt)
        text(size: 8.7pt, fill: navy-soft, desc)
      }
    }
  )
  v(1.05em)
}

// `degree` puede ser un título o una lista de títulos otorgados juntos.
#let edu(degree, org, detail) = {
  let degrees = if type(degree) == array { degree } else { (degree,) }
  stack(
    dir: ttb,
    spacing: 4pt,
    stack(dir: ttb, spacing: 9pt, ..degrees.map(d => text(font: serif, size: 10pt, weight: "bold", fill: navy, d))),
    text(size: 9pt, fill: navy-soft, org),
    text(size: 8.4pt, fill: muted, style: "italic", detail),
  )
  v(0.75em)
}

#let lang-entry(lang, level, label) = {
  stack(
    dir: ttb,
    spacing: 4pt,
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(size: 9.8pt, weight: "medium", fill: navy, lang),
      {
        for i in range(5) {
          dot(size: 6pt, fill: if i < level { teal } else { hair })
          if i < 4 { h(3pt) }
        }
      }
    ),
    text(size: 8pt, fill: muted, label),
  )
  v(0.55em)
}

#let skill-tag(s) = {
  box(
    fill: navy,
    inset: (x: 8pt, y: 4.5pt),
    radius: 9pt,
    text(size: 8.3pt, fill: white, s),
  )
}

// Document ────────────────────────────────────────────────────────────────

#let cv(t) = {
  let labels = t.labels

  set document(title: common.name.at(0).split(" ").at(0) + " " + common.name.at(1), author: common.name.join(" "))
  set page(paper: "a4", margin: 0pt)
  set text(font: "IBM Plex Sans", size: 10.3pt, fill: rgb("#1e293b"), lang: t.lang)
  set par(leading: 0.55em, justify: false)

  // Header ───────────────────────────────────────────────────────────────

  block(
    width: 100%,
    fill: navy,
    inset: (left: 2.1cm, right: 2.1cm, top: 1.3cm, bottom: 1.1cm),
    {
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        gutter: 1em,
        stack(
          dir: ttb,
          spacing: 9pt,
          ..common.name.map(n => text(font: serif, size: 20pt, weight: "bold", fill: white, n)),
          v(11pt),
          text(size: 11pt, fill: teal-soft, tracking: 0.4pt, t.headline),
        ),
        box(
          width: 2.5cm,
          height: 2.5cm,
          radius: 50%,
          clip: true,
          stroke: 2pt + teal,
          image("profile.jpg", width: 2.5cm, height: 2.5cm, fit: "cover"),
        ),
      )
      v(1em)
      line(length: 100%, stroke: 0.5pt + rgb("#334155"))
      v(0.85em)
      set text(size: 8.6pt, fill: rgb("#cbd5e1"))
      let field(label, value) = [#text(fill: teal-soft, weight: "bold")[#label] #h(3pt) #value]
      grid(
        columns: 3,
        column-gutter: 1.6em,
        align: left,
        field(labels.email, common.email),
        field(labels.location, t.location),
        field(labels.web, link(common.web, common.web.trim("https://", at: start).trim("/", at: end))),
      )
    }
  )

  // Body ─────────────────────────────────────────────────────────────────

  grid(
    columns: (35%, 65%),
    gutter: 0pt,
    stroke: (x, y) => if x == 0 { (right: 0.6pt + hair) },

    // ── Sidebar ────────────────────────────────────────────────────────
    block(
      width: 100%,
      inset: (left: 1.5cm, right: 1.1cm, top: 1.7cm, bottom: 1cm),
      {
        heading-block(labels.education)
        for e in t.education.values() {
          edu(e.degree, e.org, e.detail)
        }

        v(0.6em)
        heading-block(labels.skills)
        {
          set par(leading: 1.05em)
          for s in common.skills {
            skill-tag(s)
            h(6pt)
          }
        }

        v(0.7em)
        heading-block(labels.languages)
        for l in common.languages {
          lang-entry(t.languages.at(l.id), l.level, t.levels.at(str(l.level)))
        }
      }
    ),

    // ── Main column ────────────────────────────────────────────────────
    block(
      width: 100%,
      inset: (left: 1.3cm, right: 1.7cm, top: 1.7cm, bottom: 1.5cm),
      {
        heading-block(labels.experience)
        for j in common.experience {
          let x = t.experience.at(j.id)
          let to = if j.to == none { labels.present } else { str(j.to) }
          job(x.role, x.org, str(j.from) + " — " + to, desc: x.desc)
        }
      }
    ),
  )
}
