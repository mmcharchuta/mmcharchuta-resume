# Contributing

Thanks for your interest in this project! This is a personal resume repository, so contributions are focused on improvements to the LaTeX template, build system, and documentation.

## How to Contribute

### Reporting Issues
- Found a LaTeX compilation error?
- PDF rendering issue on GitHub Pages?
- Documentation unclear?

Please open an [Issue](../../issues) with:
- Steps to reproduce
- Expected vs. actual behavior
- Your environment (OS, LaTeX version, etc.)

### Suggesting Improvements

Ideas for improvements are welcome:
- **Template enhancements**: Better spacing, typography, or layout options
- **Build system**: Improved automation or cross-platform support
- **Documentation**: Clearer explanations or examples
- **Features**: New resume sections or styling options

Open an [Issue](../../issues) to discuss before submitting a PR.

### Submitting Pull Requests

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feature/your-feature-name`
3. **Make changes**:
   - Update LaTeX files directly or the build script
   - Add comments to explain non-obvious changes
   - Test locally with `latexmk -xelatex`
4. **Verify one-page layout**: `pdfinfo "Mikolaj Mieszko Charchuta Resume.pdf"` should show 1 page
5. **Commit** with clear messages: `git commit -m "Improve spacing in skills section"`
6. **Push** and open a **Pull Request**
7. Include in PR description:
   - What changed and why
   - Screenshots if layout/visual changes

## Development Setup

### Clone and Build Locally

```bash
git clone https://github.com/yourusername/your-resume-repo.git
cd your-resume-repo

# Install dependencies (see README.md)
# Then build:
latexmk -xelatex "Mikolaj Mieszko Charchuta Resume.tex"
```

### Code Style

- **LaTeX**: Follow naming conventions in `deedy-resume-openfont.cls`
- **Scripts**: PowerShell scripts follow [PSSriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) best practices
- **Markdown**: Use consistent formatting and active voice

## Testing Your Changes

1. **Compile without errors**: No "LaTeX Error" in log output
2. **One page only**: `pdfinfo` shows exactly 1 page
3. **All hyperlinks work**: Test GitHub, LinkedIn, email, YouTube links
4. **PDF size reasonable**: < 100KB for text-based resume
5. **Cross-platform**: Test on Windows, macOS, Linux if possible

## Questions?

- **LaTeX issues?** See the [LaTeX documentation](https://www.latex-project.org/help/)
- **Deedy Resume?** Check the [original repo](https://github.com/deedy/Deedy-Resume)
- **XeLaTeX?** Refer to [XeLaTeX documentation](https://tug.org/xetex/)

---

**Thank you for helping improve this resume template!** 🙏
