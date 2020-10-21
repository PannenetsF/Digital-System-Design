---
output:
  pdf_document:
    pandoc_args: [
      "--template=/usr/share/pandoc/data/templates/pm-template.latex"
    ]
export_on_save:
    pandoc: true
---

# MUX4

测试见上层目录 `overview.pdf` 。

## 思路

若是使能，按照位进行选择即可。

## 测试

执行 `python` 文件获得随机数据， 执行测试用 `verilog` 文件，读取数据以及对应的输出，通过则显示 passed ，未通过则显示错误发生的位置与状态，方便在波形中定位。输出波形在 `test.wlf` 与 `test.vcd` 中，数量过大，因此未添加到本文档中。