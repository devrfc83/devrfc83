#set document(title: "Rodrigo Fuentealba Cartes")

#set page(paper: "a4", margin: 0pt)
#set text(font: "IBM Plex Sans", size: 10.3pt, fill: rgb("#1e293b"))
#set par(leading: 0.55em, justify: false)

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

#let edu(degree, org, detail) = {
  stack(
    dir: ttb,
    spacing: 4pt,
    text(font: serif, size: 10pt, weight: "bold", fill: navy, degree),
    text(size: 9pt, fill: navy-soft, org),
    text(size: 8.4pt, fill: muted, style: "italic", detail),
  )
  v(0.75em)
}

#let lang-level = (
  "Moedertaal": 5,
  "Gevorderd": 4,
  "Basis": 2,
)

#let lang-entry(lang, level) = {
  stack(
    dir: ttb,
    spacing: 1pt,
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      text(size: 9.8pt, weight: "medium", fill: navy, lang),
      {
        let n = lang-level.at(level, default: 3)
        for i in range(5) {
          dot(size: 6pt, fill: if i < n { teal } else { hair })
          if i < 4 { h(3pt) }
        }
      }
    ),
    text(size: 8pt, fill: muted, level),
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

// Header ─────────────────────────────────────────────────────────────────

#block(
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
        text(font: serif, size: 20pt, weight: "bold", fill: white, "Rodrigo Fabián Andrés"),
        text(font: serif, size: 20pt, weight: "bold", fill: white, "Fuentealba Cartes"),
        v(11pt),
        text(size: 11pt, fill: teal-soft, tracking: 0.4pt, "Informatica-ingenieur"),
      ),
      box(
        width: 2.5cm,
        height: 2.5cm,
        radius: 50%,
        clip: true,
        stroke: 2pt + teal,
        image("profile.png", width: 2.5cm, height: 2.5cm, fit: "cover"),
      ),
    )
    v(1em)
    line(length: 100%, stroke: 0.5pt + rgb("#334155"))
    v(0.85em)
    set text(size: 8.6pt, fill: rgb("#cbd5e1"))
    grid(
      columns: 4,
      column-gutter: 1.6em,
      align: left,
      [#text(fill: teal-soft, weight: "bold")[Tel.] #h(3pt) +56 9 9670 5711],
      [#text(fill: teal-soft, weight: "bold")[E-mail] #h(3pt) devrfc83\@gmail.com],
      [#text(fill: teal-soft, weight: "bold")[Locatie] #h(3pt) Talca, Maule, Chili],
      [#text(fill: teal-soft, weight: "bold")[Web] #h(3pt) #link("https://www.devrfc83.com/")[www.devrfc83.com]],
    )
  }
)

// Body ─────────────────────────────────────────────────────────────────

#grid(
  columns: (35%, 65%),
  gutter: 0pt,
  stroke: (x, y) => if x == 0 { (right: 0.6pt + hair) },

  // ── Sidebar ──────────────────────────────────────────────────────────
  block(
    width: 100%,
    inset: (left: 1.5cm, right: 1.1cm, top: 1.7cm, bottom: 1cm),
    {
      heading-block("Opleiding")
      edu(
        "Informatica-engineering",
        "Universidad Andrés Bello",
        "Afgestudeerd met Cum Laude Onderscheiding — 2024",
      )
      edu(
        "Programmeur-Analist",
        "Instituto INACAP",
        "Afgestudeerd in 2008",
      )

      v(0.6em)
      heading-block("Vaardigheden")
      {
        set par(leading: 1.05em)
        let skills = (
          "Linux", "Docker", "Apache", "PostgreSQL",
          "PHP/Laravel", "JavaScript/React", "CSS/Tailwind",
        )
        for s in skills {
          skill-tag(s)
          h(6pt)
        }
      }

      v(0.7em)
      heading-block("Talen")
      lang-entry("Spaans", "Moedertaal")
      lang-entry("Engels", "Gevorderd")
      lang-entry("Duits", "Basis")
      lang-entry("Italiaans", "Basis")
    }
  ),

  // ── Main column ──────────────────────────────────────────────────────
  block(
    width: 100%,
    inset: (left: 1.3cm, right: 1.7cm, top: 1.7cm, bottom: 1.5cm),
    {
      heading-block("Relevante Ervaring")
      job(
        "Projectingenieur", "Carabineros de Chile", "2022 — Heden",
        desc: "Ontwikkeling van systemen ter ondersteuning van het ontwerp van openbaar veiligheidsbeleid in het kader van de Chileense S.T.O.P.-wet.",
      )
      job(
        "Directievoerend Vennoot", "Sea Dragon S.p.A., Chile", "2021 — Heden",
        desc: "Oprichter en directeur van Sea Dragon S.p.A., een technologisch adviesbureau gespecialiseerd in data science en software-engineering.",
      )
      job(
        "IT-Consultant / Data Scientist", "The Pegasus Group, Chile", "2017 — 2021",
        desc: "Ontwikkeling van technologische oplossingen op maat voor klanten in de publieke en private sector, en vertegenwoordiging van het merk RapidMiner in Chili.",
      )
      job(
        "Softwareontwikkelaar", "Zeit.io, Duitsland", "2015 — 2016",
        desc: "Ontwikkeling van systemen voor de klanten van het bedrijf, op afstand.",
      )
      job(
        "Softwareontwikkelaar", "Intellisoft, Chile", "2009 — 2014",
        desc: "Ontwikkeling van SaaS-systemen (software as a service) voor de bedrijven van de holding: Fidelizador en ProactiveOffice.",
      )
      job(
        "Softwareontwikkelaar", "Parés y Álvarez Ingenieros Asociados, Chile", "2006 — 2007",
        desc: "Ontwikkeling van informatiesystemen voor interne klanten en medewerking aan het ontwerp van het bedrijfsnetwerk en datacenter.",
      )
    }
  ),
)
