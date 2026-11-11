# MoonTextGrid 选题与有界查重

日期：2026-11-11。使用本机 osc2026-guide 的 Project Research Guide：moon search → MoonCakes docs/manifest → GitHub 实际源码/接口/测试；比赛条款沿用 builder 固定来源，不切换为八月规则。

## 需求先于新颖度

Praat 官方 [TextGrid 文件格式](https://www.fon.hum.uva.nl/praat/manual/TextGrid_file_formats.html) 描述多人多层语言时间标注；[TextGridTools](https://github.com/hbuschme/TextGridTools)、[python-textgrid](https://github.com/kylebgorman/textgrid) 已为语料处理提供成熟实现。没有假设参与者已从事语音工作，也没有编造访谈。
语料维护者需要读取、定位错误与规范化历史标注；编辑/切片工具需要保留边界和标签的切分、合并、裁剪及拼接；ASR 数据工程/双人标注团队需要区间重叠、差异统计与结构化输出。现有声学引擎不处理这些时间标注语义。独立纯数据包可供 wasm/native/JS 集成，而不把格式处理耦合到 GPL 声学实现或桌面图像 UI。

## 三领域比较

评分顺序：广度/用户/复用/低重合风险/深度/验证/可完成性/维护；各 1–5，仅通过硬门禁者参与排序。

|候选|任务、成熟依据、完整核心|评分|结论|
|---|---|---|---|
|生存统计|医疗/设备/用户流失的删失时间 → KM/NA/Cox；R survival、lifelines；拟交付生存曲线与组间检验|5/5/5/1/5/5/4/4=34|硬失败：已有直接成熟替代|
|电路求解|电子教育/EDA/嵌入式的 SPICE 网表 → MNA DC/AC；ngspice；拟交付线性器件求解与结果|5/4/5/1/5/5/3/3=31|硬失败：已有直接成熟替代|
|TextGrid 时间标注|语料维护/编辑切片/训练评估；Praat 规格及成熟 Python 工具；文本交换+编辑+分析闭环|4/4/5/4/4/5/5/4=35|选定；发布前反查|

## 实际检索范围

`moon search <term> --limit 100 --json` 搜索 survival/Kaplan/Meier/Nelson/Aalen/logrank/censor/hazard/lifelines/生存分析；circuit/SPICE/nodal/ngspice/电路；TextGrid/Praat/annotation/phonetic/tgt/语音标注；statistics/linear algebra；praatio/IntervalTier/TextTier/linguistic annotation/ELAN/forced alignment/annotation grid/textgrid parser。原始结果、错误和 SHA 位于仓库外本次 research-20261111，不含凭据。
GitHub REST search repositories per_page=100：TextGrid/Praat/speech annotation/MoonTextGrid/survival/circuit + MoonBit，反查 IntervalTier、praatio 等。TextGrid+MoonBit=0，Praat+MoonBit=1（ngan）；广义 TextGrid 全语言382条仅查看第一页100，不据此声明全量唯一。官方 awesome-moonbit README、完整注册表192段的匹配指纹均检查。注册表保留 MoonConcept/MoonAllen/MoonRecur/MoonShard 等边界，不复用旧实现。

## 实际近邻能力矩阵

|项目与证据|输入→行为→输出|分类与决定|
|---|---|---|
|[Lyl66655/moon-survival](https://mooncakes.io/docs/Lyl66655/moon-survival) 0.2.4；当前仓库迁移至 WmmmQa；实际 src/kaplan_meier.mbt 与测试|删失生存记录→KM/NA/Cox→曲线/回归|直接替代；淘汰生存候选|
|[hsy-bit/moonbit-circuit-solver](https://github.com/hsy-bit/moonbit-circuit-solver) 0.1.1；实际 MNA source/README/test tree|网表→MNA DC/AC/瞬态→电压电流|直接替代；淘汰电路候选|
|[wrinh/ngan](https://github.com/wrinh/ngan) 75dedd10；实际 types/types.mbt、lib_test.mbt、README|PCM→pitch/formant/intensity/spectrogram→声学采样|同方向不同核心；不含 TextGrid tiers 编辑；GPL 代码不复制|
|[riantr/moonbit_labeler](https://mooncakes.io/docs/riantr/moonbit_labeler) 0.2.14；实际 manifest/README/源码树；正确仓库 riantr/moonbit-labeler|图像/视频帧→矩形/多边形/关键点标注→VOC/YOLO/COCO|同方向不同模型；不处理语言时间分割；下划线仓库 URL404 已纠正|
|[zbhzs1/moonbit-phonetic](https://github.com/zbhzs1/moonbit-phonetic) 0.3.0；实际 encoder source/tests|姓名字符串→phonetic keys/匹配→去重结果|非时间标注；可独立使用|
|kesmeey/IntervalTree；包摘要可读，链接源码404|一般区间索引|基础数据结构而非 TextGrid 工具；源码不可访问限制保留，不声称已审完整实现|
|MoonAllen 注册表完整指纹|Allen 定性关系→约束传播→一致性/关系|不同工作流；本项目不做定性时间推理|

## 限制与权利

在上述已记录检索范围内未发现成熟直接替代，非绝对唯一性或官方裁决。索引可能延迟，未公开代码不可审；官方 raw.githubusercontent.com 直连失败改用已绑定 GitHub API，只读获取原文件。引用规格和参考程序行为，不复制 GPL/MIT 上游代码、样本或文案；原创 MIT 实现与自制合成语料。
