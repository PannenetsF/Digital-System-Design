---
output:
  pdf_document:
    pandoc_args: [
      "--template=/usr/share/pandoc/data/templates/pm-template.latex"
    ]
export_on_save:
    pandoc: true
---
# 二进制格雷码互转

本设计的测试的整体方法请见顶层目录的 `Overview.pdf` 。

## 二进制转格雷码

算法：
```c
gray = bin ^ (bin >> 1);
```

可以直接使用位运算实现。

## 格雷码转二进制

算法:

```c
/*
 * for n bits code 
 * g is gray code 
 * b is binary code
 */ 
 b[n-1] = g[n-1];
 for (int i = n - 2; i >= 0; --i) {
     b[i] = b[i] ^ g[i+1];
 }

```

对应的，可以使用锁存器的组合逻辑实现之。

```verilog
always @(*) begin
    temp[3] = in[3];
    for (i = 2; i >= 0; i = i - 1) begin
        temp[i] = in[i] ^ temp[i+1];
    end    
end
```

