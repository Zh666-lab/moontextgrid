# 来源与参考边界

本项目为原创 MIT 实现。没有将外部代码翻译、嵌入、改名或打包，没有复制第三方语料或测试夹具。

|资源|来源 / 许可证|实际使用|
|---|---|---|
|Praat TextGrid 文件格式|https://www.fon.hum.uva.nl/praat/manual/TextGrid_file_formats.html ；Praat 程序 GPL|仅阅读公开格式语义，不复制程序源码或文档段落|
|TextGridTools / tgt 1.5|https://github.com/hbuschme/TextGridTools ；GPL-3.0|在独立 Python 进程中读写原创合成数据，作为开发可选 oracle；不打包其代码|
|python-textgrid|https://github.com/kylebgorman/textgrid ；MIT|查阅公开解析接口/行为作为可行性参考，未复制实现|
|moonbitlang/core 0.10.16+b1a0e846e|https://github.com/moonbitlang/core ；Apache-2.0|导入官方 string、JSON、debug、UTF 编码模块；保持上游版权和许可证|
|NumPy 2.3.4|https://numpy.org/ ；BSD-3-Clause|tgt 测试环境的依赖，不属于 MoonBit 运行库|

`oracle_wbtest.mbt` 中的标注是 tools/differential.py 构造的原创合成数据，经外部程序序列化获得测试输入；非上游测试数据。外部参考的安装由用户/CI 使用其官方发行包和原许可证，仓库没有 vendor 目录。

AI 用于选题检索、设计、实现、调试、测试和文档。它不能证明绝对唯一、没有缺陷或官方验收通过；可复现依据为代码、测试与 CI。
