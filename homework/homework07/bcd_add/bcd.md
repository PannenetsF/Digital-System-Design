---
output:
  pdf_document:
    pandoc_args: [
      "--template=/usr/share/pandoc/data/templates/pm-template.latex"
    ]
export_on_save:
    pandoc: true
---

# BCD 设计

本次设计的测试未采用之前所描述的方法，后文将进行介绍。

## 设计

将 BCD 码转为二进制码并加一，测试进位即可。

## 测试

BCD 码局限在 0-999 之间，因此直接遍历取值，并进行验证。

通过则显示 passed ，未通过则显示错误发生的位置与状态，方便在波形中定位。输出波形在 `test.wlf` 与 `test.vcd` 中，数量过大，因此未添加到本文档中。