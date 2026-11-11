# 数据、运算与复杂度

时间单位由调用者统一，通常为秒。`Grid` 时间域为有限 `[start,end]`，`end > start` 且差值有限；`Tier::Intervals` 是同域分区；`Tier::Points` 是同域严格递增时间序列。点可在端点上，区间不可为零长度。空网格、空点层有效，空区间层无效。层名和标签允许空字符串、重名、多行。

所有会更改模型的入口先校验并构造新值；失败不修改源模型。`grid`、层构造器、`get_tier`、`copy_grid` 和 `select_tiers` 对嵌套可变数组复制。公开结构方便调用端组合，但调用端修改后可能失效；`validate` 可以显式检查。名称/计数和复制等只读结构函数不代替校验。

解析 `Limits.entries` 是跨所有层共享总数，`Limits.tokens` 仅适用于 TextGrid。decode 先限制字节再限制实际 UTF-16 单元，UTF-16 必须有 BOM 自动判别；无 BOM 按 UTF-8，不猜编码。文本中 BOM 可以作为分隔；字符串内保留原值。`encode_text` 是独立字符编码函数，不验证 TextGrid。

内部边界采用 `[start,end)`；网格最终 end 特例归最后区间。点窗口与裁剪是双端闭合。连续重叠只返回正时长，边界接触不算交集。拼接不自动合并相邻相同标签区间，调用 `coalesce` 可自行合并。它会保留覆盖时间，但会减少边界数。

`affine(g,origin,factor,offset)` 是 `origin + (t-origin)*factor + offset`，factor 必须正且有限。`scale` 围绕网格起点，`rebase` 用 `new_start+(t-old_start)` 避免大原点消去目标偏移。所有结果重新校验；数值精度不足导致的塌缩不会被静默接受。

重叠双指针算法 O(n+m)，点匹配 O(n+m)，解析/输出随输入与输出大小增长。`interval_at` 的二分查找 O(log n)，但公开入口每次先 O(n) 校验，因此总成本 O(n)；点窗口类似 O(n+k)。文档不把二分内部复杂度误称整个入口性能。编辑、变换、层复制为线性；标签统计/混淆表用哈希映射，期望线性；最长区间查询 O(n*limit)，内存 O(limit)。没有提供性能基准或速度优势宣称。

标签统计包含空标签；仅空字符串视为无标签，空格仍是标签。点统计的时长与覆盖率为 0。连续一致率与 Cohen kappa 按重叠时长加权、包含静音。浮点累计存在正常舍入误差。点匹配使用最早可匹配顺序，按时间最大化匹配数，不按标签配对，不最小化误差；记录 signed delta = hypothesis-reference 和 same_label。边界比较不包括网格外端点。
