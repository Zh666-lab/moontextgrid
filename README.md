# MoonTextGrid

纯 MoonBit 的 **Praat TextGrid 语言时间标注库**，模块为 `Zh666-lab/moontextgrid@0.1.0`，MIT 许可证。

语料维护者可以导入并规范化标注；媒体片段工具可以编辑、裁剪和拼接标注；语音训练与评估团队可以导出结构化数据、统计覆盖时长并比较两份标注。核心库只处理内存中的数据，不依赖音频、文件系统、Python 或外部服务。

## 已实现的能力

- 长、短文本 TextGrid 解析及规范化输出，双引号转义、中文、多行与补充平面字符。
- UTF-8，以及带 BOM 的 UTF-16LE / UTF-16BE 严格解码和输出；畸形编码报错。
- 连续完整区间分区、严格有序点序列；资源预算；防御性复制。
- 区间拆分、合并、改标签、移动边界、相邻同标签合并；点插入、移动、删除及改标签。
- 层查找、筛选、插入、替换、删除、重命名；标签映射与时间窗口查询。
- 平移、正比例缩放、重定位、裁剪、兼容层拼接及接缝点冲突检测。
- 双指针区间重叠与标签掩码；标签时长、覆盖率和最长区间查询。
- 按时长加权的混淆表、一致率、Cohen kappa；一对一点匹配与内部边界匹配。
- 版本化 JSON 与六列记录 CSV 的完整导入导出，保留空点层和重名层。

不支持 Praat 二进制 TextGrid、Latin-1/MacRoman、ELAN、音频处理、自动语音识别、强制对齐、图形编辑器或磁盘读写。可以在调用端使用任意 I/O 库读取文件，再交给 `parse_bytes`。

## 环境与安装

使用 **moonc 0.10.16+b1a0e846e** 及配套 core。CI 固定同一版本、校验官方归档 SHA-256，并在 Ubuntu 24.04 检查 `wasm-gc`、`wasm`、`js`、`native`。JS 需要 Node.js；native 需要 C 编译器。Windows 本地验收使用 wasm-gc/wasm/JS，Linux native 使用 GCC；没有承诺 Windows MSVC 验收。

Linux x86-64 可执行：

```sh
bash scripts/install-moon.sh "$HOME/.local/share/moontextgrid-0.10.16"
export MOON_HOME="$HOME/.local/share/moontextgrid-0.10.16"
export MOON_TOOLCHAIN_ROOT="$MOON_HOME"
export PATH="$MOON_HOME/bin:$PATH"
moon version --all
```

