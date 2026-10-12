# Resume – Mikołaj Mieszko Charchuta

A modern, LaTeX-based resume showcasing education, research experience, and technical skills in bioinformatics and microbiology.

![Resume Preview](https://img.shields.io/badge/format-PDF-red?style=flat-square)
![LaTeX Version](https://img.shields.io/badge/LaTeX-XeLaTeX-blue?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

## 📄 View the Resume

Three lengths are published, each with and without a profile photo. All six are
built from the same class file and fonts.

| Version | Pages | Plain | With photo |
|---|---|---|---|
| Resume, one page | 1 | [PDF](./Mikolaj%20Mieszko%20Charchuta%20Resume.pdf) | [PDF](./variants/Charchuta_Mikolaj_Resume_1page_photo.pdf) |
| Resume, two pages | 2 | [PDF](./variants/Charchuta_Mikolaj_Resume_2page.pdf) | [PDF](./variants/Charchuta_Mikolaj_Resume_2page_photo.pdf) |
| Full CV | 3 | [PDF](./variants/Charchuta_Mikolaj_CV_full.pdf) | [PDF](./variants/Charchuta_Mikolaj_CV_full_photo.pdf) |

A photo is customary on applications in the German-speaking countries and in
much of continental Europe. It is best left off in the UK, Ireland and the US,
where employers often discard CVs carrying one.

The one-page resume rebuilds automatically on every push to the source. Past
versions are in the git history rather than in dated copies.

## ✨ Features

- **Single-page layout** optimized for ATS systems and quick scanning
- **Two-column design** separating education/skills from experience/projects
- **Professional typography** using XeLaTeX with Lato and Raleway fonts via fontspec
- **Automated builds** using PowerShell script for instant PDF generation
- **Responsive content** including:
  - Education with thesis titles and university exchange programs
  - Research experience in microbiology and bioinformatics
  - Publications and projects with active hyperlinks
  - Multi-language skills (English, Polish, German, French)

## 🏗️ Template Origin

This resume is built on the **Deedy Resume template** by Debarghya Das ([original repo](https://github.com/deedy/Deedy-Resume)), maintained and extended with:
- Modern XeLaTeX compilation (OpenType font support)
- Custom class file patches for improved spacing and font compatibility
- Removal of obsolete LaTeX packages
- Automated build workflow

**Full attribution** to Deedy Resume template — this project extends and showcases that foundation.

## 🛠️ Building the Resume

### Prerequisites
- **MiKTeX 24.1+** or similar LaTeX distribution with XeLaTeX
- **latexmk** for build orchestration
- **PowerShell 5.1+** (Windows) for automation script
- **Fonts**: Lato and Raleway (included in `fonts/` directory)

### Quick Build

Run the automated build script:

```powershell
powershell -ExecutionPolicy Bypass -File .\build_resume.ps1
```

This will:
1. Compile the LaTeX source using XeLaTeX via latexmk
2. Generate `Mikolaj Mieszko Charchuta Resume.pdf`
3. Create a timestamped version: `Resume_ddMMMYYYY.pdf` (e.g., `Resume_22Feb2026.pdf`)

### Building all three lengths

```powershell
.\build_variants.ps1                    # the three public PDFs, plus private targets
.\build_variants.ps1 -Scope public      # only the PDFs committed to this repo
.\build_variants.ps1 -WithPhoto         # also build versions with a profile photo
```

Public sources and their committed PDFs:

| Source | Plain output | Photo output |
|---|---|---|
| `Mikolaj Mieszko Charchuta Resume.tex` | `Mikolaj Mieszko Charchuta Resume.pdf` | `variants/Charchuta_Mikolaj_Resume_1page_photo.pdf` |
| `variants/resume-2page.tex` | `variants/Charchuta_Mikolaj_Resume_2page.pdf` | `variants/Charchuta_Mikolaj_Resume_2page_photo.pdf` |
| `variants/cv-full.tex` | `variants/Charchuta_Mikolaj_CV_full.pdf` | `variants/Charchuta_Mikolaj_CV_full_photo.pdf` |

Every photo version lands in `variants/`, so the repo root holds only the
one-page resume.

The script picks a working `latexmk` automatically, which matters when a
half-finished MiKTeX update leaves a broken copy first on `PATH`. Override it
with `-MiktexBin`. Intermediate files go to `build/`.

### Private material stays outside this repository

This repository is public, so per-application resumes and cover letters are
**not** kept here. They live in a sibling folder, by default `../resume-private/`:

```
resume-private/
  applications/<company>/resume-1page.tex, resume-2page.tex, cv-full.tex
  output/<company>/...
```

```powershell
.\build_variants.ps1 -Scope private                 # all private targets
.\build_variants.ps1 -Target <company> -WithPhoto   # one of them
```

Point the script elsewhere with `-PrivateRoot`. It refuses any path that
resolves inside the repository.

Three independent safeguards keep per-application material unpublished:

1. **Location.** Git cannot commit files outside its working tree. This is the
   one that actually matters.
2. **`.gitignore`.** Blocks `tailored/`, `output/`, correspondence and images,
   should any appear here. Only `assets/profile-photo.jpg` is exempt.
3. **A pre-commit hook.** Install once per clone with `.\tools\install-hooks.ps1`.
   It refuses commits touching those paths or containing cover-letter wording.

**Photo.** A source calls `\resumephoto[<size>]{<x>}{<y>}` and the photo is drawn
only when the build defines `\withphoto`, so one source yields both versions.
The build prefers `assets/profile-photo.jpg` from this repo and falls back to the
private folder, so a fork without the image still builds the plain versions.

### Manual Build (Linux/macOS)

```bash
latexmk -xelatex "Mikolaj Mieszko Charchuta Resume.tex"
```

## 📁 Project Structure

```
.
├── Mikolaj Mieszko Charchuta Resume.tex    One-page resume source
├── Mikolaj Mieszko Charchuta Resume.pdf    One-page resume, compiled
├── variants/
│   ├── resume-2page.tex                    Two-page resume source
│   ├── cv-full.tex                         Full CV source
│   └── *.pdf                               Compiled output, plain and with photo
├── assets/
│   └── profile-photo.jpg                   Photo used by the photo variants
├── deedy-resume-openfont.cls               Deedy template class (patched)
├── build_variants.ps1                      Builds all lengths
├── build_resume.ps1                        Builds the one-pager only
├── tools/
│   ├── pre-commit                          Guard against publishing private files
│   └── install-hooks.ps1                   Installs the hook into .git/hooks
├── latexmkrc                               Build configuration
├── fonts/                                  OpenType fonts
│   ├── lato/
│   └── raleway/
├── README.md                               This file
└── LICENSE                                 MIT License
```

Not in this repository, by design: `../resume-private/` holds tailored
resumes, cover letters and the profile photo.

## 🔧 Customization

### Edit Your Resume

1. Open [Mikolaj Mieszko Charchuta Resume.tex](./Mikolaj%20Mieszko%20Charchuta%20Resume.tex)
2. Modify sections:
   - `\namesection{}{}{}` — Header with name, subtitle, contact info
   - `\section{}` — Major section headers (Education, Experience, etc.)
   - `\runsubsection{}` — Subsection headers with location/date
   - `tightemize` environment — Bullet points with tight spacing
3. Save and run build script or latexmk

### Template Variables

Key LaTeX macros from `deedy-resume-openfont.cls`:
- `\namesection{first}{last}{contact}` — Resume header
- `\section{sectiontitle}` — Section divider with line
- `\runsubsection{heading}` — Bold subsection (no scshape)
- `\descript{descriptor}` — Small descriptive text
- `\location{location}` — Right-aligned metadata
- `tightemize` environment — Compact bullet list

## ⚙️ Technical Details

### LaTeX Configuration

- **Engine**: XeLaTeX (xelatex)
- **Package manager**: latexmk with latexmkrc config
- **Font handling**: fontspec with external OpenType fonts
- **Page geometry**: 1cm margins, 0.55cm top, 0.45cm bottom
- **Two-column layout**: minipages at 33% / 66% split

### Build System

- **Windows**: PowerShell script `build_resume.ps1` (handles CP1252 encoding issues)
- **Unix/Linux**: Standard `latexmk -xelatex` invocation
- **Date format**: `ddMMMyyyy` (invariant culture, e.g., "22Feb2026")

### Font Stack

- **Serif**: Lato (Light, Regular, Bold variants)
- **Sans**: Raleway (loaded for flexibility)
- **Fallback**: Computer Modern (if fonts missing)

## 📋 Compilation History

Recent builds produce:
- ✅ One-page PDF (confirmed `[1]` page count)
- ✅ No LaTeX errors or missing package warnings
- ✅ All hyperlinks functional (GitHub, LinkedIn, email, YouTube)
- ✅ GDPR footer visible at page bottom

## 🚀 GitHub Pages Integration (Optional)

To display your resume on a GitHub Pages website:

1. **Enable GitHub Pages** in repository settings
   - Source: `main` branch, `/ (root)` directory

2. Add an `index.html` to display the PDF inline:
   ```html
   <!DOCTYPE html>
   <html>
   <body style="margin: 0; padding: 0;">
       <embed src="./Mikolaj Mieszko Charchuta Resume.pdf" type="application/pdf" width="100%" height="100vh" />
   </body>
   </html>
   ```

3. **Or** use GitHub's native PDF preview:
   - Navigate to your PDF in the repo
   - GitHub displays it automatically

## 📄 License

This project is licensed under the **MIT License** — see [LICENSE](./LICENSE) file.

**Template License**: The Deedy Resume template is also MIT-licensed. This work maintains compatibility with the original.

## 🙏 Acknowledgments

- **[Deedy Resume](https://github.com/deedy/Deedy-Resume)** — Original template by Debarghya Das
- **MiKTeX** — TeX distribution
- **XeLaTeX** — Modern TeX engine with OpenType support
- **Lato & Raleway** — Open-source typefaces

## 📬 Contact & Links

- **GitHub**: [github.com/mmcharchuta](https://github.com/mmcharchuta)
- **LinkedIn**: [linkedin.com/in/mmcharchuta](https://www.linkedin.com/in/mmcharchuta/)
- **Email**: [mmcharchuta@gmail.com](mailto:mmcharchuta@gmail.com)

---

**Last updated**: October 12, 2026

Built with LaTeX, pride, and TeX magic. ✨
