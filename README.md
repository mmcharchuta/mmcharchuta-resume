# Resume – Mikołaj Mieszko Charchuta

A modern, LaTeX-based resume showcasing education, research experience, and technical skills in bioinformatics and microbiology.

![Resume Preview](https://img.shields.io/badge/format-PDF-red?style=flat-square)
![LaTeX Version](https://img.shields.io/badge/LaTeX-XeLaTeX-blue?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

## 📄 View the Resume

**[Download Latest Resume PDF](./Mikolaj%20Mieszko%20Charchuta%20Resume.pdf)**

The resume is generated automatically with a timestamped version on each update:
- **Latest**: `Mikolaj Mieszko Charchuta Resume.pdf` — Always reflects current source
- **Dated snapshots**: `Resume_22Feb2026.pdf` — Version history for tracking

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

### Manual Build (Linux/macOS)

```bash
latexmk -xelatex "Mikolaj Mieszko Charchuta Resume.tex"
```

## 📁 Project Structure

```
.
├── Mikolaj Mieszko Charchuta Resume.tex    Main resume source file
├── deedy-resume-openfont.cls               Deedy template class (patched)
├── build_resume.ps1                        Automated build script
├── latexmkrc                               Build configuration
├── fonts/                                  OpenType fonts
│   ├── lato/
│   └── raleway/
├── README.md                               This file
├── LICENSE                                 MIT License
└── Mikolaj Mieszko Charchuta Resume*.pdf   Compiled output
```

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

- **GitHub**: [Your GitHub Profile](https://github.com/yourusername)
- **LinkedIn**: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- **Email**: [your.email@domain.com](mailto:your.email@domain.com)

---

**Last updated**: February 22, 2026

Built with LaTeX, pride, and TeX magic. ✨
