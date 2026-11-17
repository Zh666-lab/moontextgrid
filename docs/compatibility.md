# TextGrid 文档兼容与编辑桥接

## 兼容目标与模型

本项目将官方 Unicode TextGrid 文本的语义兼容作为格式读写目标，分别提供文档层和严格编辑层。官方说明第 6 节区分了强不变量与弱不变量：区间正长度且相邻、点时间严格递增是强约束；条目首尾与层边界一致、层与网格边界一致是弱约束。**违反后两项的有效文本可以读取、保留、输出，并能显式转换后编辑。** 不再把它们一律当作坏文件。

|约束|`Document` 文档层|`Grid` 编辑层|
|---|---|---|
|网格/层声明域|有限且起点不晚于终点，允许零时长|有限、正时长，差值不溢出|
|层与网格同域|不要求|要求|
|区间首尾覆盖层|不要求，允许空层|要求，区间分割非空|
|区间正长度、连续相邻|要求；不接受内部缺口、重叠或零长度区间|要求|
|点严格递增且唯一|要求|要求|
|点落在声明域内|不要求|要求|

共享 `Tier` 类型表示层；必须按目标模型的校验入口判断有效性，不能直接把文档层交给严格编辑 API。层名、条目标签、原时间戳、层顺序及声明域均可由文档层保留；输出只规范化布局，不保留注释、缩进、原始数值拼写或原编码字节。Praat 的 trigraph 如 `\ae` 原样保存为字符序列，不在库内渲染为音标。

`parse_document` / `parse_document_bytes` 读取文档；`document` 防御性复制构造；`validate_document` 校验；`write_document_long` / `write_document_short` / `write_document_bytes` 序列化。UTF-8 和带 BOM 的 UTF-16LE/BE、长/短格式、中文、多行标签、双引号、LF/CRLF/CR 均支持。有限时间与有序声明域是本库明确的语义前提；不承诺接受 Praat 为损坏文件执行的所有容错修复，也不接受非有限数值或违反强约束的数据。

## 显式转换政策

`document_to_grid(doc)` 默认 `RequireAligned`：不做修复，只有原数据已经满足严格模型才成功。原有 `parse_text` / `parse_bytes` 保持该严格语义，避免老调用者无意间接受无法编辑的数据。`document_from_grid` 将编辑结果转回文档。

`document_to_grid(doc, policy=ExpandAndPad)`：

1. 取网格声明域、全部层声明域和实际条目时间范围的并集。
2. 将网格与全部层声明域设为这个范围。
3. 在区间序列的外侧缺口补空标签区间；空区间层补一个覆盖新域的空标签区间。
4. 保留全部原区间、点、标签与时间戳，包含空标签；不裁剪、不移动、不去重，也不合并相邻同标签。
5. 返回 `BridgeResult { grid, changes }`。`GridDomain` / `TierDomain` 记录旧/新域，`Padding` 记录补齐层与范围，层索引从 0 开始。已对齐输入的变更列表为空。

转换后的声明域和空白条目数量可能变化，**不是文档的无变化往返**。若业务不允许这些变化，应使用文档层保存，或采用默认拒绝策略并由业务人工决定。没有正长度范围或时间差溢出时返回 `GridError`，不虚构时长。输入和输出拥有独立数组，失败不修改原文档。解析预算同原有 `Limits`；转换最多为每个区间层新增两个外侧条目，直接构造的模型大小由调用者控制。

## 案例一：原样保留 → 补齐 → 编辑 → 输出

可执行命令：`moon run examples/compatibility`。对应文件位于 [输入](examples/weak-domain-input.TextGrid)、[文档输出](examples/weak-domain-preserved.TextGrid)、[编辑输出](examples/weak-domain-edited.TextGrid)。

输入的网格为 `[0,5]`，层声明 `[1,4]`，唯一标注为 `[2,3] "hello"`。文档读取和写出保留这三个不同范围，直接严格转换报错。选择 `ExpandAndPad` 返回三条记录：`TierDomain(0,1,4,0,5)`、`Padding(0,0,2)`、`Padding(0,3,5)`。结果为 `[0,2] ""`、`[2,3] "hello"`、`[3,5] ""`。随后在 2.5 分割中间标注并改为 `hel`、`lo`，输出四个连续区间；严格解析器可以重新读取。

## 案例二：实际条目在声明域之外

`document_wbtest.mbt` 的 `expansion preserves all annotations...`：网格 `[0,5]`，区间层声明 `[1,4]`、标注 `[2,3] "原标签"`；点层声明 `[0,1]`、点在 `-1 "前"` 和 `6 "后"`。文档层保留全部边界。显式转换得到 `[-1,6]` 的共同域、两端空白区间与两个原点，五条变更；所有原时间戳和标签保持。转换后二次执行不再产生变更。

## 案例三：空层、零时长与冲突

空区间层可以作为文档保存，转换时只有公共域正长度才会补一条空白区间。注意：所验证的 Praat 6.1.38 会在读取空区间层时自行补出声明域的空白区间；这是 Praat 的修复行为，本库文档层保留原有空序列。全空且共同域为 `[1,1]` 的文档能够读写，但转换报错。内部缺口、重叠、非正区间或重复点违反强约束，文档层也拒绝，不以扩展策略掩盖冲突。

## 独立兼容验证

除原有 TextGridTools 1.5 对照外，新增 `tools/praat_differential.py` 通过 Parselmouth 0.4.6 调用实际 Praat 6.1.38 引擎。16 组原创弱域数据的长/短文档及转换后长/短输出共 64 份由 Praat 读取，独立 Python 预期模型逐字段检查；Praat 反向写出的 32 份长/短文档由 MoonBit 测试读取并与独立模型比较。包含中文、空标签、引号、多行标签、域不一致及域外点。参考输出在生成便携测试向量时将平台 CRLF 统一为 LF；库本身保留标签内原始换行字符。该测试验证这一引擎版本与样本覆盖范围，不等于穷尽全部可能文本。

```sh
python -m pip install -r tools/praat-requirements.txt
python tools/praat_differential.py
```

此依赖仅供测试，运行库仍为纯 MoonBit。生成向量用 `--generate`，通常验证不会修改源文件。四后端 CI 均执行文档桥接测试与可运行编辑示例，wasm-gc 额外运行实际 Praat 引擎对照。

依据：[Praat 官方 TextGrid 格式说明第 6、7 节](https://www.fon.hum.uva.nl/praat/manual/TextGrid_file_formats.html)、[Parselmouth](https://github.com/YannickJadoul/Parselmouth)。二进制 TextGrid、旧式 Latin-1/MacRoman 自动识别、声学处理仍不在本版本范围内。
