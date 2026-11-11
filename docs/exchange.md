# JSON 与 CSV 交换约定

JSON 模式标识固定为 `moontextgrid/1`，顶层为 `schema,start,end,tiers`。层包含 `kind,name,start,end,entries`；kind 为 `interval` 时条目是 `[start,end,label]`，为 `point` 时是 `[time,label]`。未知对象字段作为附加元数据忽略，重新导出不会保留；必需字段缺失、类型错误、未知 kind/schema、重复对象键、超过深度或预算均报错。

```json
{"schema":"moontextgrid/1","start":0,"end":1,"tiers":[{"kind":"interval","name":"words","start":0,"end":1,"entries":[[0,1,"你好"]]}]}
```

CSV 固定六列，记录顺序为 header、grid、各 tier metadata 及该层条目。索引从 0 开始，层元数据按连续索引出现，支持重名层和空点层。网格记录的 tier/name/label 必须为空，层元数据的 label 为空，条目 name 为空。点记录 start/end 必须相等。

```csv
record,tier,name,start,end,label
"grid","","","0","1",""
"interval-tier","0","words","0","1",""
"interval","0","","0","1","你好"
"point-tier","1","events","0","1",""
```

writer 给所有数据字段加引号并输出 CRLF。reader 也接受不加引号的字段和 LF/CR；引号中双引号写两次，允许字面换行。拒绝引号后空格等非法 quoting，不跳过空行，不自动更改标签。该 CSV 保留原标签，包括 `=` 等字符；若给电子表格展示，调用端按自身导入规则将标签作为纯文本。它不是 Praat 原生 CSV 规范，也不是任意表格的自动猜测器。
