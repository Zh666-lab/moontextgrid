# 架构与验收边界

纯数据引擎：TextGrid → Grid → 校验后的操作 → TextGrid / JSON / CSV。
时间以有限 Double 秒表示；区间严格正长度、连续分割，点严格递增；不使用隐式近似容差修复数据。
所有公开入口校验，编辑返回深拷贝，不修改调用者。解析预算限制输入、token、层与条目总数。

本版本核心：长/短文本读写，UTF-8/UTF-16，分割合并、标签编辑、时轴变换、裁剪拼接、区间交集、时长统计与标注一致性。
不支持二进制 TextGrid、旧式 Latin-1/MacRoman、声学分析、自动语音识别/强制对齐、GUI 或文件系统副作用。
三个工作流为语料规范化、标注片段编辑与切片、下游训练数据与双人标注对比。

客观验收：Praat 官方文本 token/invariant 规格；独立 Python TextGrid 程序双向读写；Python 区间模型/CSV/JSON 对照；四后端严格检查构建测试和三个 runnable examples。