安装脚本要求目标目录尚不存在。官方归档链接若被移除会明确失败，不自动切换未知编译器。其他平台请从 [MoonBit 官方下载页面](https://www.moonbitlang.com/download/) 安装兼容工具链。

在任意空目录创建以下三个文件，就能使用精确版本；不需要 MoonCakes token。

`moon.mod`：

```moonbit
name = "demo/textgrid_consumer"
version = "0.1.0"
import {
  "Zh666-lab/moontextgrid@0.1.0",
}
```

`moon.pkg`：

```moonbit
import { "Zh666-lab/moontextgrid" @tg, }
options("is-main": true)
```

`main.mbt`：

```moonbit
fn main {
  try {
    let words = @tg.interval_tier("words", 0, 2, [
      { start: 0, end: 1, label: "你好" },
      { start: 1, end: 2, label: "世界" },
    ])
    let g = @tg.grid(0, 2, [words])
    let text = @tg.write_long(g)
    let restored = @tg.parse_text(text)
    println(@tg.write_json(restored))
  } catch { e => abort("\{e.to_repr()}") }
}
```

运行：

```sh
moon update
moon check --deny-warn
moon run .
```

输出 JSON 的 `schema` 为 `moontextgrid/1`，区间标签依次是 `你好`、`世界`，时间域为 `[0, 2]`。

## 三个完整工作流

从仓库运行：

```sh
git clone https://github.com/Zh666-lab/moontextgrid.git
cd moontextgrid
moon run examples/import
moon run examples/clips
moon run examples/evaluate
```

|示例|输入 → 处理 → 输出|预期关键输出|
|---|---|---|
|`examples/import`|中文短格式 → 解析、长格式规范化、重读 → 语料统计|`import: tiers=1 entries=2 coverage=1`|
|`examples/clips`|原始标注 → 改区间、裁剪归零、拼接 → CSV 导出并重读|`clips: start=0 end=3 entries=3`|
|`examples/evaluate`|两份区间标注 → 时长一致性与边界匹配 → JSON 导出并重读|`evaluate: observed=0.75 boundary_f1=1 exported_tiers=2`|

这些示例使用公开 API 和原创合成数据；边界容差使用与输入相同的时间单位，约定通常为秒。

## 常用 API 与组合

```moonbit
// 以下代码放在能传播 GridError 的函数或 try/catch 中。
let g = @tg.parse_bytes(bytes)
let t = @tg.get_tier(g, 0)
let edited = @tg.split_interval(t, 1.25, "前半", "后半")
let changed = @tg.replace_tier(g, 0, edited)
let clip = @tg.crop(changed, 0.5, 2.5, rebase_to_zero=true)
let output = @tg.write_bytes(clip, encoding=Utf16LE)
```

该片段要求输入域包含 `[0.5,2.5]` 且 1.25 严格位于一个区间内部。完整可运行输入见三个示例。[接口清单](pkg.generated.mbti) 与 [语义说明](docs/semantics.md) 说明边界、复杂度、数据所有权和错误行为。[交换格式](docs/exchange.md) 定义 JSON/CSV。

主要入口：`parse_text` / `parse_bytes` / `write_long` / `write_short` / `write_bytes`，`interval_tier` / `point_tier` / `grid`，`crop` / `concatenate`，`overlaps` / `summarize` / `agreement` / `match_boundaries`，`parse_json` / `write_json` / `parse_csv` / `write_csv`。

## 语义和限制

- 本库采用严格模型：有限正时长、各层与网格同域，区间完整连续覆盖且长度为正，点时间唯一递增并在闭域内。层名可重复，以索引定位。Praat 文本也可能包含不满足这些约束的数据；本库会拒绝，不声称接受所有 Praat 可打开的文件。
- TextGrid 按自由数值、引号字符串和存在标志读取；展示索引不影响语义，`!` 开始的行尾注释不作为数据。输出规范化布局，不保留原缩进、注释或数值字面形式。
- 时间为 IEEE-754 Double，边界相等使用精确比较，不自动吸附。运算结果若溢出、区间塌缩或点重合，会报 `GridError`。显著不同比例的数据应先选择合适时间原点和单位。
- 查询内部边界归右侧区间，最终右端点归最后区间；裁剪保留窗口两端的点。拼接要求层数、名称、顺序、类型相同；接缝同标签点去重，冲突标签报错。
- 连续一致率含空标签；kappa 在预期一致率为 1 时返回 `None`。点/边界匹配只按时间，记录标签是否相同，贪心策略最大化匹配数；不承诺最小总时间差。空分母的 precision/recall/F1 均为 0。
- 默认预算为 8,000,000 UTF-16 单元、1,000,000 TextGrid token、1,000 层、总计 100,000 条目。JSON 深度上限 16，拒绝重复键；CSV 为本项目的记录模式。预算不等于进程内存上限，已经构建的模型由调用者负责控制大小。
- 纯数据函数返回独立数组；公开结构仍可由调用者修改，后续严格操作会重新校验。错误消息不回显标注内容。

## 测试与复现

```sh
moon info
moon fmt --check
moon check --deny-warn --target wasm-gc
moon test --deny-warn --target wasm-gc
moon build --deny-warn --target wasm-gc
# 可将 target 分别换为 wasm、js、native；native 需 C 编译器。
```

测试覆盖模型/所有权、长短格式、中文与代理项、畸形编码、资源预算、编辑失败与原数据保护、时间变换、裁剪拼接、重叠、统计、匹配、JSON/CSV，以及原创外部互操作向量。还包括 1,024 组点匹配与穷举最优解对照、二次区间交集基线和 32 组多格式不变量。

可选独立对照（运行库无需 Python）：

```sh
python -m pip install -r tools/oracle-requirements.txt
python tools/differential.py
```

固定 `TextGridTools (tgt) 1.5`：24 份本库输出由外部读取；24 份外部生成的长/短格式向量由 MoonBit 测试读取。样本由本项目原创生成，含空标签、中文、重音字符及引号。该对照覆盖两者共同文本子集；tgt 的逐行读取方式不能验证多行标签，多行部分依据 Praat 文档和本库独立边界测试。不是对完整 Praat 桌面程序的互操作证明。[CI](https://github.com/Zh666-lab/moontextgrid/actions) 在每次推送运行四后端与独立对照。

## 来源、许可证与 AI 披露

原创实现，采用 [MIT](LICENSE)。仅运行时依赖 MoonBit core；没有复制 GPL TextGridTools、Praat 或其他项目源代码。开发时参照 [Praat TextGrid 格式说明](https://www.fon.hum.uva.nl/praat/manual/TextGrid_file_formats.html)，使用外部参考实现验证行为，详见 [来源说明](THIRD_PARTY.md)。AI 参与需求研究、实现、测试和文档，项目维护者仍对结果负责。未宣称组委会已验收或已完成报名。
