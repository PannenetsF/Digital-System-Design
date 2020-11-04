---
output:
  pdf_document:
    pandoc_args: [
      "--template=/usr/share/pandoc/data/templates/pm-template.latex"
    ]
export_on_save:
    pandoc: true
---

# Moore状态机

输出需要完全由状态决定，因此需要设定不同的状态跳转方式。对于输出，只需在特定状态输出即可。